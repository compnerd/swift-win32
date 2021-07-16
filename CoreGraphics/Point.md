---
layout: default
title: Point
parent: CoreGraphics
---
# Point

A structure that contains a point in a two-dimensional coordinate system.

``` swift
public struct Point 
```

## Inheritance

`CustomDebugStringConvertible`

## Initializers

### `init(x:y:)`

Creates a point with coordinates specified as floating-point values.

``` swift
public init(x: Double, y: Double) 
```

### `init(x:y:)`

Creates a point with coordinates specified as integer values.

``` swift
public init(x: Int, y: Int) 
```

### `init()`

Creates a point with location (0,0).

``` swift
public init() 
```

## Properties

### `zero`

The point with location (0,0).

``` swift
public static var zero: Point 
```

### `x`

The x-coordinate of the point.

``` swift
public var x: Double
```

### `y`

The y-coordinate of the point.

``` swift
public var y: Double
```

### `debugDescription`

``` swift
public var debugDescription: String 
```

## Methods

### `applying(_:)`

Returns the point resulting from an affine transformation of an existing
point.

``` swift
public func applying(_ transform: AffineTransform) -> Point 
```
