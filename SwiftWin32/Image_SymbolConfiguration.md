---
layout: default
title: Image.SymbolConfiguration
parent: SwiftWin32
---
# Image.SymbolConfiguration

An object that contains the specific font, size, style, and weight
attributes to apply to a symbol image.

``` swift
public class SymbolConfiguration: Image.Configuration 
```

## Inheritance

[`Image.Configuration`](https://compnerd.github.io/swift-win32/SwiftWin32/Image_Configuration)

## Initializers

### `init(pointSize:)`

Creates a configuration object with the specified point-size information.

``` swift
public convenience init(pointSize: Double) 
```

### `init(pointSize:weight:)`

Creates a configuration object with the specified point-size and weight
information.

``` swift
public convenience init(pointSize: Double, weight: Image.SymbolWeight) 
```

### `init(pointSize:weight:scale:)`

Creates a configuration object with the specified point-size, weight,
and scale information.

``` swift
public convenience init(pointSize: Double, weight: Image.SymbolWeight,
                            scale: Image.SymbolScale) 
```

### `init(scale:)`

Creates a configuration object with the specified scale information.

``` swift
public convenience init(scale: Image.SymbolScale) 
```

### `init(textStyle:)`

Creates a configuration object with the specified font text style
information.

``` swift
public convenience init(textStyle: Font.TextStyle) 
```

### `init(textStyle:scale:)`

Creates a configuration object with the specified font text style and
scale information.

``` swift
public convenience init(textStyle: Font.TextStyle,
                            scale: Image.SymbolScale) 
```

### `init(weight:)`

Creates a configuration object with the specified weight information.

``` swift
public convenience init(weight: Image.SymbolWeight) 
```

### `init(font:)`

Creates a configuration object with the specified font information.

``` swift
public convenience init(font: Font) 
```

### `init(font:scale:)`

Creates a configuration object with the specified font and scale
information.

``` swift
public convenience init(font: Font, scale: Image.SymbolScale) 
```

## Properties

### `unspecified`

A symbol configuration object that contains unspecified values for all
attributes.

``` swift
public class var unspecified: Image.SymbolConfiguration 
```

## Methods

### `configurationWithoutPointSizeAndWeight()`

Returns a copy of the current symbol configuration object without
point-size and weight information.

``` swift
public func configurationWithoutPointSizeAndWeight() -> Self 
```

### `configurationWithoutScale()`

Returns a copy of the current symbol configuration object without scale
information.

``` swift
public func configurationWithoutScale() -> Self 
```

### `configurationWithoutTextStyle()`

Returns a copy of the current symbol configuration object without font
text style information.

``` swift
public func configurationWithoutTextStyle() -> Self 
```

### `configurationWithoutWeight()`

Returns a copy of the current symbol configuration object without weight
information.

``` swift
public func configurationWithoutWeight() -> Self 
```

### `isEqual(to:)`

Returns a boolean value that indicates whether the configuration objects
are equivalent.

``` swift
public func isEqual(to otherConfiguration: Image.SymbolConfiguration?)
        -> Bool 
```
