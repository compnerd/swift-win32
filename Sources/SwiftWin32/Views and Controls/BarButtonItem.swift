// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

extension BarButtonItem {
  /// Defines system-supplied images for bar button items.
  public enum SystemItem: Int {
    /// The system Done button, localized.
    case done

    /// The system Cancel button, localized.
    case cancel

    /// The system Edit button, localized.
    case edit

    /// The system Save button, localized.
    case save

    /// The system plus button containing an icon of a plus sign.
    case add

    /// Blank space to add between other items. The space is distributed equally
    /// between the other items. Other item properties are ignored when this
    /// value is set.
    case flexibleSpace

    /// Blank space to add between other items. Only the `width` property is
    /// used when this value is set.
    case fixedSpace

    /// The system compose button.
    case compose

    /// The system reply button.
    case reply

    /// The system action button.
    case action

    /// The system organize button.
    case organize

    /// The system bookmarks button.
    case bookmarks

    /// The system search button.
    case search

    /// The system refresh button.
    case refresh

    /// The system stop button.
    case stop

    /// The system camera button.
    case camera

    /// The system trash button.
    case trash

    /// The system play button.
    case play

    /// The system pause button.
    case pause

    /// The system rewind button.
    case rewind

    /// The system fast forward button.
    case fastForward

    /// The system undo button.
    case undo

    /// The system redo button.
    case redo

    /// The system page curl button.
    @available(*, unavailable)
    case pageCurl

    /// The system close button.
    case close
  }
}

extension BarButtonItem {
  /// The system close button.
  public enum Style: Int {
    /// Glows when tapped. The default item style.
    case plain

    /// A simple button style with a border.
    @available(*, unavailable)
    case bordered

    /// The style for a done button — for example, a button that completes some
    /// task and returns to the previous view.
    case done
  }
}

/// A specialized button for placement on a toolbar or tab bar.
///
/// You can customize the appearance of buttons by sending the setter messages
/// to `BarButtonItemAppearance` to customize all buttons, or to a specific
/// `BarButtonItem` instance. You can use customized buttons in standard places
/// in a `NavigationItem` object (`backBarButtonItem`, `leftBarButtonItem`,
/// `rightBarButtonItem`) or a `Toolbar` instance.
///
/// In general, you should specify a value for the normal state so that other
/// states without a custom value set can use it. Similarly, when a property is
/// depends on the bar metrics, you should specify a value of
/// `BarMetrics.default`.
open class BarButtonItem: BarItem {
  // MARK - Initializing an Item

  /// Initializes a new item containing the specified system item.
  public convenience init<Target: AnyObject>(barButtonSystemItem systemItem: BarButtonItem.SystemItem,
                                             target: Target?,
                                             action: ((Target) -> () -> Void)?) {
    guard let target = target else {
      fatalError("responder hierarchy scanning not supported")
    }
    let callback: ((Target) -> (AnyObject?) -> Void)? =
        action == nil
            ? nil
            : { (target: Target) in { (_: AnyObject?) in action!(target)() } }
    self.init(barButtonSystemItem: systemItem, target: target, action: callback)
  }

  public convenience init<Target: AnyObject>(barButtonSystemItem systemItem: BarButtonItem.SystemItem,
                                             target: Target?,
                                             action: ((Target) -> (AnyObject?) -> Void)?) {
    fatalError("\(#function) not yet implemented")
  }

  /// Initializes a new item using the specified custom view.
  ///
  /// The bar button item created by this method does not call the action method
  /// of its target in response to user interactions. Instead, the bar button
  /// item expects the specified custom view to handle any user interactions and
  /// provide an appropriate response.
  public convenience init(customView: View) {
    fatalError("\(#function) not yet implemented")
  }

  /// Initializes a new item using the specified image and other properties.
  public convenience init<Target: AnyObject>(image: Image?,
                                             style: BarButtonItem.Style,
                                             target: Target?,
                                             action: ((Target) -> () -> Void)?) {
    guard let target = target else {
      fatalError("responder hierarchy scanning not supported")
    }
    let callback: ((Target) -> (AnyObject?) -> Void)? =
        action == nil
            ? nil
            : { (target: Target) in { (_: AnyObject?) in action!(target)() } }
    self.init(image: image, style: style, target: target, action: callback)
  }

  public convenience init<Target: AnyObject>(image: Image?,
                                             style: BarButtonItem.Style,
                                             target: Target?,
                                             action: ((Target) -> (AnyObject?) -> Void)?) {
    fatalError("\(#function) not yet implemented")
  }

  /// Initializes a new item using the specified title and other properties.
  public convenience init<Target: AnyObject>(title: String?,
                                             style: BarButtonItem.Style,
                                             target: Target?,
                                             action: ((Target) -> () -> Void)?) {
    guard let target = target else {
      fatalError("responder hierarchy scanning not supported")
    }
    let callback: ((Target) -> (AnyObject?) -> Void)? =
        action == nil
            ? nil
            : { (target: Target) in { (_: AnyObject?) in action!(target)() } }
    self.init(title: title, style: style, target: target, action: callback)
  }

  public convenience init<Target: AnyObject>(title: String?,
                                             style: BarButtonItem.Style,
                                             target: Target?,
                                             action: ((Target) -> (AnyObject?) -> Void)?) {
    fatalError("\(#function) not yet implemented")
  }

  /// Initializes a new item using the specified title, image, action, and
  /// context menu.
  ///
  /// The context menu is displayed immediately when touched.
  public convenience init(title: String? = nil, image: Image? = nil,
                          primaryAction: Action? = nil, menu: Menu? = nil) {
    fatalError("\(#function) not yet implemented")
  }

  /// Initializes a new item using the specified system item, action, and
  /// context menu.
  ///
  /// The context menu is displayed immediately when touched.
  public convenience init(systemItem: BarButtonItem.SystemItem,
                          primaryAction: Action? = nil, menu: Menu? = nil) {
    fatalError("\(#function) not yet implemented")
  }

  /// Initializes a new item using the specified images and other properties.
  ///
  /// A new item initialized to use using the specified images and other
  /// properties.
  public convenience init<Target: AnyObject>(image: Image?,
                                             landscapeImagePhone: Image?,
                                             style: BarButtonItem.Style,
                                             target: Target?,
                                             action: ((Target) -> () -> Void)?) {
    guard let target = target else {
      fatalError("responder hierarchy scanning not supported")
    }
    let callback: ((Target) -> (AnyObject?) -> Void)? =
        action == nil
            ? nil
            : { (target: Target) in { (_: AnyObject?) in action!(target)() } }
    self.init(image: image, landscapeImagePhone: landscapeImagePhone,
              style: style, target: target, action: callback)
  }

  public convenience init<Target: AnyObject>(image: Image?,
                                             landscapeImagePhone: Image?,
                                             style: BarButtonItem.Style,
                                             target: Target?,
                                             action: ((Target) -> (_: AnyObject?) -> Void)?) {
    fatalError("\(#function) not yet implemented")
  }

  /// Initializes the bar button item to its default state.
  public override init() {
    super.init()
  }

  // MARK - Creating Space Items

  /// Creates a new fixed space item using the width.
  open class func fixedSpace(_ width: Double) -> Self {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates a new flexible width space item.
  open class func flexibleSpace() -> Self {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Getting and Setting Properties

  /// The object that receives an action when the user selects the item.
  ///
  /// If `nil`, the action message is passed up the responder chain where it may
  /// be handled by any object implementing a method corresponding to the
  /// selector held by the action property. The default value is `nil`.
  open weak var target: AnyObject?

  /// The selector defining the action message to send to the target object when
  /// the user taps this bar button item.
  ///
  /// If the value of this property is `nil`, no action message is sent. The
  /// default value is `nil`.
  /* open var action: Selector? */

  /// The style of the item.
  ///
  /// One of the constants defined in `BarButtonItem.Style`. The default value
  /// is `BarButtonItem.Style.plain`.
  open var style: BarButtonItem.Style = .plain

  /// The set of possible titles to display on the bar button.
  open var possibleTitles: Set<String>?

  /// The width of the item.
  ///
  /// If this property value is positive, the width of the combined image and
  /// title are fixed. If the value is `0.0` or negative, the item sets the
  /// width of the combined image and title to fit. This property is ignored if
  /// the style uses radio mode. The default value is `0.0`.
  open var width: Double = 0.0

  /// A custom view representing the item.
  open var customView: View?

  /// The context menu for this button.
  ///
  /// The context menu is displayed immediately when touched.
  open var menu: Menu?

  /// The action to send to the target when the user selects the item.
  ///
  /// The `target` and `action` properties are ingored when `primaryAction` is
  /// not `nil`.
  /* @NSCopying */ open var primaryAction: Action?

  // MARK - Customizing Appearance

  /// The tint color to apply to the button item.
  ///
  /// All subclasses of `View` derive their behaviour for `tintColor` from the
  /// base class. Although `BarButtonItem` is not a view, its `tintColor`
  /// property behaves the same as that of `View`. See the discussion of
  /// `tintColor` at the `View` level for more information.
  open var tintColor: Color?

  /// Returns the back button background image for a specified control state and
  /// bar metrics.
  ///
  /// This modifier applies only to navigation bar back buttons and is ignored
  /// by other buttons.
  open func backButtonBackgroundImage(for state: Control.State,
                                      barMetrics: BarMetrics) -> Image? {
    fatalError("\(#function) not yet implemented")
  }

  /// Sets the back button background image for a specified control state and
  /// bar metrics.
  ///
  /// This modifier applies only to navigation bar back buttons and is ignored
  /// by other buttons.
  ///
  /// For good results, backgroundImage must be a stretchable image.
  open func setBackButtonBackgroundImage(_ backgroundImage: Image?,
                                         for state: Control.State,
                                         barMetrics: BarMetrics) {
  }

  /// Returns the back button title offset for specified bar metrics.
  ///
  /// This modifier applies only to navigation bar back buttons and is ignored
  /// by other buttons.
  open func backButtonTitlePositionAdjustment(for barMetrics: BarMetrics)
      -> Offset {
    fatalError("\(#function) not yet implemented")
  }

  /// Sets the back button title offset for specified bar metrics.
  ///
  /// This modifier applies only to navigation bar back buttons and is ignored
  /// by other buttons.
  open func setBackButtonTitlePositionAdjustment(_ adjustment: Offset,
                                                 for barMetrics: BarMetrics) {
  }

  /// Returns the back button vertical position offset for specified bar
  /// metrics.
  ///
  /// This modifier applies only to navigation bar back buttons and is ignored
  /// by other buttons.
  ///
  /// This offset is used to adjust the vertical centering of bordered bar
  /// buttons within the bar.
  open func backButtonBackgroundVerticalPositionAdjustment(for barMetrics: BarMetrics)
      -> Double {
    fatalError("\(#function) not yet implemented")
  }

  /// Sets the background vertical position offset for specified bar metrics.
  ///
  /// This offset is used to adjust the vertical centering of bordered bar
  /// buttons within the bar.
  open func setBackgroundVerticalPositionAdjustment(_ adjustment: Double,
                                                    for barMetrics: BarMetrics) {
  }

  /// Returns the background image for a specified state and bar metrics.
  ///
  /// The background image for the button given state and metrics.
  open func backgroundImage(for state: Control.State, barMetrics: BarMetrics)
      -> Image? {
    fatalError("\(#function) not yet implemented")
  }

  /// Sets the background image for a specified state and bar metrics.
  ///
  /// For good results, `backgroundImage` must be a stretchable image.
  open func setBackgroundImage(_ backgroundImage: Image?,
                               for state: Control.State,
                               barMetrics: BarMetrics) {
  }

  /// Returns the background image for the specified state, style, and metrics.
  open func backgroundImage(for state: Control.State,
                            style: BarButtonItem.Style,
                            barMetrics: BarMetrics) -> Image? {
    fatalError("\(#function) not yet implemented")
  }

  /// Sets the background image for the specified state, style, and metrics.
  ///
  /// For good results, `backgroundImage` must be a stretchable image.
  open func setBackgroundImage(_ backgroundImage: Image?,
                               for state: Control.State,
                               style: BarButtonItem.Style,
                               barMetrics: BarMetrics) {
  }

  /// Returns the title offset for specified bar metrics.
  ///
  /// This offset is used to adjust the position of a title (if any) within a
  /// bordered bar button.
  open func titlePositionAdjustment(for barMetrics: BarMetrics) -> Offset {
    fatalError("\(#function) not yet implemented")
  }

  /// Sets the title offset for specified bar metrics.
  ///
  /// This offset is used to adjust the position of a title (if any) within a
  /// bordered bar button.
  open func setTitlePositionAdjustment(_ adjustment: Offset,
                                       for barMetrics: BarMetrics) {
  }

  // MARK - Getting the Shortcuts Group Information

  /// The group on the shortcuts bar that the button belongs to.
  ///
  /// For bar button items installed on the shortcuts bar above the keyboard,
  /// this property contains the group to which the item belongs. This property
  /// is configured automatically when you add the bar button item to a
  /// `BarButtonItemGroup` object. If the item is not associated with a bar
  /// button item group, this property is `nil`.
  open private(set) weak var buttonGroup: BarButtonItemGroup?
}
