---
layout: default
title: LayoutSupport
parent: SwiftWin32
---
# LayoutSupport

A set of methods that provide layout support and access to layout anchors.

``` swift
public protocol LayoutSupport 
```

## Requirements

### length

Provides the length, in points, of the portion of the view controller's
view that is overlaid by translucent or transparent bars.

``` swift
var length: Double 
```

### bottomAnchor

A layout anchor representing the guide's bottom edge.

``` swift
var bottomAnchor: LayoutYAxisAnchor 
```

### heightAnchor

A layout anchor repreenting the guide's height.

``` swift
var heightAnchor: LayoutDimension 
```

### topAnchor

A layout anchor representing the guide's top edge.

``` swift
var topAnchor: LayoutYAxisAnchor 
```
