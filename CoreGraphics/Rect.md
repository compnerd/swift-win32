---
layout: default
title: Rect
parent: CoreGraphics
---
# Rect

A structure that contains the location and dimensions of a rectangle.

``` swift
public struct Rect 
```

## Inheritance

`CustomDebugStringConvertible`, `Equatable`

## Initializers

### `init(origin:size:)`

Creates a rectangle with the specified origin and size.

``` swift
public init(origin: Point, size: Size) 
```

### `init(x:y:width:height:)`

Creates a rectangle with coordinates and dimensions specified as
floating-point values.

``` swift
public init(x: Double, y: Double, width: Double, height: Double) 
```

### `init(x:y:width:height:)`

Creates a rectangle with coordinates and dimensions specified as integer
values.

``` swift
public init(x: Int, y: Int, width: Int, height: Int) 
```

### `init()`

Creates a rectangle with origin (0,0) and size (0,0).

``` swift
public init() 
```

## Properties

### `infinite`

A rectangle that has infinite extent.

``` swift
public static var infinite: Rect 
```

### `null`

The null rectangle, representing an invalid value.

``` swift
public static var null: Rect 
```

### `zero`

The rectangle whose origin and size are both zero.

``` swift
public static var zero: Rect 
```

### `origin`

A point that specifies the coordinates of the rectangle’s origin.

``` swift
public var origin: Point
```

### `size`

A size that specifies the height and width of the rectangle.

``` swift
public var size: Size
```

### `height`

Returns the height of a rectangle.

``` swift
public var height: Double 
```

### `width`

Returns the width of a rectangle.

``` swift
public var width: Double 
```

### `minX`

Returns the smallest value for the x-coordinate of the rectangle.

``` swift
public var minX: Double 
```

### `midX`

Returns the x-coordinate that establishes the center of a rectangle.

``` swift
public var midX: Double 
```

### `maxX`

Returns the largest value of the x-coordinate for the rectangle.

``` swift
public var maxX: Double 
```

### `minY`

Returns the smallest value for the y-coordinate of the rectangle.

``` swift
public var minY: Double 
```

### `midY`

Returns the y-coordinate that establishes the center of the rectangle.

``` swift
public var midY: Double 
```

### `maxY`

Returns the largest value for the y-coordinate of the rectangle.

``` swift
public var maxY: Double 
```

### `standardized`

Returns a rectangle with a positive width and height.

``` swift
public var standardized: Rect 
```

### `integral`

Returns the smallest rectangle that results from converting the source
rectangle values to integers.

``` swift
public var integral: Rect 
```

### `isEmpty`

Returns whether a rectangle has zero width or height, or is a null
rectangle.

``` swift
public var isEmpty: Bool 
```

### `isInfinite`

Returns whether a rectangle is infinite.

``` swift
public var isInfinite: Bool 
```

### `isNull`

Returns whether the rectangle is equal to the null rectangle.

``` swift
public var isNull: Bool 
```

### `debugDescription`

``` swift
public var debugDescription: String 
```

## Methods

### `applying(_:)`

Applies an affine transform to a rectangle.

``` swift
public func applying(_ transform: AffineTransform) -> Rect 
```

### `insetBy(dx:dy:)`

Returns a rectangle that is smaller or larger than the source rectangle,
with the same center point.

``` swift
public func insetBy(dx: Double, dy: Double) -> Rect 
```

### `offsetBy(dx:dy:)`

Returns a rectangle with an origin that is offset from that of the source
rectangle.

``` swift
public func offsetBy(dx: Double, dy: Double) -> Rect 
```

### `union(_:)`

Returns the smallest rectangle that contains the two source rectangles.

``` swift
public func union(_ rect: Rect) -> Rect 
```

### `intersection(_:)`

Returns the intersection of two rectangles.

``` swift
public func intersection(_ rect: Rect) -> Rect 
```

### `intersects(_:)`

Returns whether two rectangles intersect.

``` swift
public func intersects(_ rect: Rect) -> Bool 
```

### `contains(_:)`

Returns whether a rectangle contains a specified point.

``` swift
public func contains(_ point: Point) -> Bool 
```

### `contains(_:)`

Returns whether the first rectangle contains the second rectangle.

``` swift
public func contains(_ rect2: Rect) -> Bool 
```

## Operators

### `==`

``` swift
public static func == (lhs: Rect, rhs: Rect) -> Bool 
```
