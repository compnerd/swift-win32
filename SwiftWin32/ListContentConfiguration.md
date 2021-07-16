---
layout: default
title: ListContentConfiguration
parent: SwiftWin32
---
# ListContentConfiguration

A content configuration for a list-based content view.

``` swift
public struct ListContentConfiguration 
```

## Inheritance

[`ContentConfiguration`](https://compnerd.github.io/swift-win32/SwiftWin32/ContentConfiguration), `CustomDebugStringConvertible`, `CustomReflectable`, `CustomStringConvertible`, `Hashable`

## Properties

### `image`

The image to display.

``` swift
public var image: Image?
```

### `text`

The primary text.

``` swift
public var text: String?
```

### `attributedText`

An attributed variant of the primary text.

``` swift
public var attributedText: NSAttributedString?
```

### `secondaryText`

The secondary text.

``` swift
public var secondaryText: String?
```

### `secondaryAttributedText`

An attributed variant of the secondary text.

``` swift
public var secondaryAttributedText: NSAttributedString?
```

### `imageProperties`

Properties for configuring the image.

``` swift
public var imageProperties: ListContentConfiguration.ImageProperties
```

### `textProperties`

Properties for configuring the primary text.

``` swift
public var textProperties: ListContentConfiguration.TextProperties
```

### `secondaryTextProperties`

Properties for configuring the secondary text.

``` swift
public var secondaryTextProperties: ListContentConfiguration.TextProperties
```

### `axesPreservingSuperviewLayoutMargins`

A boolean value that detemines whether the content view preserves the
layout margins that it inherits from its superview on the horizontal or
vertical axes.

``` swift
public var axesPreservingSuperviewLayoutMargins: Axis = .both
```

### `directionalLayoutMargins`

The margins between the content and the edges of the content view.

``` swift
public var directionalLayoutMargins: DirectionalEdgeInsets
```

### `prefersSideBySideTextAndSecondaryText`

A boolean value that detemines whether the configuration positions the
text and secondary text side by side.

``` swift
public var prefersSideBySideTextAndSecondaryText: Bool
```

### `imageToTextPadding`

The padding between the image and text.

``` swift
public var imageToTextPadding: Double
```

### `textToSecondaryTextHorizontalPadding`

The minimum horizontal padding between the text and secondary text.

``` swift
public var textToSecondaryTextHorizontalPadding: Double
```

### `textToSecondaryTextVerticalPadding`

The vertical padding between the text and secondary text.

``` swift
public var textToSecondaryTextVerticalPadding: Double
```

### `description`

``` swift
public var description: String 
```

### `debugDescription`

``` swift
public var debugDescription: String 
```

### `customMirror`

``` swift
public var customMirror: Mirror 
```

## Methods

### `cell()`

Creates the default configuration for a list cell.

``` swift
public static func cell() -> ListContentConfiguration 
```

### `subtitleCell()`

Creates the default configuration for a list cell with subtitle text.

``` swift
public static func subtitleCell() -> ListContentConfiguration 
```

### `valueCell()`

Creates the default configuration for a list cell with side-by-side value
text.

``` swift
public static func valueCell() -> ListContentConfiguration 
```

### `plainHeader()`

Creates the default configuration for a plain list header.

``` swift
public static func plainHeader() -> ListContentConfiguration 
```

### `plainFooter()`

Creates the default configuration for a plain list footer.

``` swift
public static func plainFooter() -> ListContentConfiguration 
```

### `groupedHeader()`

Creates the default configuration for a grouped list header.

``` swift
public static func groupedHeader() -> ListContentConfiguration 
```

### `groupedFooter()`

Creates the default configuration for a grouped list footer.

``` swift
public static func groupedFooter() -> ListContentConfiguration 
```

### `sidebarCell()`

Creates the default configuration for a sidebar list cell.

``` swift
public static func sidebarCell() -> ListContentConfiguration 
```

### `sidebarSubtitleCell()`

Creates the default configuration for a sidebar list cell with subtitle
text.

``` swift
public static func sidebarSubtitleCell() -> ListContentConfiguration 
```

### `sidebarHeader()`

Creates the default configuration for a sidebar list header.

``` swift
public static func sidebarHeader() -> ListContentConfiguration 
```

### `accompaniedSidebarCell()`

Creates the default configuration for an accompanied sidebar list cell.

``` swift
public static func accompaniedSidebarCell() -> ListContentConfiguration 
```

### `accompaniedSidebarSubtitleCell()`

Creates the default configuration for an accompanied sidebar list cell
with subtitle text.

``` swift
public static func accompaniedSidebarSubtitleCell()
      -> ListContentConfiguration 
```

### `makeContentView()`

Creates a new instance of the content view using this configuration.

``` swift
public func makeContentView() -> View & ContentView 
```

### `updated(for:)`

Generates a configuration for the specified state by applying the
configuration's default values for that state to any properties that you
haven't customized.

``` swift
public func updated(for state: ConfigurationState) -> ListContentConfiguration 
```

### `hash(into:)`

``` swift
public func hash(into hasher: inout Hasher) 
```

## Operators

### `==`

``` swift
public static func ==(_ lhs: ListContentConfiguration,
                        _ rhs: ListContentConfiguration) -> Bool 
```
