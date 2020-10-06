/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

internal typealias WindowStyle = (base: DWORD, extended: DWORD)

private func ClientToWindow(size: inout Size, for style: WindowStyle) {
  var r: RECT =
      RECT(left: 0, top: 0, right: LONG(size.width), bottom: LONG(size.height))
  if !AdjustWindowRect(&r, style.base, false) {
    log.warning("AdjustWindowRectExForDpi: \(Error(win32: GetLastError()))")
  }
  size = Size(width: Double(r.right - r.left), height: Double(r.bottom - r.top))
}

private func ScaleClient(rect: inout Rect, for dpi: UINT, _ style: WindowStyle) {
  let scale: Double = Double(dpi) / Double(USER_DEFAULT_SCREEN_DPI)

  var r: RECT =
      RECT(from: rect.applying(AffineTransform(scaleX: scale, y: scale)))
  if !AdjustWindowRectExForDpi(&r, style.base, false, style.extended, dpi) {
    log.warning("AdjustWindowRectExForDpi: \(Error(win32: GetLastError()))")
  }
  rect = Rect(from: r)
}

public class View: Responder {
  private static let `class`: WindowClass =
      WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.View",
                  style: UInt32(CS_HREDRAW | CS_VREDRAW),
                  hbrBackground: GetSysColorBrush(COLOR_3DFACE),
                  hCursor: LoadCursorW(nil, IDC_ARROW))
  private static let style: WindowStyle = (base: 0, extended: 0)

  internal var hWnd: HWND!
  internal var win32: (window: (`class`: WindowClass, style: WindowStyle), _: ())

  internal var GWL_STYLE: LONG {
    get { GetWindowLongW(hWnd, WinSDK.GWL_STYLE) }
    set { SetWindowLongW(hWnd, WinSDK.GWL_STYLE, newValue) }
  }

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

  /// The frame rectangle, which describes the view's location and size in it's
  /// superview's coordinate system.
  public var frame: Rect {
    didSet {
      _ = SetWindowPos(self.hWnd, nil,
                       CInt(self.frame.origin.x), CInt(self.frame.origin.y),
                       CInt(self.frame.size.width), CInt(self.frame.size.height),
                       UINT(SWP_NOZORDER | SWP_FRAMECHANGED))
    }
  }

  /// Creating a View Object

  // FIXME(compnerd) should this be marked as a convenience initializer?
  public convenience init(frame: Rect) {
    self.init(frame: frame, class: View.class, style: View.style)
  }

  internal init(frame: Rect, `class`: WindowClass, style: WindowStyle,
                parent: HWND? = nil) {
    self.win32.window = (class: `class`, style: style)
    _ = self.win32.window.class.register()

    let bOverlappedWindow: Bool =
        style.base & DWORD(WS_OVERLAPPEDWINDOW) == DWORD(WS_OVERLAPPEDWINDOW)

    var client: Rect = frame

    // Convert client area to window rect
    ClientToWindow(size: &client.size, for: style)

    // TODO(compnerd) Convert client rect into display units

    // Only request the window size, not the location, the location will be
    // mapped when reparenting.
    self.hWnd =
        CreateWindowExW(self.win32.window.style.extended,
                        self.win32.window.class.name, nil,
                        self.win32.window.style.base,
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
        log.warning("GetClientRect: \(Error(win32: GetLastError()))")
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

    super.init()

    defer { self.font = Font.systemFont(ofSize: Font.systemFontSize) }
  }

  deinit {
    _ = DestroyWindow(self.hWnd)
    _ = self.win32.window.class.unregister()
  }

  /// Managing the View Hierarchy

  public private(set) var superview: View?
  public private(set) var subviews: [View] = []
  public private(set) var window: Window?

  public func addSubview(_ view: View) {
    // Reparent the window
    guard let hPreviousParent: HWND = SetParent(view.hWnd, self.hWnd) else {
      log.warning("SetParent: \(Error(win32: GetLastError()))")
      return
    }

    if SetWindowLongPtrW(view.hWnd, WinSDK.GWL_STYLE,
                         LONG_PTR((view.win32.window.style.base & ~DWORD(WS_POPUP)) | DWORD(WS_CHILD))) == 0 {
      log.warning("SetWindowLongPtrW: \(Error(win32: GetLastError()))")
      // TODO(compnerd) check for error
      _ = SetWindowLongPtrW(view.hWnd, WinSDK.GWL_STYLE, LONG_PTR(view.win32.window.style.base))
      return
    }
    view.win32.window.style.base = (view.win32.window.style.base & ~DWORD(WS_POPUP)) | DWORD(WS_CHILD)
    // We *must* call `SetWindowPos` after the `SetWindowLong` to have the
    // changes take effect.
    if !SetWindowPos(view.hWnd, nil, 0, 0, 0, 0,
                     UINT(SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_FRAMECHANGED)) {
      log.warning("SetWindowPos: \(Error(win32: GetLastError()))")
    }

    SetWindowPos(view.hWnd, nil,
                 CInt(view.frame.origin.x), CInt(view.frame.origin.y),
                 CInt(view.frame.size.width), CInt(view.frame.size.height),
                 UINT(SWP_NOZORDER | SWP_FRAMECHANGED))

    view.superview = self
    subviews.append(view)
  }

  // Responder Chain
  public override var next: Responder? {
    if let parent = self.superview { return parent }
    // if let vc = self.viewController { return vc }
    if let window = self.window { return window }
    return Application.shared
  }
}
