/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

import WinSDK

internal typealias WindowStyle = (base: DWORD, extended: DWORD)

private func ClientToWindow(size: inout Size, for style: WindowStyle) {
  var r: RECT =
      RECT(left: 0, top: 0, right: LONG(size.width), bottom: LONG(size.height))
  if !AdjustWindowRect(&r, style.base, false) {
    log.warning("AdjustWindowRectExForDpi: \(GetLastError())")
  }
  size = Size(width: Double(r.right - r.left), height: Double(r.bottom - r.top))
}

private func ScaleClient(rect: inout Rect, for dpi: UINT, _ style: WindowStyle) {
  let scale: Double = Double(dpi) / Double(USER_DEFAULT_SCREEN_DPI)

  var r: RECT =
      RECT(from: rect.applying(AffineTransform(scaleX: scale, y: scale)))
  if !AdjustWindowRectExForDpi(&r, style.base, false, style.extended, dpi) {
    log.warning("AdjustWindowRectExForDpi: \(GetLastError())")
  }
  rect = Rect(from: r)
}

public class View {
  internal var hWnd: HWND!
  internal var window: (`class`: WindowClass, style: WindowStyle)

  // TODO(compnerd) handle set
  public private(set) var subviews: [View] = []
  public private(set) var superview: View?

  internal var font: Font? {
    didSet {
      SendMessageW(self.hWnd, UINT(WM_SETFONT),
                   unsafeBitCast(self.font?.hFont.value, to: WPARAM.self),
                   LPARAM(1))
    }
  }

  /// Configuring a View's Visual Appearance
  public var isHidden: Bool {
    get { IsWindowVisible(self.hWnd) }
    set(hidden) {
      let pEnumFunc: WNDENUMPROC = { (hWnd, lParam) -> WindowsBool in
        ShowWindow(hWnd, CInt(lParam))
        return true
      }
      _ = EnumChildWindows(self.hWnd, pEnumFunc,
                           LPARAM(hidden ? SW_HIDE : SW_RESTORE))
      ShowWindow(self.hWnd, hidden ? SW_HIDE : SW_RESTORE)
    }
  }

  /// Configuring the Bounds and Frame Rectangles
  public let frame: Rect

  internal init(frame: Rect, `class`: WindowClass, style: WindowStyle,
                parent: HWND? = nil) {
    self.window = (class: `class`, style: style)
    _ = self.window.class.register()

    let bOverlappedWindow: Bool =
        style.base & DWORD(WS_OVERLAPPEDWINDOW) == DWORD(WS_OVERLAPPEDWINDOW)

    var client: Rect = frame

    // Convert client area to window rect
    ClientToWindow(size: &client.size, for: style)

    // TODO(compnerd) Convert client rect into display units

    // Only request the window size, not the location, the location will be
    // mapped when reparenting.
    self.hWnd =
        CreateWindowExW(self.window.style.extended, self.window.class.name, nil,
                        self.window.style.base,
                        Int32(bOverlappedWindow ? client.origin.x : 0),
                        Int32(bOverlappedWindow ? client.origin.y : 0),
                        Int32(client.size.width),
                        Int32(client.size.height),
                        parent, nil, GetModuleHandleW(nil), nil)!

    // If `CW_USEDEFAULT` was used, query the actual allocated rect
    if frame.origin.x == Double(CW_USEDEFAULT) ||
       frame.size.width == Double(CW_USEDEFAULT) {
      var r: RECT = RECT()
      if !GetClientRect(self.hWnd, &r) {
        log.warning("GetClientRect: \(GetLastError())")
      }
      _ = withUnsafeMutablePointer(to: &r) { [hWnd = self.hWnd] in
        $0.withMemoryRebound(to: POINT.self, capacity: 2) {
          MapWindowPoints(hWnd, nil, $0, 2)
        }
      }
      client = Rect(from: r)
    }

    // Scale window for DPI
    ScaleClient(rect: &client, for: GetDpiForWindow(self.hWnd), style)

    // Resize and Position the Window
    SetWindowPos(self.hWnd, nil,
                 CInt(client.origin.x), CInt(client.origin.y),
                 CInt(client.size.width), CInt(client.size.height),
                 UINT(SWP_NOZORDER | SWP_FRAMECHANGED))

    self.frame = client

    defer { self.font = Font.systemFont(ofSize: Font.systemFontSize) }
  }

  deinit {
    _ = DestroyWindow(self.hWnd)
    _ = self.window.class.unregister()
  }

  public func addSubview(_ view: View) {
    // Reparent the window
    guard let hPreviousParent: HWND = SetParent(view.hWnd, self.hWnd) else {
      log.warning("SetParent: \(GetLastError())")
      return
    }

    if SetWindowLongPtrW(view.hWnd, GWL_STYLE,
                         LONG_PTR((view.window.style.base & ~DWORD(WS_POPUP)) | DWORD(WS_CHILD))) == 0 {
      log.warning("SetWindowLongPtrW: \(GetLastError())")
      // TODO(compnerd) check for error
      _ = SetWindowLongPtrW(view.hWnd, GWL_STYLE, LONG_PTR(view.window.style.base))
      return
    }
    view.window.style.base = (view.window.style.base & ~DWORD(WS_POPUP)) | DWORD(WS_CHILD)
    // We *must* call `SetWindowPos` after the `SetWindowLong` to have the
    // changes take effect.
    if !SetWindowPos(view.hWnd, nil, 0, 0, 0, 0,
                     UINT(SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_FRAMECHANGED)) {
      log.warning("SetWindowPos: \(GetLastError())")
    }

    SetWindowPos(view.hWnd, nil,
                 CInt(view.frame.origin.x), CInt(view.frame.origin.y),
                 CInt(view.frame.size.width), CInt(view.frame.size.height),
                 UINT(SWP_NOZORDER | SWP_FRAMECHANGED))

    view.superview = self
    subviews.append(view)
  }
}
