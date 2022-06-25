---
layout: default
title: LayoutXAxisAnchor
parent: SwiftWin32
---
# LayoutXAxisAnchor

A factory class for creating horizontal layout constraint objects using a
fluent API.

``` swift
public class LayoutXAxisAnchor: LayoutAnchor<LayoutXAxisAnchor> 
```

## Inheritance

`LayoutAnchor<LayoutXAxisAnchor>`

## Methods

### `constraint(equalToSystemSpacingBelow:multiplier:)`

Returns a constraint that defines by how much the current anchor trails
the specified anchor.

``` swift
public func constraint(equalToSystemSpacingBelow anchor: LayoutXAxisAnchor,
                         multiplier: Double) -> LayoutConstraint 
```

### `constraint(greaterThanOrEqualToSystemSpacingBelow:multiplier:)`

Returns a constraint that defines by how much the current anchor trails
the specified anchor.

``` swift
public func constraint(greaterThanOrEqualToSystemSpacingBelow anchor: LayoutXAxisAnchor,
                         multiplier: Double) -> LayoutConstraint 
```

### `constraint(lessThanOrEqualToSystemSpacingBelow:multiplier:)`

Returns a constraint that defines the minimum distance by which the
current anchor is positioned below the specified anchor.

``` swift
public func constraint(lessThanOrEqualToSystemSpacingBelow anchor: LayoutXAxisAnchor,
                         multiplier: Double) -> LayoutConstraint 
```

### `anchorWithOffset(to:)`

Creates a layout dimension object from two anchors.

``` swift
public func anchorWithOffset(to anchor: LayoutXAxisAnchor) -> LayoutDimension 
```
