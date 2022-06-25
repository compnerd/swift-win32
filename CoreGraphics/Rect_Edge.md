---
layout: default
title: Rect.Edge
parent: CoreGraphics
---
# Rect.Edge

Coordinates that establish the edges of a rectangle.

``` swift
@frozen
  public enum Edge: UInt32 
```

## Inheritance

`UInt32`

## Enumeration Cases

### `minXEdge`

The minimum value for the x-coordinate of the rectangle.  In the default
coordinate space, this is the left edge of the rectangle.

``` swift
case minXEdge
```

### `minYEdge`

The minimum value for the y-coordinate of the rectangle.  In the default
coordinate space, this is the top edge of the rectangle.

``` swift
case minYEdge
```

### `maxXEdge`

The maximum value for the x-coordinate of the rectangle.  In the default
coordinate space, this is the right edge of the rectangle.

``` swift
case maxXEdge
```

### `maxYEdge`

The maximum value for the y-coordinate of the rectangle.  In the default
coordinate space, this is the bottom edge of the rectangle.

``` swift
case maxYEdge
```
