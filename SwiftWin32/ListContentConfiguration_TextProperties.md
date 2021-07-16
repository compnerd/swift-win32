---
layout: default
title: ListContentConfiguration.TextProperties
parent: SwiftWin32
---
# ListContentConfiguration.TextProperties

Properties that affect the list content configuration's text.

``` swift
public struct TextProperties 
```

## Properties

### `font`

The font for the text.

``` swift
public var font: Font
```

### `color`

The color of the text.

``` swift
public var color: Color
```

### `colorTransformer`

The color transformer for resolving the text color.

``` swift
public var colorTransformer: ConfigurationColorTransformer?
```

### `alignment`

The alignment for the text.

``` swift
public var alignment: TextProperties.TextAlignment
```

### `lineBreakMode`

The line break mode to use for the text.

``` swift
public var lineBreakMode: LineBreakMode
```

### `numberOfLines`

The maximum number of lines for the text.

``` swift
public var numberOfLines: Int
```

### `adjustsFontSizeToFitWidth`

A boolean value that detemines whether the configuration automatically
adjusts the font size of the text when necessary to fit in the available
width.

``` swift
public var adjustsFontSizeToFitWidth: Bool
```

### `minimumScaleFactor`

The smallest multiplier for the font size that the configuration uses to
make the text fit.

``` swift
public var minimumScaleFactor: Double
```

### `allowsDefaultTighteningForTruncation`

A boolean value that detemines whether the configuration tightens the
text before truncating.

``` swift
public var allowsDefaultTighteningForTruncation: Bool
```

### `adjustsFontForContentSizeCategory`

A boolean value that detemines whether the configuration automatically
updates the font when the content size category changes.

``` swift
public var adjustsFontForContentSizeCategory: Bool
```

### `transform`

The transform to apply to the text.

``` swift
public var transform: TextProperties.TextTransform
```

## Methods

### `resolvedColor()`

Generates the resolved color for the specified color, using the text
color and color transformer.

``` swift
public func resolvedColor() -> Color 
```
