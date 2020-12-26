/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

extension View {
  internal func interaction<InteractionType: Interaction>() -> InteractionType? {
    // TODO: how do we handle overlapping entries in the `interactions` array?
    if let interaction = interactions.first(where: { $0 is InteractionType }) {
      return interaction as? InteractionType
    }
    return nil
  }
}

private let SwiftViewProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let view: View? = unsafeBitCast(dwRefData, to: AnyObject.self) as? View

  switch uMsg {
  case UINT(WM_CONTEXTMENU):
    guard let view = view,
          let interaction: ContextMenuInteraction = view.interaction() else {
      break
    }

    let x = LOWORD(lParam), y = HIWORD(lParam)

    // Clear any existing menu.
    view.menu = nil

    if let actions = interaction.delegate?
                        .contextMenuInteraction(interaction,
                                                configurationForMenuAtLocation: Point(x: x, y: y))?
                        .actionProvider?([]) {
      // TODO: handle a possible failure in `CreatePopupMenu`
      view.menu = Win32Menu(MenuHandle(owning: CreatePopupMenu()),
                            items: actions.children)
      _ = TrackPopupMenu(view.menu?.hMenu.value, UINT(TPM_RIGHTBUTTON),
                        Int32(x), Int32(y), 0, view.hWnd, nil)
    }

    return 0
  case UINT(WM_COMMAND):
    // TODO: handle menu actions
    break
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

extension View {
  /// Options to specify how a view adjusts its content when its size changes.
  public enum ContentMode: Int {
    /// Scale the content to fit the size of itself by changing the aspect ratio
    /// of the content if necessary.
    case scaleToFill

    /// Scale the content to fit the size of the view by maintaining the aspect
    /// ratio.  Any remaining area of the view's bounds is transparent.
    case scaleAspectFill

    /// Scale the content to fill the size of the view.  Some portion of the
    /// content may be clipped to fill the view's bounds.
    case redraw

    /// center the content in the view's bounds, keeping the proportions the
    /// same.
    case center

    /// Center the content aligned to the top in the view's bounds.
    case top

    /// Center the content aligned at the bottom in the view's bounds.
    case bottom

    /// Align the content on the left of the view.
    case left

    /// Align the content on the right of the view.
    case right

    /// Align the content in the top-left corner of the view.
    case topLeft

    /// Align the content in the top-right corner of the view.
    case topRight

    /// Align the content in the bottom-left corner of the view.
    case bottomLeft

    /// Align the content in the bottom-right corner of the view.
    case bottomRight
  }
}

extension View {
  /// Options for automatic view resizing.
  public struct AutoresizingMask: OptionSet {
    public let rawValue: UInt

    public init(rawValue: UInt) {
      self.rawValue = rawValue
    }
  }
}

extension View.AutoresizingMask {
  public static var none: View.AutoresizingMask {
    View.AutoresizingMask(rawValue: 0 << 0)
  }

  /// Resizing performed by expanding or shrinking a view in the direction of
  /// the left margin.
  public static var flexibleLeftMargin: View.AutoresizingMask {
    View.AutoresizingMask(rawValue: 1 << 0)
  }

  /// Resizing performed by expanding or shrinking a view's width.
  public static var flexibleWidth: View.AutoresizingMask {
    View.AutoresizingMask(rawValue: 1 << 1)
  }

  /// Resizing performed by expanding or shrinking a view in the direction of
  /// the right margin.
  public static var flexibleRightMargin: View.AutoresizingMask {
    View.AutoresizingMask(rawValue: 1 << 2)
  }

  /// Resizing performed by expanding or shrinking a view in the direction of
  /// the top margin.
  public static var flexibleTopMargin: View.AutoresizingMask {
    View.AutoresizingMask(rawValue: 1 << 3)
  }

  /// Resizing performed by expanding or shrinking a view's height.
  public static var flexibleHeight: View.AutoresizingMask {
    View.AutoresizingMask(rawValue: 1 << 4)
  }

  /// Resizing performed by expanding or shrinking a view in the direction of
  /// the bottom margin.
  public static var flexibleBottomMargin: View.AutoresizingMask {
    View.AutoresizingMask(rawValue: 1 << 5)
  }
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

  internal var menu: Win32Menu? = nil

  // MARK - Configuring a View's Visual Appearance

  /// The view's background color.
  public var backgroundColor: Color?

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

    self.frame = frame

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

  // MARK - Managing the View Hierarchy

  /// The receiver's superview, or `nil` if it has none.
  public private(set) weak var superview: View?

  /// The receiver's immediate subviews.
  public private(set) var subviews: [View] = []

  /// The receiver's window object, or `nil` if it has none.
  public private(set) weak var window: Window?

  /// Add a subview to the end of the reciever's list of subviews.
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

    // Scale window for DPI
    let style: WindowStyle =
        WindowStyle(DWORD(bitPattern: view.GWL_STYLE),
                    DWORD(bitPattern: view.GWL_EXSTYLE))

    var client: Rect = view.frame
    ScaleClient(rect: &client, for: GetDpiForWindow(view.hWnd), style)

    // Resize and Position the Window
    _ = SetWindowPos(view.hWnd, nil,
                     CInt(client.origin.x), CInt(client.origin.y),
                     CInt(client.size.width), CInt(client.size.height),
                     UINT(SWP_NOZORDER | SWP_FRAMECHANGED))

    view.superview = self
    subviews.append(view)

    // Notify any subclassed types for observation.
    self.didAddSubview(view)

    // Notify the view that it has been reparented.
    view.didMoveToSuperview()
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

  /// Informs the view that its window object is about to change.
  public func willMove(toWindow: Window?) {
  }

  /// Informs the view that its window object changed.
  public func diMoveToWindow() {
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

  // MARK - Configuring the Resizing Behaviour

  // Determine how a view lays out its content when its bounds changes.
  public var contentMode: View.ContentMode = .scaleToFill

  /// Asks the view to calculate and return the size that best fits the
  /// specified size.
  public func sizeThatFits(_ size: Size) -> Size {
    return self.frame.size
  }

  /// Resizes and moves the receiver view so it just encloses its subviews.
  public func sizeToFit() {
    fatalError("\(#function) not yet implemented")
  }

  /// Determines whether the receiver automatically resizes its subviews when
  /// its bounds changes.
  public var autoresizesSubviews: Bool = true

  /// A bitmask that determines how the receiver resizes itself when its
  /// superview's bounds changes.
  public var autoresizingMask: View.AutoresizingMask = .none

  // MARK - Drawing and Updating the View

  /// Draws the receiver's image within the passed-in rectangle.
  public func draw(_ rect: Rect) {
    fatalError("\(#function) not yet implemented")
  }

  /// Mark the receiver's entire bounds rectangle as needing to be redrawn.
  public func setNeedsDisplay() {
    fatalError("\(#function) not yet implemented")
  }

  /// Marks the specified rectangle of the receiver as needing to be redrawn.
  public func setNeedsDisplay(_ rect: Rect) {
    fatalError("\(#function) not yet implemented")
  }

  /// The scale factor applied to the view.
  public var contentScaleFactor: Float {
    get { 1.0 }
    set { fatalError("\(#function) not yet implemented") }
  }

  // MARK - Adding and Removing Interactions

  /// Adds an interaction to the view.
  public func addInteraction(_ interaction: Interaction) {
    interaction.willMove(to: self)
    interaction.view?.interactions.removeAll(where: { $0 === interaction })
    interactions.append(interaction)
    interaction.didMove(to: self)
  }

  /// Removes an interaction from the view.
  public func removeInteraction(_ interaction: Interaction) {
    interaction.willMove(to: nil)
    self.interactions.removeAll(where: { $0 === interaction })
    interaction.didMove(to: nil)
  }

  /// The array of interactions for the view.
  public var interactions: [Interaction] = []

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

  // MARK - Responder Chain

  public override var next: Responder? {
    if let parent = self.superview { return parent }
    return nil
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
