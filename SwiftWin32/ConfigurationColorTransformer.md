---
layout: default
title: ConfigurationColorTransformer
parent: SwiftWin32
---
# ConfigurationColorTransformer

A transformer that generates a modified output color from an input color.

``` swift
public struct ConfigurationColorTransformer 
```

## Initializers

### `init(_:)`

Creates a color transformer with the specified closure.

``` swift
public init(_ transform: @escaping (Color) -> Color) 
```

## Properties

### `grayscale`

Creates a color transformer that generates a grayscale version of the
color.

``` swift
public static var grayscale: ConfigurationColorTransformer 
```

### `preferredTint`

A color transformer that returns the preferred system accent color.

``` swift
public static var preferredTint: ConfigurationColorTransformer 
```

### `monochromeTint`

A color transformer that returns the color with a monochrome tint.

``` swift
public static var monochromeTint: ConfigurationColorTransformer 
```

### `transform`

The transform closure of the color transformer.

``` swift
public private(set) var transform: (Color) -> Color
```

## Methods

### `callAsFunction(_:)`

Calls the transform closure of the color transformer.

``` swift
public func callAsFunction(_ input: Color) -> Color 
```
