// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

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

    // Clear any existing menu.
    view.hMenu = nil

    let x = LOWORD(lParam), y = HIWORD(lParam)
    if let actions = interaction.delegate?
                        .contextMenuInteraction(interaction,
                                                configurationForMenuAtLocation: Point(x: x, y: y))?
                        .actionProvider?([]) {
    }
    let position: Point = interaction.location(in: view)
    _ = TrackPopupMenu(view.hMenu?.value, UINT(TPM_RIGHTBUTTON),
                       Int32(x), Int32(y), 0, view.hWnd, nil)

    return 0

  case UINT(WM_ERASEBKGND):
    guard let view = view, let brush = view.hbrBackground else{ break }

    let hDC: DeviceContextHandle =
        .init(referencing: HDC(bitPattern: UInt(wParam)))

    var rc: RECT = RECT()
    _ = GetClientRect(vie.hWnd, &rc)
    _ = FillRect(hDC.value, &rc, hbrBackground.value)

    return 1

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

private func WindowBasedTransform(for view: View?) -> AffineTransform {
  guard var view = view else { return .identity }

  var transform = AffineTransform.identity
  while let superview = view.superview {
    // Create a single transform that places this view in the coordinate
    // space of the view furthest up in its tree.
    transform = transform
        .concatenating(AffineTransform(translationX: -view.bounds.center.x,
                                       y: -view.bounds.center.y))
        .concatenating(view.transform)
        .concatenating(AffineTransform(translationX: view.center.x,
                                       y: view.center.y))
    view = superview
  }
  return transform
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
  /// Options for animating views using block objects.
  public struct AnimationOptions: OptionSet {
    public typealias RawValue = UInt

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension View.AnimationOptions {
  /// Lay out subviews at commit time so that they are animated along with their
  /// parent.
  public static var layoutSubviews: View.AnimationOptions {
    View.AnimationOptions(rawValue: 1 << 0)
  }

  /// Allow the user to interact with views while they are being animated.
  public static var allowUserInteraction: View.AnimationOptions {
    View.AnimationOptions(rawValue: 1 << 1)
  }

  /// Start the animation from the current setting associated with an already
  /// in-flight animation.
  ///
  /// If this key is not present, all in-flight animations are allowed to finish
  /// before the new animation is started. If another animation is not in
  /// flight, this key has no effect.
  public static var beginFromCurrentState: View.AnimationOptions {
    View.AnimationOptions(rawValue: 1 << 2)
  }

  /// Repeat the animation indefinitely.
  public static var `repeat`: View.AnimationOptions {
    View.AnimationOptions(rawValue: 1 << 3)
  }

  /// Run the animation backwards and forwards (must be combined with the repeat
  /// option).
  public static var autoreverse: View.AnimationOptions {
    View.AnimationOptions(rawValue: 1 << 4)
  }

  /// Force the animation to use the original duration value specified when the
  /// animation was submitted.
  public static var overrideInheritedDuration: View.AnimationOptions {
    View.AnimationOptions(rawValue: 1 << 5)
  }

  /// Force the animation to use the original curve value specified when the
  /// animation was submitted.
  ///
  /// If this key is not present, the animation inherits the curve of the
  /// in-flight animation, if any.
  public static var overrideInheritedCurve: View.AnimationOptions {
    View.AnimationOptions(rawValue: 1 << 6)
  }

  /// Animate the views by changing the property values dynamically and
  /// redrawing the view.
  public static var allowAnimatedContent: View.AnimationOptions {
    View.AnimationOptions(rawValue: 1 << 7)
  }

  /// Hide or show views during a view transition.
  ///
  /// When present, this key causes views to be hidden or shown (instead of
  /// removed or added) when performing a view transition. Both views must
  /// already be present in the parent view's hierarchy when using this key. If
  /// this key is not present, the to-view in a transition is added to, and the
  /// from-view is removed from, the parent view's list of subviews.
  public static var showHideTransitionViews: View.AnimationOptions {
    View.AnimationOptions(rawValue: 1 << 8)
  }

  /// The option to not inherit the animation type or any options.
  public static var overrideInheritedOptions: View.AnimationOptions {
    View.AnimationOptions(rawValue: 1 << 9)
  }

  /// Specify an ease-in ease-out curve, which causes the animation to begin
  /// slowly, accelerate through the middle of its duration, and then slow again
  /// before completing.
  public static var curveEaseInOut: View.AnimationOptions {
    View.AnimationOptions(rawValue: 0 << 16)
  }

  /// An ease-in curve causes the animation to begin slowly, and then speed up
  /// as it progresses.
  public static var curveEaseIn: View.AnimationOptions {
    View.AnimationOptions(rawValue: 1 << 16)
  }

  /// An ease-out curve causes the animation to begin quickly, and then slow as
  /// it completes.
  public static var curveEaseOut: View.AnimationOptions {
    View.AnimationOptions(rawValue: 2 << 16)
  }

  /// A linear animation curve causes an animation to occur evenly over its
  /// duration.
  public static var curveLinear: View.AnimationOptions {
    View.AnimationOptions(rawValue: 3 << 16)
  }

  internal static var transitionNone: View.AnimationOptions {
    View.AnimationOptions(rawValue: 0 << 20)
  }

  /// A transition that flips a view around its vertical axis from left to right
  /// (the left side of the view moves toward the front and right side toward
  /// the back).
  public static var transitionFlipFromLeft: View.AnimationOptions {
    View.AnimationOptions(rawValue: 1 << 20)
  }

  /// A transition that flips a view around its vertical axis from right to left
  /// (the right side of the view moves toward the front and left side toward
  /// the back).
  public static var transitionFlipFromRight: View.AnimationOptions {
    View.AnimationOptions(rawValue: 2 << 20)
  }

  /// A transition that curls a view up from the bottom.
  public static var transitionCurlUp: View.AnimationOptions {
    View.AnimationOptions(rawValue: 3 << 20)
  }

  /// A transition that curls a view down from the top.
  public static var transitionCurlDown: View.AnimationOptions {
    View.AnimationOptions(rawValue: 4 << 20)
  }

  /// A transition that dissolves from one view to the next.
  public static var transitionCrossDissolve: View.AnimationOptions {
    View.AnimationOptions(rawValue: 5 << 20)
  }

  /// A transition that flips a view around its horizontal axis from top to
  /// bottom (the top side of the view moves toward the front and the bottom
  /// side toward the back).
  public static var transitionFlipFromTop: View.AnimationOptions {
    View.AnimationOptions(rawValue: 6 << 20)
  }

  internal static var preferredFramesPersSecondDefault: View.AnimationOptions {
    View.AnimationOptions(rawValue: 0 << 24)
  }

  /// A frame rate of 30 frames per second.
  ///
  /// Specify this value to request a preferred frame rate. It's recommended
  /// that you use the default value unless you have identified a specific need
  /// for an explicit rate.
  public static var preferredFramesPerSecond30: View.AnimationOptions {
    View.AnimationOptions(rawValue: 7 << 24)
  }

  /// A frame rate of 60 frames per second.
  ///
  /// Specify this value to request a preferred frame rate. It's recommended
  /// that you use the default value unless you have identified a specific need
  /// for an explicit rate.
  public static var preferredFramesPerSecond60: View.AnimationOptions {
    View.AnimationOptions(rawValue: 3 << 24)
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

extension View {
  /// Specifies the supported animation curves.
  public enum AnimationCurve: Int {
    /// An ease-in ease-out curve causes the animation to begin slowly,
    /// accelerate through the middle of its duration, and then slow again
    /// before completing. This is the default curve for most animations.
    case easeInOut

    /// An ease-in curve causes the animation to begin slowly, and then speed up
    /// as it progresses.
    case easeIn

    /// An ease-out curve causes the animation to begin quickly, and then slow
    /// down as it completes.
    case easeOut

    /// A linear animation curve causes an animation to occur evenly over its
    /// duration.
    case linear
  }
}

extension View {
  /// The tint adjustment mode for the view.
  public enum TintAdjustmentMode: Int {
    /// The tint adjustment mode of the view is the same as its superview's tint
    /// adjustment mode (or `ViewTintAdjustmentModeNormal` if the view has no
    /// superview).
    case automatic

    /// The view's tintColor property returns the completely unmodified tint
    /// color of the view.
    case normal

    /// The view's `tintColor` property returns a desaturated, dimmed version
    /// of the view's original tint color.
    case dimmed
  }
}

/// An object that manages the content for a rectangular area on the screen.
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

  internal var hMenu: MenuHandle?

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
    client = client.scaled(for: GetDpiForWindow(self.hWnd), style: style)

    // Resize and Position the Window
    SetWindowPos(self.hWnd, nil,
                 CInt(client.origin.x), CInt(client.origin.y),
                 CInt(client.size.width), CInt(client.size.height),
                 UINT(SWP_NOZORDER | SWP_FRAMECHANGED))

    self.frame = frame
    self.bounds = Rect(origin: .zero, size: client.size)

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

  // MARK - Configuring a View's Visual Appearance

  internal var hbrBackground: BrushHandle?

  /// The view's background color.
  public var backgroundColor: Color? {
    didSet {
      switch self.backgroundColor {
      case .some(let color):
        self.hbrBackground = .init(owning: CreateSolidBrush(color.COLORREF))
      case .none:
        self.hbrBackground = nil
      }
    }
  }

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
      let client: Rect =
          self.frame.scaled(for: GetDpiForWindow(self.hWnd),
                            style: WindowStyle(DWORD(bitPattern: self.GWL_STYLE),
                                               DWORD(bitPattern: self.GWL_EXSTYLE)))

      // Resize and Position the Window
      _ = SetWindowPos(self.hWnd, nil,
                       CInt(client.origin.x), CInt(client.origin.y),
                       CInt(client.size.width), CInt(client.size.height),
                       UINT(SWP_NOZORDER | SWP_FRAMECHANGED))
    }
  }

  /// The bounds rectangle, which describes the view's location and size in its
  /// own coordinate system.
  public var bounds: Rect {
    didSet {
#if !ENABLE_TESTING
      fatalError("\(#function) not yet implemented")
#endif
    }
  }

  /// The center point of the view's frame rectangle
  public var center: Point {
    get { return Point(x: self.frame.midX, y: self.frame.midY) }
    set { self.frame = Rect(origin: Point(x: self.frame.origin.x - newValue.x,
                                          y: self.frame.origin.y - newValue.y),
                            size: self.frame.size) }
  }

  /// Specifies the transform applied to the view, relative to the center of its
  /// bounds.
  public var transform: AffineTransform = .identity {
    didSet {
#if !ENABLE_TESTING
      fatalError("\(#function) not yet implemented")
#endif
    }
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
    self.insertSubview(view, at: self.subviews.endIndex)
  }

  /// Moves the specified subview so that it appears on top of its siblings.
  public func bringSubviewToFront(_ view: View) {
    if let index = self.subviews.firstIndex(of: view) {
      self.subviews.append(self.subviews.remove(at: index))
    }
  }

  /// Moves the specified subview so that it appears behind its siblings.
  public func sendSubviewToBack(_ view: View) {
    if let index = self.subviews.lastIndex(of: view) {
      self.subviews.insert(self.subviews.remove(at: index),
                           at: self.subviews.startIndex)
    }
  }

  /// Unlinks the view from its superview and its window, and removes it from
  /// the responder chain.
  public func removeFromSuperview() {
    guard let superview = self.superview else { return }

    self.willMove(toSuperview: nil)

    superview.willRemoveSubview(self)

    // Reparent the window.
    guard let _ = SetParent(self.hWnd, nil) else {
      log.warning("SetParent: \(Error(win32: GetLastError()))")
      return
    }

    // Update the Window style.
    self.GWL_STYLE &= ~LONG(bitPattern: WS_POPUP | WS_CAPTION)
    self.GWL_STYLE &= ~WS_CHILD
    // FIXME(compnerd) can this be avoided somehow?
    if self is TextField || self is TextView || self is TableView {
      self.GWL_STYLE |= WinSDK.WS_BORDER
      self.GWL_EXSTYLE &= ~WS_EX_CLIENTEDGE
    }

    // We *must* call `SetWindowPos` after the `SetWindowLong` to have the
    // changes take effect.
    if !SetWindowPos(self.hWnd, nil, 0, 0, 0, 0,
                      UINT(SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_FRAMECHANGED)) {
      log.warning("SetWindowPos: \(Error(win32: GetLastError()))")
    }

    self.superview = nil

    if let index = superview.subviews.firstIndex(of: self) {
      superview.subviews.remove(at: index)
    }

    self.didMoveToSuperview()
  }

  /// Inserts a subview at the specified index.
  public func insertSubview(_ view: View, at index: Int) {
    // Notify the view that it is about to be reparented.
    view.willMove(toSuperview: self)

    // Notify the old parent that it is about to loose the child.
    view.superview?.willRemoveSubview(view)

    // Reparent the window.
    guard let _ = SetParent(view.hWnd, self.hWnd) else {
      log.warning("SetParent: \(Error(win32: GetLastError()))")
      return
    }

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
    view.GWL_STYLE &= ~LONG(bitPattern: WS_POPUP | WS_CAPTION)
    view.GWL_STYLE |= WS_CHILD
    // FIXME(compnerd) can this be avoided somehow?
    if view is TextField || view is TextView || view is TableView {
      view.GWL_STYLE |= WinSDK.WS_BORDER
      view.GWL_EXSTYLE &= ~WS_EX_CLIENTEDGE
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

    let client: Rect =
        view.frame.scaled(for: GetDpiForWindow(view.hWnd), style: style)

    // Resize and Position the Window
    _ = SetWindowPos(view.hWnd, nil,
                     CInt(client.origin.x), CInt(client.origin.y),
                     CInt(client.size.width), CInt(client.size.height),
                     UINT(SWP_NOZORDER | SWP_FRAMECHANGED))

    view.superview = self
    self.subviews.insert(view, at: index)

    // Notify any subclassed types for observation.
    self.didAddSubview(view)

    // Notify the view that it has been reparented.
    view.didMoveToSuperview()
  }

  /// Inserts a view above another view in the view hierarchy.
  public func insertSubview(_ view: View, aboveSubview subview: View) {
    let index: Array<View>.Index
    if let offset = self.subviews.firstIndex(of: subview) {
      index = self.subviews.index(after: offset)
    } else {
      index = self.subviews.endIndex
    }
    self.insertSubview(view, at: index)
  }

  /// Inserts a view below another view in the view hierarchy.
  public func insertSubview(_ view: View, belowSubview subview: View) {
    let index: Array<View>.Index
    if let offset = self.subviews.firstIndex(of: subview) {
      index = self.subviews.index(before: offset)
    } else {
      index = self.subviews.endIndex
    }
    self.insertSubview(view, at: index)
  }

  /// Exchanges the subviews at the specified indices.
  public func exchangeSubview(at index1: Int, withSubviewAt index2: Int) {
    self.subviews.swapAt(self.subviews.index(self.subviews.startIndex,
                                             offsetBy: index1),
                         self.subviews.index(self.subviews.startIndex,
                                             offsetBy: index2))
  }

  /// Returns a boolean value indicating whether the receiver is a subview of a
  /// given view or identical to that view.
  public func isDescendant(of view: View) -> Bool {
    var parent: View? = self
    while parent != nil {
      if parent == view { return true }
      parent = parent?.superview
    }
    return false
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
  public func didMoveToWindow() {
  }

  // MARK - Configuring Content Margins

  /// The default spacing to use when laying out content in a view, taking into
  /// account the current language direction.
  public var directionalLayoutMargins: DirectionalEdgeInsets =
      DirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0) {
    didSet {
      self.layoutMarginsDidChange()
    }
  }

  /// A boolean value indicating whether the current view also respects the
  /// margins of its superview.
  public var preservesSuperviewLayoutMargins: Bool = false

  /// Informs the view that its layout margins changed.
  public func layoutMarginsDidChange() {
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

  // MARK - Laying Out Subviews

  /// Lays out subviews.
  ///
  /// The default implementation uses any constraints you have set to determine
  /// the size and position of any subviews.
  ///
  /// Subclasses can override this method as needed to perform more precise
  /// layout of their subviews. You should override this method only if the
  /// autoresizing and constraint-based behaviors of the subviews do not offer
  /// the behavior you want. You can use your implementation to set the frame
  /// rectangles of your subviews directly.
  ///
  /// You should not call this method directly. If you want to force a layout
  /// update, call the `setNeedsLayout()` method instead to do so prior to the
  /// next drawing update. If you want to update the layout of your views
  /// immediately, call the `layoutIfNeeded()` method.
  public func layoutSubviews() {
    fatalError("\(#function) not yet implemented")
  }

  /// Invalidates the current layout of the receiver and triggers a layout
  /// update during the next update cycle.
  ///
  /// Call this method on your application's main thread when you want to adjust
  /// the layout of a view's subviews. This method makes a note of the request
  /// and returns immediately. Because this method does not force an immediate
  /// update, but instead waits for the next update cycle, you can use it to
  /// invalidate the layout of multiple views before any of those views are
  /// updated. This behavior allows you to consolidate all of your layout
  /// updates to one update cycle, which is usually better for performance.
  public func setNeedsLayout() {
    fatalError("\(#function) not yet implemented")
  }

  /// Lays out the subviews immediately, if layout updates are pending.
  ///
  /// Use this method to force the view to update its layout immediately. When
  /// using Auto Layout, the layout engine updates the position of views as
  /// needed to satisfy changes in constraints. Using the view that receives the
  /// message as the root view, this method lays out the view subtree starting
  /// at the root. If no layout updates are pending, this method exits without
  /// modifying the layout or calling any layout-related callbacks.
  public func layoutIfNeeded() {
    fatalError("\(#function) not yet implemented")
  }

  /// A boolean value that indicates whether the receiver depends on the
  /// constraint-based layout system.
  ///
  /// Custom views should override this to return true if they cannot layout
  /// correctly using autoresizing.
  public class var requiresConstraintBasedLayout: Bool { false }

  /// A boolean value that determines whether the view's autoresizing mask is
  /// translated into Auto Layout constraints.
  ///
  /// If this property's value is `true`, the system creates a set of
  /// constraints that duplicate the behavior specified by the view's
  /// autoresizing mask. This also lets you modify the view's size and location
  /// using the view's `frame`, `bounds`, or `center` properties, allowing you
  /// to create a static, frame-based layout within Auto Layout.
  ///
  /// Note that the autoresizing mask constraints fully specify the view's size
  /// and position; therefore, you cannot add additional constraints to modify
  /// this size or position without introducing conflicts. If you want to use
  /// Auto Layout to dynamically calculate the size and position of your view,
  /// you must set this property to `false`, and then provide a non ambiguous,
  /// nonconflicting set of constraints for the view.
  ///
  /// By default, the property is set to `true`.
  public var translatesAutoresizingMaskIntoConstraints: Bool = true

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

  // MARK - Converting Between View Coordinate Systems

  /// Converts a point from the receiver’s coordinate system to that of the
  /// specified view.
  public func convert(_ point: Point, to view: View?) -> Point {
    guard view != nil || self.window != nil else { return point }

    if let view = view {
      // If the view is itself, then the point is already in the correct
      // coordinate system.
      if view == self { return point }

      // In the case of an immediate relation to the view, just account for the
      // center offset and transform.
      if let superview = self.superview, superview == view {
        // `p - self.bounds.center` undos any translation done by the bounds of
        // `self`. Apply the current transform to the shifted point, and then
        // return the point relative to `self.center`.

        // +--- view ---+
        // | +- self -+ |
        // | |   p    | |
        // | +--------+ |
        // +------------+

        // `bounds` is in the coordinate space of self and `center` is in the
        // coordinate space of the superview.  In this case, the superview is
        // `view`, which is the destination coordinate space.  We simply map the
        // transformed point p from the coordinate space of `self` into the
        // destination coordinate space of `view` using `self.center`.
        return (point - self.bounds.center).applying(self.transform)
            + self.center
      } else if let superview = view.superview, superview == self {
        // `p - view.center` shifts the point relative to the center of `view`
        // as seen by `self`. Invert any transformations performed by `view` on
        // the point, and then return the point relative to the center of
        // `view.bounds.`

        // +--- self ---+
        // | +- view -+ |
        // | |   p    | |
        // | +--------+ |
        // +------------+

        // `center` is in the coordinate space of the superview. Because `self`
        // is the superview of `view`, `view.center` is in the coordinate space
        // of `self`.  We locate `point` in the coordinate space of `self`, undo
        // any local transformation, and then relocate it in the coordinate
        // space of the destination view.
        return (point - view.center).applying(view.transform.inverted())
            + view.bounds.center
      }
    }

    return point.applying(WindowBasedTransform(for: self))
                .applying(WindowBasedTransform(for: view).inverted())
  }

  /// Converts a point from the coordinate system of a given view to that of the
  /// receiver.
  public func convert(_ point: Point, from view: View?) -> Point {
    return view?.convert(point, to: self)
              ?? self.window?.convert(point, to: self)
              ?? point
  }

  /// Converts a rectangle from the receiver’s coordinate system to that of
  /// another view.
  public func convert(_ rect: Rect, to view: View?) -> Rect {
    guard view != nil || self.window != nil else { return rect }

    if let view = view {
      // If the view is itself, then the point is already in the correct
      // coordinate system.
      if view == self { return rect }

      // In the case of an immediate relation to the view, just account for the
      // center offset and transform.
      if let superview = self.superview, superview == view {
        // `r.offsetBy(dx: self.bounds.center.x, dy: self.bounds.center.y)`
        // undos any translation done by the bounds property of `self`. Apply
        // the current transform to the rect, and  then return the rect relative
        // to the center of `self`.

        // +--- view ---+
        // | +- self -+ |
        // | |   [r]  | |
        // | +--------+ |
        // +------------+

        // `bounds` is in the coordinate space of self and `center` is in the
        // coordinate space of the superview.  In this case, the superview is
        // `view`, which is the destination coordinate space.  We simply map the
        // transformed rect r from the coordinate space of `self` into the
        // destination coordinate space of `view` using `self.center`.
        return rect.offsetBy(dx: -self.bounds.center.x,
                             dy: -self.bounds.center.y)
            .applying(self.transform)
            .offsetBy(dx: self.center.x, dy: self.center.y)
      } else if let superview = view.superview, superview == self {
        // `r.offsetBy(dx: -view.center, dy: -view.center.y)` shifts the point
        // relative to the center of `view` as seen by `self`. Invert any
        // transformations performed by `view` on the rect, and then return the
        // rect relative to the bounds of `view`.

        // +--- self ---+
        // | +- view -+ |
        // | |   [r]  | |
        // | +--------+ |
        // +------------+

        // `center` is in the coordinate space of the superview. Because `self`
        // is the superview of `view`, `view.center` is in the coordinate space
        // of `self`.  We locate `rect` in the coordinate space of `self`, undo
        // any local transformation, and then relocate it in the coordinate
        // space of the destination view.
        return rect.offsetBy(dx: -view.center.x, dy: -view.center.y)
            .applying(view.transform.inverted())
            .offsetBy(dx: view.bounds.center.x, dy: view.bounds.center.y)
      }
    }

    return rect.applying(WindowBasedTransform(for: self))
               .applying(WindowBasedTransform(for: view).inverted())
  }

  /// Converts a rectangle from the coordinate system of another view to that of
  /// the receiver.
  public func convert(_ rect: Rect, from view: View?) -> Rect {
    return view?.convert(rect, to: self)
              ?? self.window?.convert(rect, to: self)
              ?? rect
  }

  // MARK - Responder Chain

  public override var next: Responder? {
    // If the view is the root view of a `ViewController`, the next responder is
    // the view controller; otherwise, the next responder is the view's
    // superview.

    // FIXME(compnerd) how do we determine if we are the root view of a view
    // controller?
    return self.superview
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
    return self.window?.windowScene?.screen.traitCollection ?? TraitCollection.current
  }
}
