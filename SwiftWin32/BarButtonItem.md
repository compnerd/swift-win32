---
layout: default
title: BarButtonItem
parent: SwiftWin32
---
# BarButtonItem

A specialized button for placement on a toolbar or tab bar.

``` swift
open class BarButtonItem: BarItem 
```

You can customize the appearance of buttons by sending the setter messages
to `BarButtonItemAppearance` to customize all buttons, or to a specific
`BarButtonItem` instance. You can use customized buttons in standard places
in a `NavigationItem` object (`backBarButtonItem`, `leftBarButtonItem`,
`rightBarButtonItem`) or a `Toolbar` instance.

In general, you should specify a value for the normal state so that other
states without a custom value set can use it. Similarly, when a property is
depends on the bar metrics, you should specify a value of
`BarMetrics.default`.

## Inheritance

[`BarItem`](https://compnerd.github.io/swift-win32/SwiftWin32/BarItem)

## Initializers

### `init(barButtonSystemItem:target:action:)`

Initializes a new item containing the specified system item.

``` swift
public convenience init<Target: AnyObject>(barButtonSystemItem systemItem: BarButtonItem.SystemItem,
                                             target: Target?,
                                             action: ((Target) -> () -> Void)?) 
```

### `init(barButtonSystemItem:target:action:)`

``` swift
public convenience init<Target: AnyObject>(barButtonSystemItem systemItem: BarButtonItem.SystemItem,
                                             target: Target?,
                                             action: ((Target) -> (AnyObject?) -> Void)?) 
```

### `init(customView:)`

Initializes a new item using the specified custom view.

``` swift
public convenience init(customView: View) 
```

The bar button item created by this method does not call the action method
of its target in response to user interactions. Instead, the bar button
item expects the specified custom view to handle any user interactions and
provide an appropriate response.

### `init(image:style:target:action:)`

Initializes a new item using the specified image and other properties.

``` swift
public convenience init<Target: AnyObject>(image: Image?,
                                             style: BarButtonItem.Style,
                                             target: Target?,
                                             action: ((Target) -> () -> Void)?) 
```

### `init(image:style:target:action:)`

``` swift
public convenience init<Target: AnyObject>(image: Image?,
                                             style: BarButtonItem.Style,
                                             target: Target?,
                                             action: ((Target) -> (AnyObject?) -> Void)?) 
```

### `init(title:style:target:action:)`

Initializes a new item using the specified title and other properties.

``` swift
public convenience init<Target: AnyObject>(title: String?,
                                             style: BarButtonItem.Style,
                                             target: Target?,
                                             action: ((Target) -> () -> Void)?) 
```

### `init(title:style:target:action:)`

``` swift
public convenience init<Target: AnyObject>(title: String?,
                                             style: BarButtonItem.Style,
                                             target: Target?,
                                             action: ((Target) -> (AnyObject?) -> Void)?) 
```

### `init(title:image:primaryAction:menu:)`

Initializes a new item using the specified title, image, action, and
context menu.

``` swift
public convenience init(title: String? = nil, image: Image? = nil,
                          primaryAction: Action? = nil, menu: Menu? = nil) 
```

The context menu is displayed immediately when touched.

### `init(systemItem:primaryAction:menu:)`

Initializes a new item using the specified system item, action, and
context menu.

``` swift
public convenience init(systemItem: BarButtonItem.SystemItem,
                          primaryAction: Action? = nil, menu: Menu? = nil) 
```

The context menu is displayed immediately when touched.

### `init(image:landscapeImagePhone:style:target:action:)`

Initializes a new item using the specified images and other properties.

``` swift
public convenience init<Target: AnyObject>(image: Image?,
                                             landscapeImagePhone: Image?,
                                             style: BarButtonItem.Style,
                                             target: Target?,
                                             action: ((Target) -> () -> Void)?) 
```

A new item initialized to use using the specified images and other
properties.

### `init(image:landscapeImagePhone:style:target:action:)`

``` swift
public convenience init<Target: AnyObject>(image: Image?,
                                             landscapeImagePhone: Image?,
                                             style: BarButtonItem.Style,
                                             target: Target?,
                                             action: ((Target) -> (_: AnyObject?) -> Void)?) 
```

### `init()`

Initializes the bar button item to its default state.

``` swift
public override init() 
```

## Properties

### `target`

The object that receives an action when the user selects the item.

``` swift
open weak var target: AnyObject?
```

If `nil`, the action message is passed up the responder chain where it may
be handled by any object implementing a method corresponding to the
selector held by the action property. The default value is `nil`.

### `style`

The selector defining the action message to send to the target object when
the user taps this bar button item.

``` swift
open var style: BarButtonItem.Style = .plain
```

If the value of this property is `nil`, no action message is sent. The
default value is `nil`.
The style of the item.

One of the constants defined in `BarButtonItem.Style`. The default value
is `BarButtonItem.Style.plain`.

### `possibleTitles`

The set of possible titles to display on the bar button.

``` swift
open var possibleTitles: Set<String>?
```

### `width`

The width of the item.

``` swift
open var width: Double = 0.0
```

If this property value is positive, the width of the combined image and
title are fixed. If the value is `0.0` or negative, the item sets the
width of the combined image and title to fit. This property is ignored if
the style uses radio mode. The default value is `0.0`.

### `customView`

A custom view representing the item.

``` swift
open var customView: View?
```

### `menu`

The context menu for this button.

``` swift
open var menu: Menu?
```

The context menu is displayed immediately when touched.

### `primaryAction`

The action to send to the target when the user selects the item.

``` swift
open var primaryAction: Action?
```

The `target` and `action` properties are ingored when `primaryAction` is
not `nil`.

### `tintColor`

The tint color to apply to the button item.

``` swift
open var tintColor: Color?
```

All subclasses of `View` derive their behaviour for `tintColor` from the
base class. Although `BarButtonItem` is not a view, its `tintColor`
property behaves the same as that of `View`. See the discussion of
`tintColor` at the `View` level for more information.

### `buttonGroup`

The group on the shortcuts bar that the button belongs to.

``` swift
open private(set) weak var buttonGroup: BarButtonItemGroup?
```

For bar button items installed on the shortcuts bar above the keyboard,
this property contains the group to which the item belongs. This property
is configured automatically when you add the bar button item to a
`BarButtonItemGroup` object. If the item is not associated with a bar
button item group, this property is `nil`.

## Methods

### `fixedSpace(_:)`

Creates a new fixed space item using the width.

``` swift
open class func fixedSpace(_ width: Double) -> Self 
```

### `flexibleSpace()`

Creates a new flexible width space item.

``` swift
open class func flexibleSpace() -> Self 
```

### `backButtonBackgroundImage(for:barMetrics:)`

Returns the back button background image for a specified control state and
bar metrics.

``` swift
open func backButtonBackgroundImage(for state: Control.State,
                                      barMetrics: BarMetrics) -> Image? 
```

This modifier applies only to navigation bar back buttons and is ignored
by other buttons.

### `setBackButtonBackgroundImage(_:for:barMetrics:)`

Sets the back button background image for a specified control state and
bar metrics.

``` swift
open func setBackButtonBackgroundImage(_ backgroundImage: Image?,
                                         for state: Control.State,
                                         barMetrics: BarMetrics) 
```

This modifier applies only to navigation bar back buttons and is ignored
by other buttons.

For good results, backgroundImage must be a stretchable image.

### `backButtonTitlePositionAdjustment(for:)`

Returns the back button title offset for specified bar metrics.

``` swift
open func backButtonTitlePositionAdjustment(for barMetrics: BarMetrics)
      -> Offset 
```

This modifier applies only to navigation bar back buttons and is ignored
by other buttons.

### `setBackButtonTitlePositionAdjustment(_:for:)`

Sets the back button title offset for specified bar metrics.

``` swift
open func setBackButtonTitlePositionAdjustment(_ adjustment: Offset,
                                                 for barMetrics: BarMetrics) 
```

This modifier applies only to navigation bar back buttons and is ignored
by other buttons.

### `backButtonBackgroundVerticalPositionAdjustment(for:)`

Returns the back button vertical position offset for specified bar
metrics.

``` swift
open func backButtonBackgroundVerticalPositionAdjustment(for barMetrics: BarMetrics)
      -> Double 
```

This modifier applies only to navigation bar back buttons and is ignored
by other buttons.

This offset is used to adjust the vertical centering of bordered bar
buttons within the bar.

### `setBackgroundVerticalPositionAdjustment(_:for:)`

Sets the background vertical position offset for specified bar metrics.

``` swift
open func setBackgroundVerticalPositionAdjustment(_ adjustment: Double,
                                                    for barMetrics: BarMetrics) 
```

This offset is used to adjust the vertical centering of bordered bar
buttons within the bar.

### `backgroundImage(for:barMetrics:)`

Returns the background image for a specified state and bar metrics.

``` swift
open func backgroundImage(for state: Control.State, barMetrics: BarMetrics)
      -> Image? 
```

The background image for the button given state and metrics.

### `setBackgroundImage(_:for:barMetrics:)`

Sets the background image for a specified state and bar metrics.

``` swift
open func setBackgroundImage(_ backgroundImage: Image?,
                               for state: Control.State,
                               barMetrics: BarMetrics) 
```

For good results, `backgroundImage` must be a stretchable image.

### `backgroundImage(for:style:barMetrics:)`

Returns the background image for the specified state, style, and metrics.

``` swift
open func backgroundImage(for state: Control.State,
                            style: BarButtonItem.Style,
                            barMetrics: BarMetrics) -> Image? 
```

### `setBackgroundImage(_:for:style:barMetrics:)`

Sets the background image for the specified state, style, and metrics.

``` swift
open func setBackgroundImage(_ backgroundImage: Image?,
                               for state: Control.State,
                               style: BarButtonItem.Style,
                               barMetrics: BarMetrics) 
```

For good results, `backgroundImage` must be a stretchable image.

### `titlePositionAdjustment(for:)`

Returns the title offset for specified bar metrics.

``` swift
open func titlePositionAdjustment(for barMetrics: BarMetrics) -> Offset 
```

This offset is used to adjust the position of a title (if any) within a
bordered bar button.

### `setTitlePositionAdjustment(_:for:)`

Sets the title offset for specified bar metrics.

``` swift
open func setTitlePositionAdjustment(_ adjustment: Offset,
                                       for barMetrics: BarMetrics) 
```

This offset is used to adjust the position of a title (if any) within a
bordered bar button.
