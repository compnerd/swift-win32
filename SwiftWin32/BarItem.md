---
layout: default
title: BarItem
parent: SwiftWin32
---
# BarItem

An abstract superclass for items that you can add to a bar that appears at
the bottom of the screen.

``` swift
open class BarItem 
```

## Initializers

### `init()`

Initializes the bar item to its default state.

``` swift
public init() 
```

## Properties

### `title`

The title displayed on the item.

``` swift
open var title: String?
```

You should set this property before adding the item to a bar. The default
value is `nil`.

### `image`

The image used to represent the item.

``` swift
open var image: Image?
```

This image can be used to create other images to represent this item on
the bar — for example, a selected and unselected image may be derived from
this image. You should set this property before adding the item to a bar.
The default value is `nil`.

### `landscapeImage`

The image to use to represent the item in landscape orientation.

``` swift
open var landscapeImage: Image?
```

This image can be used to create other images to represent this item on
the bar — for example, a selected and unselected image may be derived from
this image. You should set this property before adding the item to a bar.
The default value is `nil`.

### `largeContentSizeImage`

The image to display for assistive interfaces.

``` swift
open var largeContentSizeImage: Image?
```

Use this property to specify a high-resolution version of the item's
image. When displaying an assistive interface, the framework displays this
image instead of the standard image. The default value of this property is
`nil`.

If you do not specify an image for this property, the framework scales the
image that you specified in the image property.

### `imageInsets`

The image inset or outset for each edge.

``` swift
open var imageInsets: EdgeInsets = .zero
```

The default value is `zero`.

### `landscapeImageInsets`

The image inset or outset for each edge of the image in landscape
orientation.

``` swift
open var landscapeImageInsets: EdgeInsets = .zero
```

The default value is `zero`.

### `largeContentSizeImageInsets`

The insets to apply to the bar item's large image when displaying the
image in an assistive UI.

``` swift
open var largeContentSizeImageInsets: EdgeInsets = .zero
```

The default value of this property is `zero`.

### `isEnabled`

A boolean value indicating whether the item is enabled.

``` swift
open var isEnabled: Bool = true
```

If `false`, the item is drawn partially dimmed to indicate it is disabled.
The default value is `true`.

### `tag`

The receiver’s tag, an application-supplied integer that you can use to
identify bar item objects in your application.

``` swift
open var tag: Int = 0
```

The default value is `0`.

## Methods

### `setTitleTextAttributes(_:for:)`

Sets the title’s text attributes for a given control state.

``` swift
open func setTitleTextAttributes(_ attributes: [NSAttributedString.Key:Any]?,
                                   for state: Control.State) 
```

### `titleTextAttributes(for:)`

Returns the title’s text attributes for a given control state.

``` swift
open func titleTextAttributes(for state: Control.State)
      -> [NSAttributedString.Key:Any]? 
```

The dictionary may contain key-value pairs for text attributes for the
font, text color, text shadow color, and text shadow offset using the keys
listed in NSString Additions Reference.
