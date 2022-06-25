---
layout: default
title: CubicTimingParameters
parent: SwiftWin32
---
# CubicTimingParameters

The timing information for animations in the form of a cubic Bézier curve.

``` swift
public class CubicTimingParameters 
```

## Initializers

### `init()`

Initializes the object with the system’s default timing curve.

``` swift
public init() 
```

### `init(animationCurve:)`

Initializes the object with the specified builtin timing curve.

``` swift
public init(animationCurve curve: View.AnimationCurve) 
```

### `init(controlPoint1:controlPoint2:)`

Initializes the object with the specified control points for a cubic
Bézier curve.

``` swift
public init(controlPoint1 point1: Point, controlPoint2 point2: Point) 
```

## Properties

### `animationCurve`

The standard builtin animation curve to use for timing.

``` swift
public private(set) var animationCurve: View.AnimationCurve
```

### `controlPoint1`

The first control point for the cubic Bézier curve.

``` swift
public private(set) var controlPoint1: Point
```

### `controlPoint2`

The second control point of the cubic Bézier curve.

``` swift
public private(set) var controlPoint2: Point
```
