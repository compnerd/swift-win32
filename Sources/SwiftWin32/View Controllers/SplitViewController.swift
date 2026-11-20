// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

@_implementationOnly import CRT

extension SplitViewController {
  /// Constants that describe the number of columns the split view interface
  /// displays.
  public enum Style: Int {
    /// The split view interface uses the classic split view style.
    case unspecified

    /// The split view interface displays two columns.
    case doubleColumn

    /// The split view interface displays three columns.
    case tripleColumn
  }
}

extension SplitViewController {
  /// Constants that describe the possible arrangements for a split view
  /// interface.
  public enum DisplayMode: Int {
    /// The split view controller automatically decides the most appropriate
    /// display mode based on the device and the current app size.
    ///
    /// This constant represents the default value of the `preferredDisplayMode`
    /// property. Although you can assign the property this constant as its
    /// value, the `displayMode` property never reports it.
    case automatic

    /// Only the secondary view controller is shown onscreen.
    ///
    /// The primary and supplementary view controllers are offscreen.
    ///
    /// This display mode is available for any split behavior.
    case secondaryOnly

    /// One sidebar appears side-by-side with the secondary view controller.
    ///
    /// This display mode shows one sidebar tiled next to the secondary view
    /// controller. The sidebar shown is the primary column for
    /// `SplitViewController.Style.doubleColumn` interfaces and the
    /// supplementary column for `SplitViewController.Style.tripleColumn`
    /// interfaces. The sidebar is displayed on the side specified by
    /// `primaryEdge`, followed by the secondary view controller. The secondary
    /// view controller's view is fully interactive.
    ///
    /// This display mode is available for the
    /// `SplitViewController.SplitBehavior.tile` and
    /// `SplitViewController.SplitBehavior.displace` split behaviors.
    case oneBesideSecondary

    /// One sidebar is layered on top of the secondary view controller, leaving
    /// the secondary view controller partially visible.
    ///
    /// This display mode shows one sidebar layered on top of the secondary view
    /// controller, partially obscuring it. The sidebar shown is the primary
    /// column for `SplitViewController.Style.doubleColumn` interfaces and the
    /// supplementary column for `SplitViewController.Style.tripleColumn`
    /// interfaces. The secondary view controller is dimmed out, preventing
    /// interaction with its view. Touching the dimmed view dismisses the
    /// overlay and returns the interface to the
    /// `SplitViewController.DisplayMode.secondaryOnly` display mode.
    ///
    /// This display mode is available for the
    /// `SplitViewController.SplitBehavior.overlay` split behavior.
    case oneOverSecondary

    /// Two sidebars appear side-by-side with the secondary view controller.
    ///
    /// This display mode is only available for
    /// `SplitViewController.Style.tripleColumn` interfaces.
    ///
    // This display mode shows both sidebars tiled next to the secondary view
    /// controller. The primary view controller is displayed on the side
    /// specified by `primaryEdge`, followed by the supplementary view
    /// controller, and finally the secondary view controller. The secondary
    /// view controller's view is fully interactive.
    ///
    /// This display mode is available for the
    /// `SplitViewController.SplitBehavior.tile` split behavior.
    case twoBesideSecondary

    /// Two sidebars are layered on top of the secondary view controller,
    /// leaving the secondary view controller partially visible.
    ///
    /// This display mode is only available for
    /// `SplitViewController.Style.tripleColumn` interfaces.
    ///
    /// This display mode shows both sidebars layered on top of the secondary
    /// view controller, partially obscuring it. The secondary view controller
    /// is dimmed out, preventing interaction with its view. Touching the dimmed
    /// view dismisses the overlay and returns the interface to the
    /// `SplitViewController.DisplayMode.secondaryOnly` display mode.
    ///
    /// The interactive gesture can move the interface freely through
    /// `SplitViewController.DisplayMode.oneOverSecondary` to
    /// `SplitViewController.DisplayMode.secondaryOnly` and back, stopping at
    /// any of the display modes depending on the user interaction.
    ///
    /// This display mode is available for the
    /// `SplitViewController.SplitBehavior.overlay` split behavior.
    case twoOverSecondary

    /// Two sidebars displace the secondary view controller instead of
    /// overlapping it, moving it partially offscreen.
    ///
    /// This display mode is only available for
    /// `SplitViewController.Style.tripleColumn` interfaces.
    ///
    /// This display mode shows both sidebars, which partially displace the
    /// secondary view controller offscreen to make space for the primary
    /// column. The secondary view controller is dimmed out, preventing
    /// interaction with its view. Touching the dimmed view or using a gesture
    /// returns the interface to the
    /// `SplitViewController.DisplayMode.oneBesideSecondary` display mode.
    ///
    /// This display mode is available for the
    /// `SplitViewController.SplitBehavior.displace` split behavior.
    case twoDisplaceSecondary
  }
}

extension SplitViewController.DisplayMode {
  /// The primary view controller is hidden.
  @available(*, deprecated, renamed: "SplitViewController.DisplayMode.secondaryOnly")
  public static var primaryHidden: SplitViewController.DisplayMode {
    .secondaryOnly
  }

  /// The primary and secondary view controllers are displayed side-by-side onscreen.
  @available(*, deprecated, renamed: "SplitViewController.DisplayMode.oneBesideSecondary")
  public static var allVisible: SplitViewController.DisplayMode {
    .oneBesideSecondary
  }

  /// The primary view controller is layered on top of the secondary view
  /// controller, leaving the secondary view controller partially visible.
  @available(*, deprecated, renamed: "SplitViewController.DisplayMode.oneOverSecondary")
  public static var primaryOverlay: SplitViewController.DisplayMode {
    .oneOverSecondary
  }
}

extension SplitViewController {
  /// Constants that describe the columns within the split view interface.
  public enum Column: Int {
    /// The column for the primary view controller.
    case primary

    /// The column for the supplementary view controller.
    ///
    /// This value only takes effect when the split view controller's style
    /// property is `SplitViewController.Style.tripleColumn`.
    case supplementary

    /// The column for the secondary, or detail, view controller.
    case secondary

    /// The column for the view controller that’s shown when the split view
    /// controller is collapsed.
    ///
    /// If a view controller is set for this column, that view controller is
    /// shown when `isCollapsed` is `true`.
    case compact
  }
}

extension SplitViewController {
  ///
  public enum DisplayModeButtonVisibility: Int {
    case automatic

    case never

    case always
  }
}

extension SplitViewController {
  /// Constants that describe the possible ways that the child view controllers
  /// appear in relation to each other.
  public enum SplitBehavior: Int {
    /// The split view controller automatically decides the most appropriate
    /// split behavior based on the device and the current app size.
    case automatic

    /// The sidebars and secondary view controller appear tiled side-by-side.
    ///
    /// This split behavior shows one or both sidebars tiled next to the
    /// secondary view controller. The secondary view controller's view is fully
    /// interactive.
    ///
    /// The possible display modes for this split behavior are:
    ///   - `SplitViewController.DisplayMode.secondaryOnly`
    ///   - `SplitViewController.DisplayMode.oneBesideSecondary`
    ///   - `SplitViewController.DisplayMode.twoBesideSecondary`
    ///
    /// If `presentsWithGesture` is `true`, the split view controller presents a
    /// special bar button item styled as a sidebar toggle icon.
    ///
    /// For a double-column split view interface, when a user taps this button,
    /// it toggles the current display mode between
    /// `SplitViewController.DisplayMode.secondaryOnly` and
    /// `SplitViewController.DisplayMode.oneBesideSecondary`.
    ///
    /// For a triple-column split view interface, when a user taps this button,
    /// it toggles the current display mode between
    /// `SplitViewController.DisplayMode.oneBesideSecondary` and
    /// `SplitViewController.DisplayMode.twoBesideSecondary`. The button doesn't
    /// appear in `SplitViewController.DisplayMode.secondaryOnly`.
    case tile

    /// The sidebars are layered on top of the secondary view controller,
    /// leaving the secondary view controller partially visible.
    ///
    /// This split behavior shows one or both sidebars layered on top of the
    /// secondary view controller, partially obscuring it. The secondary view
    /// controller is dimmed out, preventing interaction with its view.
    ///
    /// The possible display modes for this split behavior are:
    ///   - `SplitViewController.DisplayMode.secondaryOnly`
    ///   - `SplitViewController.DisplayMode.oneOverSecondary`
    ///   - `SplitViewController.DisplayMode.twoOverSecondary`
    ///
    /// If the current display mode is not
    /// `SplitViewController.DisplayMode.twoOverSecondary` and
    /// `presentsWithGesture` is `true`, the split view controller presents a
    /// special bar button item styled as a back-chevron icon. When a user taps
    /// this button, it changes the current display mode from
    /// `SplitViewController.DisplayMode.secondaryOnly` to
    /// `SplitViewController.DisplayMode.oneOverSecondary`, and from
    /// `SplitViewController.DisplayMode.oneOverSecondary` to
    /// `SplitViewController.DisplayMode.twoOverSecondary`.
    case overlay

    /// The sidebars displace the secondary view controller instead of
    /// overlapping it, moving it partially offscreen.
    ///
    /// This split behavior shows one or both sidebars tiled next to the
    /// secondary view controller. If both sidebars are visible, they partially
    /// displace the secondary view controller offscreen to make space for the
    /// primary column. The secondary view controller is dimmed out, preventing
    /// interaction with its view.
    ///
    /// The possible display modes for this split behavior are:
    ///   - `SplitViewController.DisplayMode.secondaryOnly`
    ///   - `SplitViewController.DisplayMode.oneBesideSecondary`
    ///   - `SplitViewController.DisplayMode.twoDisplaceSecondary`
    ///
    /// If the current display mode is
    /// `SplitViewController.DisplayMode.oneBesideSecondary` and
    /// `presentsWithGesture` is `true`, the split view controller presents a
    /// special bar button item styled as a back-chevron icon. When a user taps
    /// this button, it changes the current display mode to
    /// `SplitViewController.DisplayMode.twoDisplaceSecondary`.
    case displace
  }
}

extension SplitViewController {
  /// Constants that indicate the side on which the primary view controller
  /// sits.
  public enum PrimaryEdge: Int {
    /// Place the primary view controller on the leading edge of the interface.
    ///
    /// In an interface that is oriented left-to-right, this value corresponds
    /// to the left side of the split view interface. For right-to-left
    /// interfaces, the leading edge is on the right side.
    case leading

    /// Place the primary view controller on the trailing edge of the interface.
    ///
    /// In an interface that is oriented left-to-right, this value corresponds
    /// to the right side of the split view interface. For right-to-left
    /// interfaces, the trailing edge is on the left side.
    case trailing
  }
}

extension SplitViewController {
  public enum BackgroundStyle: Int {
    /// A style that has no visual effect on the background appearance of the
    /// primary view controller.
    case none

    /// A style that applies a blurred effect to the background of the primary
    /// view controller.
    case sidecar
  }
}

// FIXME(compnerd) this is marked `internal` to enable testability
internal extension SplitViewController {
  static func resolve(minimumPrimaryColumnWidth width: Double) -> Double {
    width == SplitViewController.automaticDimension ? 0.0 : width
  }

  static func resolve(maximumPrimaryColumnWidth width: Double) -> Double {
    width == SplitViewController.automaticDimension ? 320.0 : width
  }

  static func resolve(minimumSupplementaryColumnWidth width: Double) -> Double {
    width == SplitViewController.automaticDimension ? 0.0 : width
  }

  static func resolve(maximumSupplementaryColumnWidth width: Double) -> Double {
    width == SplitViewController.automaticDimension ? 320.0 : width
  }

  static func resolve(preferredDisplayMode: SplitViewController.DisplayMode,
                      for traits: TraitCollection, bounds: Rect)
      -> SplitViewController.DisplayMode {
    // TODO(compnerd) ensure that the `traitCollection` is non-empty, else
    // fallback to `Screen.main.traitCollection`.

    // If we have a horizontally compact view, prefer `oneBesideSecondary`
    // unless `.oneOverSecondary` is preferred.
    if traits.horizontalSizeClass == .compact {
      return preferredDisplayMode == .oneOverSecondary
                ? .oneOverSecondary
                : .oneBesideSecondary
    }

    // `.automatic` is not permitted for the `displayMode` property.
    if preferredDisplayMode == .automatic {
      // Use the bounds to determine the the layout on tablets, as they are
      // horizontally regular.
      //
      // On tablet form factors, prefer overlay in portrait mode, side-by-side
      // in landscape mode.
      return traits.userInterfaceIdiom == .tablet && bounds.width < bounds.height
                ? .oneOverSecondary
                : .oneBesideSecondary
    }
    return preferredDisplayMode
  }

  static func resolve(preferredSplitBehavior: SplitViewController.SplitBehavior,
                      for traits: TraitCollection, bounds: Rect)
      -> SplitViewController.SplitBehavior {
    // TODO(compnerd) ensure that the `traitCollection` is non-empty, else
    // fallback to `Screen.main.traitCollection`.

    if traits.horizontalSizeClass == .compact {
      return preferredSplitBehavior == .tile ? .tile : .overlay
    }

    if preferredSplitBehavior == .automatic {
      // Use the bounds to determine the the layout on tablets, as they are
      // horizontally regular.
      return traits.userInterfaceIdiom == .tablet && bounds.width < bounds.height
          ? .displace
          : .overlay
    }
    return preferredSplitBehavior
  }

  static func resolve(preferredPrimaryColumnWidth: Double,
                      preferredPrimaryColumnWidthFraction: Double,
                      minimumPrimaryColumnWidth: Double,
                      maximumPrimaryColumnWidth: Double,
                      for traits: TraitCollection, size: Size) -> Double {
    // TODO(compnerd) ensure that the `traitCollection` is non-empty, else
    // fallback to `Screen.main.traitCollection`.

    var columnWidth: Double
    if preferredPrimaryColumnWidthFraction == SplitViewController.automaticDimension {
      columnWidth = traits.horizontalSizeClass == .compact
                        ? size.width
                        : ceil(size.width * 0.4)
    } else {
      columnWidth = preferredPrimaryColumnWidthFraction * size.width
    }

    // TODO(compnerd) extract the following into a helper function and change the
    // function to a slightly less complicated:
    // `resolve(preferredPrimaryColumnWidth:preferredPrimaryColumnWidthFraction:for:size:)`.

    let minimumPrimaryColumnWidth =
        resolve(minimumPrimaryColumnWidth: minimumPrimaryColumnWidth)
    let maximumPrimaryColumnWidth =
        resolve(maximumPrimaryColumnWidth: maximumPrimaryColumnWidth)

    // Clamp to the minimum and maximum column width.
    return min(max(columnWidth, minimumPrimaryColumnWidth), maximumPrimaryColumnWidth)
  }

  static func resolve(preferredSupplementaryColumnWidth: Double,
                      preferredSupplementaryColumnWidthFraction: Double,
                      minimumSupplementaryColumnWidth: Double,
                      maximumSupplementaryColumnWidth: Double,
                      for traits: TraitCollection, size: Size) -> Double {
    // TODO(compnerd) ensure that the `traitCollection` is non-empty, else
    // fallback to `Screen.main.traitCollection`.

    var columnWidth: Double
    if preferredSupplementaryColumnWidthFraction == SplitViewController.automaticDimension {
      columnWidth = traits.horizontalSizeClass == .compact
                        ? 0.0
                        : ceil(size.width * 0.6)
    } else {
      columnWidth = preferredSupplementaryColumnWidthFraction * size.width
    }

    // TODO(compnerd) extract the following into a helper function and change the
    // function to a slightly less complicated:
    // `resolve(preferredSupplementaryColumnWidth:preferredSupplementaryColumnWidthFraction:for:size:)`.

    let minimumSupplementaryColumnWidth =
        resolve(minimumSupplementaryColumnWidth: minimumSupplementaryColumnWidth)
    let maximumSupplementaryColumnWidth =
        resolve(maximumSupplementaryColumnWidth: maximumSupplementaryColumnWidth)

    // Clamp to the minimum and maximum column width.
    return min(max(columnWidth, minimumSupplementaryColumnWidth), maximumSupplementaryColumnWidth)
  }
}

/// A container view controller that implements a hierarchical interface.
public class SplitViewController: ViewController {
  // MARK - Creating a Split View Controller

  ///
  override public init() {}

  /// Creates a split view controller with the specified column style.
  public init(style: SplitViewController.Style) {
    // TODO(compnerd) is there a better way to prevent the enumerator?
    precondition(style == .doubleColumn || style == .tripleColumn,
                 "\(#function) may not be used with '.unspecified'")
    self.style = style

    // displayModeButtonItem is internally managed and not exposed for
    // `.doubleColumn` or `.tripleColumn` style.
    self.displayModeButtonItem = BarButtonItem()

    super.init()

    defer { self.preferredDisplayMode = .automatic }
    defer { self.preferredSplitBehavior = .automatic }
  }

  // MARK - Getting the Split View Style

  /// The style that determines the number of columns that the split view
  /// interface displays.
  open private(set) var style: SplitViewController.Style = .unspecified

  // MARK - Customizing the Split View Transitions

  /// The delegate you use to manage changes to a split view interface.
  open weak var delegate: SplitViewControllerDelegate?

  // MARK - Managing the Child View Controllers

  /// Presents the provided view controller in the specified column of the split
  /// view interface.
  open func setViewController(_ viewController: ViewController?,
                              for column: SplitViewController.Column) {
    fatalError("\(#function) not yet implemented")
  }

  /// Returns the view controller associated with the specified column of the
  /// split view interface.
  open func viewController(for column: SplitViewController.Column)
      -> ViewController? {
    fatalError("\(#function) not yet implemented")
  }

  /// The array of view controllers the split view controller manages.
  open var viewControllers: [ViewController] = []

  // MARK - Displaying the Child View Controllers

  // `hide(_:)` and `show(:_)` do not accept the `.compact` column.
  //
  // When the view is collapsed:
  //   `hide(_:)` is always ignored for the primary column or if the
  //   requested column is not on top, otherwise the column is popped
  //
  //   `show(_:)` pushes the column (and any intervening columns) if
  //   the column is not in the stack, does nothing if the column is
  //   on top.  It pops any covering columns if the column is in the
  //   stack but not on top.
  //
  // When the view is expanded:
  //    `hide(_:)` is ignored for the secondary column, or when the
  //    column is not visible in the current `.displayMode`.  Else,
  //    it animates to the nearest `.displayMode` where the column is
  //    not visible.
  //
  //    `show(_:)` is ignored for the secondary column, or wwhen the
  //    column is already visible in the current `.displayMode`.  Else,
  //    it animates to the nearest `.displayMode` where the column is
  //    visible.
  //
  // If an animation is started due to `show(_:)` or `hide(_:)`, the
  // `transitionCoordinator` is avaailable after the call.

  /// Presents the view controller in the specified column of the split view
  /// interface.
  open func show(_ column: SplitViewController.Column) {
    fatalError("\(#function) not yet implemented")
  }

  /// Dismisses the view controller in the specified column of the split view
  /// interface.
  open func hide(_ column: SplitViewController.Column) {
    fatalError("\(#function) not yet implemented")
  }

  /// Presents the specified view controller as the primary view controller in
  /// the split view interface.
  open func show(_ viewController: ViewController, sender: AnyObject?) {
    fatalError("\(#function) not yet implemented")
  }

  /// Presents the specified view controller as the secondary view controller of
  /// the split view interface.
  open func showDetailViewController(_ viewController: ViewController,
                                       sender: AnyObject?) {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Managing the Display Mode

  /// The preferred arrangement of the split view interface.
  ///
  /// Use this property to specify the display mode that you prefer to use. The
  /// split view controller makes every effort to adopt the interface you
  /// specify, but may use a different type of interface if there isn’t enough
  /// space to support your preferred choice. If changing the value of this
  /// property leads to an actual change in the current display mode, the split
  /// view controller updates `displayMode`. The resulting change is animated if
  /// you made the change in an animation block.
  ///
  ///
  /// Setting the value of this property to
  /// `SplitViewController.DisplayMode.automatic` causes the split view
  /// controller to choose the most appropriate display mode for the currently
  /// available space. The default value of this property is
  /// `SplitViewController.DisplayMode.automatic`.
  ///
  /// A split view controller's split behavior affects its possible display
  /// mode. The preferred display mode is interpreted to match the current
  /// `splitBehavior`. For example, if you set the preferred display mode to
  /// `SplitViewController.DisplayMode.twoBesideSecondary`, the actual
  /// `displayMode` is interpreted as
  /// `SplitViewController.DisplayMode.twoOverSecondary` for
  /// `SplitViewController.SplitBehavior.overlay`, and as
  /// `SplitViewController.DisplayMode.twoDisplaceSecondary` for
  /// `SplitViewController.SplitBehavior.displace`.
  ///
  /// If `presentsWithGesture` is `false`, the value of this property is
  /// strictly respected.
  open var preferredDisplayMode: SplitViewController.DisplayMode =
      .automatic {
    didSet {
      self.displayMode =
          SplitViewController.resolve(preferredDisplayMode: self.preferredDisplayMode,
                                      for: self.traitCollection,
                                      bounds: self.viewIfLoaded?.bounds ?? .zero)
    }
  }

  /// The current arrangement of the split view interface.
  ///
  /// This property reflects the arrangement of the child view controllers in a
  /// split view interface. The value in this property is never set to
  /// `SplitViewController.DisplayMode.automatic`. To change the current display
  /// mode, change the value of the `preferredDisplayMode` property. If you just
  /// want to change which columns are shown, consider using `show(_:)` or
  /// `hide(_:)` and the split view controller will determine how to update the
  /// display mode to display the desired columns.
  ///
  /// When `isCollapsed` is `true`, the value of this property is ignored. A
  /// collapsed split view interface contains only one view controller, so the
  /// display mode is superfluous.
  open private(set) var displayMode: SplitViewController.DisplayMode =
      .automatic {
    didSet {
      assert(self.displayMode != .automatic, "displayMode may not be automatic")
      self.delegate?.splitViewController(self, willChangeTo: self.displayMode)
      // TODO(compnerd) update the displayModeButtonItem
      self.viewIfLoaded?.setNeedsLayout()
    }
  }

  /// A button that changes the display mode of the split view controller.
  ///
  /// You use this property in classic split view interfaces only. This button
  /// doesn't affect column-style split view interfaces.
  ///
  /// When a user taps this button, the display mode changes to the value last
  /// returned by the delegate's `targetDisplayModeForAction(in:)` method. Use
  /// that method to determine what mode to apply next based on the current
  /// configuration of the split view controller.
  ///
  /// Don't change the configuration of the returned button. The split view
  /// controller updates the button's configuration and appearance automatically
  /// based on the current display mode and the information the delegate object
  /// provides.
  ///
  /// You must incorporate this button into your user interface yourself.
  open private(set) var displayModeButtonItem: BarButtonItem =
      BarButtonItem()

  /// Specifies whether a hidden view controller can be presented and dismissed
  /// using a swipe gesture.
  ///
  /// When this property is `true`, the split view controller installs a gesture
  /// recognizer for changing the current display mode. In a column-style split
  /// view interface, the gesture is interactive.
  ///
  /// In a classic split view interface, the gesture recognizer applies the
  /// display mode returned by the delegate's `targetDisplayModeForAction(in:)`
  /// method. If that method returns the
  /// `SplitViewController.DisplayMode.automatic` mode, the split view
  /// controller applies the most appropriate display mode given its current
  /// configuration and size class.
  ///
  /// When this property is `false`, the split view controller doesn't install a
  /// gesture recognizer for changing the display mode. The split view
  /// controller also doesn't display a button to change the display mode.
  ///
  /// The default value of this property is `true`.
  open var presentsWithGesture: Bool = true

  /// Specifies whether the secondary view controller shows a button to toggle
  /// to and from the secondary-only display mode.
  ///
  /// This value only takes effect when the split view controller's style
  /// property is `SplitViewController.Style.tripleColumn`.
  ///
  /// The default value of this property is `false`. If you set the value to
  /// `true`, the secondary view controller shows a button that lets a user
  /// toggle the display mode to and from
  /// `SplitViewController.DisplayMode.secondaryOnly`.
  open var showsSecondaryOnlyButton: Bool = false

  ///
  open var displayModeButtonVisibility: SplitViewController.DisplayModeButtonVisibility =
      .automatic

  // MARK - Managing the Split Behavior

  /// The preferred behavior that determines how the child view controllers
  /// appear in relation to each other.
  ///
  /// Use this property to specify the split behavior that you prefer to use.
  /// The split view controller makes every effort to adopt the behavior you
  /// specify, but may use a different type of interface if there isn't enough
  /// space to support your preferred choice. If changing the value of this
  /// property leads to an actual change in the current split behavior, the
  /// split view controller reflects the actual split behavior in the
  /// `splitBehavior` property. This change takes effect after the next layout
  /// occurs.
  ///
  /// You do not set the split behavior directly; instead, you set a preferred
  /// split behavior by using the `preferredSplitBehavior` property. This change
  /// takes effect after the next layout occurs. The split view controller
  /// reflects the actual split behavior in the `splitBehavior` property. The
  /// value of the `splitBehavior` property affects which display modes are
  /// available for the split view controller. For possible configurations, see
  /// `SplitViewController.SplitBehavior`.
  ///
  /// Setting the value of this property to
  /// `SplitViewController.SplitBehavior.automatic` causes the split view
  /// controller to choose the most appropriate display mode for the currently
  /// available space. The default value of this property is
  /// `SplitViewController.SplitBehavior.automatic`.
  open var preferredSplitBehavior: SplitViewController.SplitBehavior =
      .automatic {
    didSet {
      self.splitBehavior =
          SplitViewController.resolve(preferredSplitBehavior: self.preferredSplitBehavior,
                                      for: self.traitCollection,
                                      bounds: self.viewIfLoaded?.bounds ?? Screen.main.bounds)
    }
  }

  /// The current behavior that determines how the child view controllers appear
  /// in relation to each other.
  ///
  /// This property controls how a split view controller's secondary view
  /// controller appears in relation to the other child view controllers. To
  /// change the current split behavior, change the value of the
  /// `preferredSplitBehavior` property.
  ///
  /// The value of this property affects which display modes are available for
  /// the split view interface. For possible configurations, see
  /// `SplitViewController.SplitBehavior`.
  open private(set) var splitBehavior: SplitViewController.SplitBehavior =
      .automatic

  // MARK - Managing Column Dimensions

  /// A boolean value that indicates whether only one of the child view
  /// controllers displays.
  ///
  /// This property is set to `true` when the split view controller content is
  /// semantically collapsed into a single container. Collapsing happens when
  /// the split view controller transitions from a horizontally regular to a
  /// horizontally compact environment. After it has been collapsed, the split
  /// view controller reports having only one child view controller in its
  /// `viewControllers` property. When collapsed, the `displayMode` property has
  /// no impact on the appearance of the split view interface.
  ///
  /// In a column-style split view interface, if this property is `true` and the
  /// split view controller has a view controller set for its
  /// `SplitViewController.Column.compact` column, the interface displays that
  /// view controller.
  ///
  /// The value of this property is `false` when the split view controller is
  /// capable of displaying more than one of its child view controllers at the
  /// same time, even if it's not showing more than one at the moment. In this
  /// expanded mode, the split view controller's configuration of its child
  /// view controllers is determined by the `displayMode` property.
  ///
  /// During a transition from an expanded to a collapsed interface, the value
  /// of this property is `false` until after the collapse transition finishes
  /// and all of the relevant delegate methods have been called. Similarly,
  /// when transitioning back to an expanded interface, the value is `true`
  /// until the transition finishes.
  open var isCollapsed: Bool {
    self.traitCollection.horizontalSizeClass == .compact
  }

  /// The relative width of the primary view controller's content.
  ///
  /// Use this property to specify your preferred width for the primary view
  /// controller's view. The value of this property is a floating-point number
  /// between 0.0 and 1.0 that represents the percentage of the overall width
  /// of the split view controller. For example, the value 0.4 represents 40%
  /// of the current width. The default value of this property is
  /// `automaticDimension`, which results in an appropriate width for the
  /// primary view controller.
  ///
  /// The values in the `minimumPrimaryColumnWidth` and
  /// `maximumPrimaryColumnWidth` properties constrain the actual width of the
  /// primary view controller. The split view controller attempts to use the
  /// width you specify, but may change this value to accommodate the available
  /// space. You can get the actual width for the primary view controller's
  /// view from the `primaryColumnWidth` property.
  open var preferredPrimaryColumnWidthFraction: Double =
      SplitViewController.automaticDimension {
    didSet {
      self.primaryColumnWidth =
          SplitViewController.resolve(preferredPrimaryColumnWidth: SplitViewController.automaticDimension,
                                      preferredPrimaryColumnWidthFraction: SplitViewController.automaticDimension,
                                      minimumPrimaryColumnWidth: self.minimumPrimaryColumnWidth,
                                      maximumPrimaryColumnWidth: self.maximumPrimaryColumnWidth,
                                      for: self.traitCollection,
                                      size: self.viewIfLoaded?.bounds.size ?? Screen.main.bounds.size)
    }
  }

  /// The preferred width, in points, of the primary view controller's content.
  ///
  /// Use this property to specify your preferred width for the primary view
  /// controller's view. The default value of this property is
  /// `automaticDimension`. If you set this property to a value different from
  /// `automaticDimension`, that value takes precedence over
  /// `preferredPrimaryColumnWidthFraction`.
  ///
  /// The values in the `minimumPrimaryColumnWidth` and
  /// `maximumPrimaryColumnWidth` properties constrain the actual width of the
  /// primary view controller. The split view controller attempts to use the
  /// width you specify, but may change this value to accommodate the available
  /// space. You can get the actual width for the primary view controller's
  /// view from the `primaryColumnWidth` property.
  open var preferredPrimaryColumnWidth: Double =
      SplitViewController.automaticDimension {
    didSet {
      self.primaryColumnWidth =
          SplitViewController.resolve(preferredPrimaryColumnWidth: SplitViewController.automaticDimension,
                                      preferredPrimaryColumnWidthFraction: SplitViewController.automaticDimension,
                                      minimumPrimaryColumnWidth: self.minimumPrimaryColumnWidth,
                                      maximumPrimaryColumnWidth: self.maximumPrimaryColumnWidth,
                                      for: self.traitCollection,
                                      size: self.viewIfLoaded?.bounds.size ?? Screen.main.bounds.size)
    }
  }

  /// The width, in points, of the primary view controller's content.
  ///
  /// This property contains the actual width applied to the primary view
  /// controller's view.
  open private(set) var primaryColumnWidth: Double = 0.0

  /// The minimum width, in points, for the primary view controller's content.
  ///
  /// Use this property in conjunction with the `maximumPrimaryColumnWidth`
  /// property to ensure the width of the primary view controller's content is
  /// set to an acceptable value. The preliminary width is specified by the
  /// `preferredPrimaryColumnWidthFraction` property, which is applied to the
  /// split view controller's width and checked against these bounds. If the
  /// resulting width is less than the minimum value specified by this property,
  /// the width is set to the value in this property.
  ///
  /// The default value of this property is `automaticDimension`, which
  /// corresponds to a minimum width of 0 points.
  open var minimumPrimaryColumnWidth: Double =
      SplitViewController.automaticDimension {
    didSet {
      self.primaryColumnWidth =
          SplitViewController.resolve(preferredPrimaryColumnWidth: SplitViewController.automaticDimension,
                                      preferredPrimaryColumnWidthFraction: SplitViewController.automaticDimension,
                                      minimumPrimaryColumnWidth: self.minimumPrimaryColumnWidth,
                                      maximumPrimaryColumnWidth: self.maximumPrimaryColumnWidth,
                                      for: self.traitCollection,
                                      size: self.viewIfLoaded?.bounds.size ?? Screen.main.bounds.size)
    }
  }

  /// The maximum width, in points, for the primary view controller's content.
  ///
  /// Use this property in conjunction with the `minimumPrimaryColumnWidth`
  /// property to ensure the width of the primary view controller's content is
  /// set to an acceptable value. The preliminary width is specified by the
  /// `preferredPrimaryColumnWidthFraction` property, which is applied to the
  /// split view controller’s width and checked against these bounds. If the
  /// resulting width is greater than the maximum value specified by this
  /// property, the width is set to the value in this property.
  ///
  /// The default value of this property is `automaticDimension`, which
  /// corresponds to a minimum width of 320 points.
  open var maximumPrimaryColumnWidth: Double =
      SplitViewController.automaticDimension {
    didSet {
      self.primaryColumnWidth =
          SplitViewController.resolve(preferredPrimaryColumnWidth: SplitViewController.automaticDimension,
                                      preferredPrimaryColumnWidthFraction: SplitViewController.automaticDimension,
                                      minimumPrimaryColumnWidth: self.minimumPrimaryColumnWidth,
                                      maximumPrimaryColumnWidth: self.maximumPrimaryColumnWidth,
                                      for: self.traitCollection,
                                      size: self.viewIfLoaded?.bounds.size ?? Screen.main.bounds.size)
    }
  }

  /// The relative width of the supplementary view controller's content.
  ///
  /// Use this property to specify your preferred width for the supplementary
  /// view controller's view. The value of this property is a floating-point
  /// number between 0.0 and 1.0 that represents the percentage of the overall
  /// width of the split view controller. For example, the value 0.4 represents
  /// 40% of the current width. The default value of this property is
  /// `automaticDimension`, which results in an appropriate width for the
  /// supplementary view controller.
  ///
  /// The values in the `minimumSupplementaryColumnWidth` and
  /// `maximumSupplementaryColumnWidth` properties constrain the actual width of
  /// the supplementary view controller. The split view controller attempts to
  /// use the width you specify, but may change this value to accommodate the
  /// available space. You can get the actual width for the supplementary view
  /// controller's view from the `supplementaryColumnWidth` property.
  open var preferredSupplementaryColumnWidthFraction: Double =
      SplitViewController.automaticDimension {
    didSet {
      self.supplementaryColumnWidth =
          SplitViewController.resolve(preferredSupplementaryColumnWidth: self.preferredSupplementaryColumnWidth,
                                      preferredSupplementaryColumnWidthFraction: self.preferredSupplementaryColumnWidthFraction,
                                      minimumSupplementaryColumnWidth: self.minimumSupplementaryColumnWidth,
                                      maximumSupplementaryColumnWidth: self.maximumSupplementaryColumnWidth,
                                      for: self.traitCollection,
                                      size: self.viewIfLoaded?.bounds.size ?? Screen.main.bounds.size)
    }
  }

  /// The preferred width, in points, of the supplementary view controller's
  /// content.
  ///
  /// Use this property to specify your preferred width for the supplementary
  /// view controller's view. The default value of this property is
  /// `automaticDimension`. If you set this property to a value different from
  /// `automaticDimension`, that value takes precedence over
  /// `preferredSupplementaryColumnWidthFraction`.
  ///
  /// The values in the `minimumSupplementaryColumnWidth` and
  /// `maximumSupplementaryColumnWidth` properties constrain the actual width of
  /// the supplementary view controller. The split view controller attempts to
  /// use the width you specify, but may change this value to accommodate the
  /// available space. You can get the actual width for the supplementary view
  /// controller's view from the `supplementaryColumnWidth` property.
  open var preferredSupplementaryColumnWidth: Double =
      SplitViewController.automaticDimension {
    didSet {
      self.supplementaryColumnWidth =
          SplitViewController.resolve(preferredSupplementaryColumnWidth: self.preferredSupplementaryColumnWidth,
                                      preferredSupplementaryColumnWidthFraction: self.preferredSupplementaryColumnWidthFraction,
                                      minimumSupplementaryColumnWidth: self.minimumSupplementaryColumnWidth,
                                      maximumSupplementaryColumnWidth: self.maximumSupplementaryColumnWidth,
                                      for: self.traitCollection,
                                      size: self.viewIfLoaded?.bounds.size ?? Screen.main.bounds.size)
    }
  }

  /// The width, in points, of the supplementary view controller's content.
  ///
  /// This property contains the actual width applied to the supplementary view
  /// controller's view.
  open private(set) var supplementaryColumnWidth: Double = 0.0

  /// The minimum width, in points, for the supplementary view controller's
  /// content.
  ///
  /// Use this property in conjunction with the
  /// `maximumSupplementaryColumnWidth` property to ensure the width of the
  /// supplementary view controller's content is set to an acceptable value. The
  /// preliminary width is specified by the
  /// `preferredSupplementaryColumnWidthFraction` property, which is applied to
  /// the split view controller's width and checked against these bounds. If the
  /// resulting width is less than the minimum value specified by this property,
  /// the width is set to the value in this property.
  ///
  /// The default value of this property is `automaticDimension`, which
  /// corresponds to a minimum width of 0 points.
  open var minimumSupplementaryColumnWidth: Double =
      SplitViewController.automaticDimension {
    didSet {
      self.supplementaryColumnWidth =
          SplitViewController.resolve(preferredSupplementaryColumnWidth: self.preferredSupplementaryColumnWidth,
                                      preferredSupplementaryColumnWidthFraction: self.preferredSupplementaryColumnWidthFraction,
                                      minimumSupplementaryColumnWidth: self.minimumSupplementaryColumnWidth,
                                      maximumSupplementaryColumnWidth: self.maximumSupplementaryColumnWidth,
                                      for: self.traitCollection,
                                      size: self.viewIfLoaded?.bounds.size ?? Screen.main.bounds.size)
    }
  }

  /// The maximum width, in points, for the supplementary view controller's content.
  ///
  /// Use this property in conjunction with the `minimumSupplementaryColumnWidth`
  /// property to ensure the width of the supplementary view controller's
  /// content is set to an acceptable value. The preliminary width is specified
  /// by the `preferredSupplementaryColumnWidthFraction` property, which is
  /// applied to the split view controller’s width and checked against these
  /// bounds. If the resulting width is greater than the maximum value specified
  /// by this property, the width is set to the value in this property.
  ///
  /// The default value of this property is `automaticDimension`, which
  /// corresponds to a minimum width of 320 points.
  open var maximumSupplementaryColumnWidth: Double =
      SplitViewController.automaticDimension {
    didSet {
      self.supplementaryColumnWidth =
          SplitViewController.resolve(preferredSupplementaryColumnWidth: self.preferredSupplementaryColumnWidth,
                                      preferredSupplementaryColumnWidthFraction: self.preferredSupplementaryColumnWidthFraction,
                                      minimumSupplementaryColumnWidth: self.minimumSupplementaryColumnWidth,
                                      maximumSupplementaryColumnWidth: self.maximumSupplementaryColumnWidth,
                                      for: self.traitCollection,
                                      size: self.viewIfLoaded?.bounds.size ?? Screen.main.bounds.size)
    }
  }

  /// The default value to apply to a dimension.
  open class var automaticDimension: Double {
    -.greatestFiniteMagnitude
  }

  // MARK - Positioning the Primary View Controller

  /// The side on which the primary view controller sits.
  ///
  /// Use this property to change the default arrangement of the child view
  /// controllers. The default value of this property is
  /// `SplitViewController.PrimaryEdge.leading`.
  open var primaryEdge: SplitViewController.PrimaryEdge = .leading {
    didSet { self.viewIfLoaded?.setNeedsLayout() }
  }

  // MARK - Managing the Background Style

  /// The background style of the primary view controller.
  open var primaryBackgroundStyle: SplitViewController.BackgroundStyle = .none {
    didSet { self.viewIfLoaded?.setNeedsDisplay() }
  }
}
