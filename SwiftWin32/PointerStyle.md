---
layout: default
title: PointerStyle
parent: SwiftWin32
---
# PointerStyle

An object that defines the pointer shape and effect.

``` swift
public class PointerStyle 
```

## Initializers

### `init(effect:shape:)`

Applies the provided content effect and pointer shape to the current
region.

``` swift
public convenience init(effect: PointerEffect, shape: PointerShape? = nil) 
```

### `init(shape:constrainedAxes:)`

Morphs the pointer into the provided shape when hovering over the current
region.

``` swift
public convenience init(shape: PointerShape, constrainedAxes: Axis = []) 
```

## Methods

### `hidden()`

Hides the pointer when it moves over the current region.

``` swift
public class func hidden() -> Self 
```
