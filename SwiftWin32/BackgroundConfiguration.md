---
layout: default
title: BackgroundConfiguration
parent: SwiftWin32
---
# BackgroundConfiguration

A configuration that describes a specific background appearance.

``` swift
public struct BackgroundConfiguration 
```

## Inheritance

`CustomDebugStringConvertible`, `CustomReflectable`, `CustomStringConvertible`, `Hashable`

## Properties

### `customView`

A custom view for the background.

``` swift
public var customView: View?
```

### `cornerRadius`

The preferred corner radius, using a continuous corner curve, for the
background and stroke.

``` swift
public var cornerRadius: Double = 0.0
```

### `backgroundInsets`

The insets (or outsets, if negative) for the background and stroke,
relative to the edges of the containing view.

``` swift
public var backgroundInsets: DirectionalEdgeInsets = .zero
```

### `edgesAddingLayoutMarginsToBackgroundInsets`

The edges on which the configuration adds the containing view’s layout
margins to the background insets.

``` swift
public var edgesAddingLayoutMarginsToBackgroundInsets: DirectionalRectEdge =
      .none
```

### `backgroundColor`

The color of the background.

``` swift
public var backgroundColor: Color?
```

If the value is `nil`, the background color is the view's tint color. Use
`clear` for a transparent background with no color.

### `backgroundColorTransformer`

The color transformer for resolving the background color.

``` swift
public var backgroundColorTransformer: ConfigurationColorTransformer?
```

If the value is `nil`, the configuration uses `backgroundColor` without
any transformations.

### `visualEffect`

The visual effect that the configuration applies to the background.

``` swift
public var visualEffect: VisualEffect?
```

### `strokeColor`

The color of the stroke.

``` swift
public var strokeColor: Color?
```

If the value is `nil`, the stroke color is the view's tint color. Use
`clear` for a transparent stroke with no color.

### `strokeColorTransformer`

The color transformer for resolving the stroke color.

``` swift
public var strokeColorTransformer: ConfigurationColorTransformer?
```

If the value is `nil`, the configuration uses `strokeColor` without any
transformations.

### `strokeWidth`

The width of the stroke.

``` swift
public var strokeWidth: Double = 0.0
```

### `strokeOutset`

The outset (or inset, if negative) for the stroke.

``` swift
public var strokeOutset: Double = 0.0
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

### `listPlainCell()`

Creates a default configuration for a plain list cell.

``` swift
public static func listPlainCell() -> BackgroundConfiguration 
```

### `listGroupedCell()`

Creates a default configuration for a grouped list cell.

``` swift
public static func listGroupedCell() -> BackgroundConfiguration 
```

### `listSidebarCell()`

Creates a default configuration for a sidebar list cell.

``` swift
public static func listSidebarCell() -> BackgroundConfiguration 
```

### `listAccompaniedSidebarCell()`

Creates a default configuration for an accompanied sidebar list cell.

``` swift
public static func listAccompaniedSidebarCell() -> BackgroundConfiguration 
```

### `listPlainHeaderFooter()`

Creates a default configuration for a plain list header or footer.

``` swift
public static func listPlainHeaderFooter() -> BackgroundConfiguration 
```

### `listGroupedHeaderFooter()`

Creates a default configuration for a grouped list header or footer.

``` swift
public static func listGroupedHeaderFooter() -> BackgroundConfiguration 
```

### `listSidebarHeader()`

Creates a default configuration for a sidebar list header.

``` swift
public static func listSidebarHeader() -> BackgroundConfiguration 
```

### `clear()`

Creates an empty background configuration with a transparent background
and no default styling.

``` swift
public static func clear() -> BackgroundConfiguration 
```

### `resolvedBackgroundColor(for:)`

Generates the resolved background color for the specified tint color,
using the background color and color transformer.

``` swift
public func resolvedBackgroundColor(for tintColor: Color) -> Color 
```

### `resolvedStrokeColor(for:)`

Generates the resolved stroke color for the specified tint color, using
the stroke color and color transformer.

``` swift
public func resolvedStrokeColor(for tintColor: Color) -> Color 
```

### `updated(for:)`

Generates a configuration for the specified state by applying the
configuration's default values for that state to any properties that you
haven't customized.

``` swift
public func updated(for state: ConfigurationState) -> BackgroundConfiguration 
```

### `hash(into:)`

``` swift
public func hash(into hasher: inout Hasher) 
```

## Operators

### `==`

``` swift
public static func ==(_ lhs: BackgroundConfiguration,
                        _ rhs: BackgroundConfiguration) -> Bool 
```
