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

public class View {
  internal var hWnd: HWND
  internal var `class`: WindowClass
  internal var style: WindowStyle

  // TODO(compnerd) handle set
  public private(set) var subviews: [View] = []
  public private(set) var superview: View?

  public var frame: Rect {
    willSet {
      let dpi: UINT = GetDpiForWindow(self.hWnd)
      let scale: Double = Double(dpi) / 96.0

      var r: RECT =
          RECT(from: newValue.applying(AffineTransform(scaleX: scale, y: scale)))
      if !AdjustWindowRectExForDpi(&r, self.style.base, false,
                                   self.style.extended, dpi) {
        log.warning("AdjustWindowRectExForDpi: \(GetLastError())")
      }

      SetWindowPos(self.hWnd, nil, r.left, r.top, r.right - r.left,
                   r.bottom - r.top, UINT(SWP_NOZORDER | SWP_FRAMECHANGED))
    }
  }

  internal init(frame: Rect, `class`: WindowClass, style: WindowStyle) {
    self.class = `class`
    _ = self.class.register()
    self.style = style

    self.frame = frame

    let bOverlappedWindow: Bool =
        style.base & DWORD(WS_OVERLAPPEDWINDOW) == DWORD(WS_OVERLAPPEDWINDOW)

    // We only check `x` because if `x` is `CW_USEDEFAULT` for a
    // `WS_OVERLAPPEDWINDOW` window, then `y` is ignored; if `y` is
    // `CW_USEDEFAULT`, `ShowWindow` will be invoked with `SW_SHOW`.
    if self.frame.origin.x == Double(CW_USEDEFAULT) && !bOverlappedWindow {
      log.warning("CW_USEDEFAULT is only valid on WS_OVERLAPPEDWINDOW windows")
      self.frame.origin = Point(x: 0, y: 0)
    }

    // We only check `width` because if `width` is CW_USEDEFAULT` for a
    // `WS_OVERLAPPEDWINDOW` window, `height` is ignored.
    if self.frame.size.width == Double(CW_USEDEFAULT) && !bOverlappedWindow {
      log.warning("CW_USEDEFAULT is only valid on WS_OVERLAPPEDWINDOW windows")
      self.frame.size = Size(width: 0, height: 0)
    }

    // Only request the window size, not the location, the location will be
    // mapped when reparenting.
    self.hWnd =
        CreateWindowExW(self.style.extended, self.class.name, "".LPCWSTR,
                        self.style.base,
                        Int32(bOverlappedWindow ? self.frame.origin.x : 0),
                        Int32(bOverlappedWindow ? self.frame.origin.y : 0),
                        Int32(self.frame.size.width),
                        Int32(self.frame.size.height),
                        nil, nil, GetModuleHandleW(nil), nil)

    // If `CW_USEDEFAULT` was used, query the actual allocated rect
    if frame.origin.x == Double(CW_USEDEFAULT) ||
       frame.size.width == Double(CW_USEDEFAULT) {
      var r: RECT = RECT()
      if !GetWindowRect(self.hWnd, &r) {
        log.warning("GetWindowRect: \(GetLastError())")
      }
      self.frame = Rect(from: r)
    }
  }

  deinit {
    _ = self.class.unregister()
  }

  public func addSubview(_ view: View) {
    if view.style.base & ~DWORD(WS_OVERLAPPEDWINDOW) == DWORD(WS_OVERLAPPEDWINDOW) {
      log.warning("child windows may not set WS_OVERLAPPEDWINDOW")
      return
    }

    if SetWindowLongPtrW(view.hWnd, GWL_STYLE,
                         LONG_PTR((view.style.base & ~DWORD(WS_POPUP)) | DWORD(WS_CHILD))) == 0 {
      SetWindowLongPtrW(view.hWnd, GWL_STYLE, LONG_PTR(view.style.base))
      return
    }
    view.style.base |= DWORD(WS_CHILD)
    // We *must* call `SetWindowPos` after the `SetWindowLong` to have the
    // changes take effect.
    if !SetWindowPos(view.hWnd, nil, 0, 0, 0, 0,
                     UINT(SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_FRAMECHANGED)) {
      log.warning("unable to update the window information: \(GetLastError())")
    }

    // Reparent the window
    SetParent(view.hWnd, self.hWnd)

    // Adjust the client rect
    var frame: RECT = RECT(from: view.frame)
    if view.superview == nil {
      _ = withUnsafeMutablePointer(to: &frame) {
        $0.withMemoryRebound(to: POINT.self, capacity: 2) {
          MapWindowPoints(GetParent(view.hWnd), self.hWnd, $0, 2)
        }
      }
    }
    view.frame = Rect(from: frame)

    view.superview = self
    subviews.append(view)
  }
}
