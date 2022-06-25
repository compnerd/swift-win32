---
layout: default
title: PointerShape
parent: SwiftWin32
---
# PointerShape

An object that defines the shape of custom pointers.

``` swift
public enum PointerShape 
```

## Enumeration Cases

### `horizontalBeam`

The pointer morphs into a horizontal beam using the specified length.

``` swift
case horizontalBeam(length: Double)
```

### `verticalBeam`

The pointer morphs into a vertical beam using the specified length.

``` swift
case verticalBeam(length: Double)
```

### `path`

The pointer morphs into the given Bézier path.

``` swift
case path(BezierPath)
```

### `roundedRect`

The pointer morphs into a rounded rectangle using the provided corner
radius.

``` swift
case roundedRect(Rect, radius: Double = PointerShape.defaultCornerRadius)
```

## Properties

### `defaultCornerRadius`

The default corner radius for a pointer using a rounded rectangle.

``` swift
public static var defaultCornerRadius: Double 
```
