---
layout: default
title: ListContentConfiguration.ImageProperties
parent: SwiftWin32
---
# ListContentConfiguration.ImageProperties

Properties that affect the list content configuration's image.

``` swift
public struct ImageProperties 
```

## Inheritance

`CustomDebugStringConvertible`, `CustomReflectable`, `CustomStringConvertible`, `Hashable`

## Properties

### `preferredSymbolConfiguration`

The symbol configuration to use.

``` swift
public var preferredSymbolConfiguration: Image.SymbolConfiguration?
```

### `tintColor`

The tint color to apply to the image view.

``` swift
public var tintColor: Color?
```

### `tintColorTransformer`

The color transformer for resolving the tint color.

``` swift
public var tintColorTransformer: ConfigurationColorTransformer?
```

### `cornerRadius`

The preferred corner radius, using a continuous corner curve, for the
image.

``` swift
public var cornerRadius: Double
```

### `maximumSize`

The maximum size for the image.

``` swift
public var maximumSize: Size = .zero
```

### `reservedLayoutSize`

The layout size that the system reserves for the image, and then centers
the image within.

``` swift
public var reservedLayoutSize: Size = .zero
```

### `standardDimension`

The system standard layout dimension for reserved layout size.

``` swift
public static var standardDimension: Double 
```

### `accessibilityIgnoresInvertColors`

A boolean value that determines whether the image inverts its colors
when the user turns on the Invert Colors accessibility setting.

``` swift
public var accessibilityIgnoresInvertColors: Bool = false
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

### `resolvedTintColor(for:)`

Generates the resolved tint color for the specified tint color, using
the tint color and color transformer.

``` swift
public func resolvedTintColor(for tintColor: Color) -> Color 
```

### `hash(into:)`

``` swift
public func hash(into hasher: inout Hasher) 
```

## Operators

### `==`

``` swift
public static func ==(_ lhs: ListContentConfiguration.ImageProperties,
                        _ rhs: ListContentConfiguration.ImageProperties)
      -> Bool 
```
