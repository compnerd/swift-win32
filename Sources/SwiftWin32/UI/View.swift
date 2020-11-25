/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

private let SwiftViewProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let view: View? = unsafeBitCast(dwRefData, to: AnyObject.self) as? View
  switch uMsg {
  case UINT(WM_CONTEXTMENU):
    // TODO handle popup menu events
    return 0
  default:
    break
  }
  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

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
  internal var WndClass: WindowClass

  internal var GWL_STYLE: LONG {
    get { GetWindowLongW(self.hWnd, WinSDK.GWL_STYLE) }
    set { _ = SetWindowLongW(self.hWnd, WinSDK.GWL_STYLE, newValue) }
  }

  internal var GWL_EXSTYLE: LONG {
    get { GetWindowLongW(self.hWnd, WinSDK.GWL_EXSTYLE) }
    set { _ = SetWindowLongW(self.hWnd, WinSDK.GWL_EXSTYLE, newValue) }
  }

  internal var font: Font? {
    didSet {
      SendMessageW(self.hWnd, UINT(WM_SETFONT),
                   unsafeBitCast(self.font?.hFont.value, to: WPARAM.self),
                   LPARAM(1))
    }
  }

  // MARK - Configuring a View's Visual Appearance

  /// A boolean that determines if the view is hidden.
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

  // MARK - Configuring the Bounds and Frame Rectangles

  /// The frame rectangle, which describes the view's location and size in it's
  /// superview's coordinate system.
  public var frame: Rect {
    didSet {
      // Scale window for DPI
      var client: Rect = self.frame
      ScaleClient(rect: &client, for: GetDpiForWindow(self.hWnd),
                  WindowStyle(DWORD(bitPattern: self.GWL_STYLE),
                              DWORD(bitPattern: self.GWL_EXSTYLE)))

      // Resize and Position the Window
      _ = SetWindowPos(self.hWnd, nil,
                       CInt(client.origin.x), CInt(client.origin.y),
                       CInt(client.size.width), CInt(client.size.height),
                       UINT(SWP_NOZORDER | SWP_FRAMECHANGED))
    }
  }

  /// The center point of the view's frame rectangle
  public var center: Point {
    get { return Point(x: self.frame.midX, y: self.frame.midY) }
    set { self.frame = Rect(origin: Point(x: self.frame.origin.x - newValue.x,
                                          y: self.frame.origin.y - newValue.y),
                            size: self.frame.size) }
  }

  // MARK - Creating a View Object

  // FIXME(compnerd) should this be marked as a convenience initializer?

  /// Initializes and returns a newly allocated view object with the specified
  /// frame rectangle.
  public convenience init(frame: Rect) {
    self.init(frame: frame, class: View.class, style: View.style)
  }

  internal init(frame: Rect, `class`: WindowClass, style: WindowStyle,
                parent: HWND? = nil) {
    self.WndClass = `class`
    _ = self.WndClass.register()

    let bOverlappedWindow: Bool =
        style.base & DWORD(WS_OVERLAPPEDWINDOW) == DWORD(WS_OVERLAPPEDWINDOW)

    var client: Rect = frame

    // Convert client area to window rect
    ClientToWindow(size: &client.size, for: style)

    // TODO(compnerd) Convert client rect into display units

    // Only request the window size, not the location, the location will be
    // mapped when reparenting.
    self.hWnd =
        CreateWindowExW(style.extended, self.WndClass.name, nil, style.base,
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

    _ = SetWindowSubclass(self.hWnd, SwiftViewProc, UINT_PTR.max,
                          unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))

    if !RegisterTouchWindow(self.hWnd, 0) {
      log.error("RegisterTouchWindow: \(Error(win32: GetLastError()))")
    }

    defer { self.font = Font.systemFont(ofSize: Font.systemFontSize) }
  }

  deinit {
    _ = UnregisterTouchWindow(self.hWnd)
    _ = DestroyWindow(self.hWnd)
    _ = self.WndClass.unregister()
  }

  // MARK - Configuring the Event-Related Behaviour

  /// A boolean value that determines whether user events are ignored and removed
  /// from the event queue.
  public var isUserInteractionEnabled: Bool {
    get { return IsWindowEnabled(self.hWnd) }
    set { _ = EnableWindow(self.hWnd, newValue) }
  }

  // MARK - Managing the View Hierarchy

  public private(set) var superview: View?
  public private(set) var subviews: [View] = []
  public private(set) var window: Window?

  public func addSubview(_ view: View) {
    // Notify the view that it is about to be reparented.
    view.willMove(toSuperview: self)

    // Notify the old parent that it is about to loose the child.
    view.superview?.willRemoveSubview(view)

    // MSDN:
    // For compatibility reasons, `SetParent` does not modify the `WS_CHILD` or
    // `WS_POPUP` window styles of the window whose parent is being changed.
    // Therefore, if `hWndNewParent` is `NULL`, you should also clear the
    // `WS_CHILD` bit and set the `WS_POPUP` style after calling `SetParent`.
    // Conversely, if `hWndNewParent` is not `NULL` and the window was
    // previously a child of the desktop, you should clear the `WS_POPUP` style
    // and set the `WS_CHILD` style before calling `SetParent`.
    //
    // When you change the parent, you should synchronize the `UISTATE` of both
    // windows.  For more information, see `WM_CHANGEUISTATE` and
    // `WM_UPDATEUISTATE`.

    // Update the window style.
    view.GWL_STYLE &= ~LONG(bitPattern: WS_POPUP | DWORD(WS_CAPTION))
    view.GWL_STYLE |= WS_CHILD
    // FIXME(compnerd) can this be avoided somehow?
    if view is TextField || view is TextView || view is TableView {
      view.GWL_STYLE |= WS_BORDER
      view.GWL_EXSTYLE &= ~WS_EX_CLIENTEDGE
    }

    // Reparent the window.
    guard let _ = SetParent(view.hWnd, self.hWnd) else {
      log.warning("SetParent: \(Error(win32: GetLastError()))")
      return
    }

    // We *must* call `SetWindowPos` after the `SetWindowLong` to have the
    // changes take effect.
    if !SetWindowPos(view.hWnd, nil, 0, 0, 0, 0,
                     UINT(SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_FRAMECHANGED)) {
      log.warning("SetWindowPos: \(Error(win32: GetLastError()))")
    }

    // TODO(compnerd) check for error
    _ = SetWindowPos(view.hWnd, nil,
                     CInt(view.frame.origin.x), CInt(view.frame.origin.y),
                     CInt(view.frame.size.width), CInt(view.frame.size.height),
                     UINT(SWP_NOZORDER | SWP_FRAMECHANGED))

    view.superview = self
    subviews.append(view)

    // Notify any subclassed types for observation.
    self.didAddSubview(view)

    // Notify the view that it has been reparented.
    view.didMoveToSuperview()
  }

  // MARK - Managing the View's Constraints

  /// The constraints held by the view.
  public private(set) var constraints: [LayoutConstraint] = []

  /// Adds a constraint on the layout of the receiving view or its subviews.
  public func addConstraint(_ constraint: LayoutConstraint) {
  }

  /// Removes the specified constraint from the view.
  public func removeConstraint(_ constraint: LayoutConstraint) {
  }

  /// Removes the specified constraints from the view.
  public func removeConstraints(_ constraints: [LayoutConstraint]) {
  }

  // MARK - Create Constraint Using Layout Constraint

  /// A layout anchor representing the bottom edge of the view's frame.
  public var bottomAnchor: LayoutYAxisAnchor {
    LayoutYAxisAnchor(item: self, attribute: .bottom)
  }

  /// A layout anchor representing the horizontal center of the view's frame.
  public var centerXAnchor: LayoutXAxisAnchor {
    LayoutXAxisAnchor(item: self, attribute: .centerX)
  }

  /// A layout anchor representing the vertical center of the view's frame.
  public var centerYAnchor: LayoutYAxisAnchor {
    LayoutYAxisAnchor(item: self, attribute: .centerY)
  }

  /// A layout anchor representing the baseline for the topmost line of text in
  /// the view.
  public var firstBaselineAnchor: LayoutYAxisAnchor {
    LayoutYAxisAnchor(item: self, attribute: .firstBaseline)
  }

  /// A layout anchor representing the height of the view's frame.
  public var heightAnchor: LayoutDimension {
    LayoutDimension(item: self, attribute: .height)
  }

  /// A layout anchor representing the baseline for the bottommost line of text
  /// in the view.
  public var lastBaselineAnchor: LayoutYAxisAnchor {
    LayoutYAxisAnchor(item: self, attribute: .lastBaseline)
  }

  /// A layout anchor representing the leading edge of the view's frame.
  public var leadingAnchor: LayoutXAxisAnchor {
    LayoutXAxisAnchor(item: self, attribute: .leading)
  }

  /// A layout anchor representing the left edge of the view's frame.
  public var leftAnchor: LayoutXAxisAnchor {
    LayoutXAxisAnchor(item: self, attribute: .left)
  }

  /// A layout anchor representing the right edge of the view's frame.
  public var rightAnchor: LayoutXAxisAnchor {
    LayoutXAxisAnchor(item: self, attribute: .right)
  }

  /// A layout anchor representing the top edge of the view's frame.
  public var topAnchor: LayoutYAxisAnchor {
    LayoutYAxisAnchor(item: self, attribute: .top)
  }

  /// A layout anchor representing the top edge of the view's frame.
  public var trailingAnchor: LayoutXAxisAnchor {
    LayoutXAxisAnchor(item: self, attribute: .trailing)
  }

  /// A layout anchor representing the trailing edge of the view's frame.
  public var widthAnchor: LayoutDimension {
    LayoutDimension(item: self, attribute: .width)
  }

  // MARK - Observing View-Related Changes

  /// Informs the view that a subview was added.
  public func didAddSubview(_ subview: View) {
  }

  /// Informs the view that a subview is about to be removed.
  public func willRemoveSubview(_ subview: View) {
  }

  /// Informs the view that its superview is about to change to the specified
  /// superview.
  public func willMove(toSuperview: View?) {
  }

  /// Informs the view that its superview changed.
  public func didMoveToSuperview() {
  }

  // MARK - Responder Chain
  public override var next: Responder? {
    if let parent = self.superview { return parent }
    return nil
  }

  // MARK - Identifying the View at Runtime

  /// An integer that you can use to identify view objects in your application.
  public var tag: Int = 0

  /// Returns the view whose tag matches the specified value.
  public func viewWithTag(_ tag: Int) -> View? {
    if self.tag == tag { return self }
    // TODO(compnerd) this is a poor equivalent of a level-order traversal of
    // the view hierachy.  We could implement this properly, but, this provides
    // a functional implementation that is brief and is unlikely to be a hot
    // path.  Convert to a proper level-order traversal.
    return self.subviews.first(where: { $0.tag == tag }) ??
        self.subviews.lazy.compactMap { $0.viewWithTag(tag) }.first
  }

  // MARK - Trait Environment

  // NOTE: this must be in the class to permit deviced types to override the
  // notification.
  public func traitCollectionDidChange(_ previousTraitCollection: TraitCollection?) {
  }
}

extension View: Equatable {
  public static func ==(_ lhs: View, _ rhs: View) -> Bool {
    return lhs.hWnd == rhs.hWnd
  }
}

extension View: TraitEnvironment {
  public var traitCollection: TraitCollection {
    return self.window?.screen.traitCollection ?? TraitCollection.current
  }
}
