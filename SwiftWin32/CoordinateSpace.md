---
layout: default
title: CoordinateSpace
parent: SwiftWin32
---
# CoordinateSpace

A set of methods for converting between different frames of reference on a
screen.

``` swift
public protocol CoordinateSpace 
```

## Requirements

### bounds

Getting the Bounds Rectangle
The bounds rectangle describing the item's location and size in its own
coordinate system.

``` swift
var bounds: Rect 
```

### convert(\_:​to:​)

Converting Between Coordinate Spaces
Converts a point from the coordinate space of the current object to the
specified coordinate space.

``` swift
func convert(_: Point, to: CoordinateSpace) -> Point
```

### convert(\_:​from:​)

Converts a point from the specified coordinate space to the coordinate
space of the current object.

``` swift
func convert(_: Point, from: CoordinateSpace) -> Point
```

### convert(\_:​to:​)

Converts a rectangle from the coordinate space of the current object to
the specified coordinate space.

``` swift
func convert(_: Rect, to: CoordinateSpace) -> Rect
```

### convert(\_:​from:​)

Converts a rectangle from the specified coordinate space to the coordinate
space of the current object.

``` swift
func convert(_: Rect, from: CoordinateSpace) -> Rect
```
