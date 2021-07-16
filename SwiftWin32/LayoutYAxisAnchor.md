---
layout: default
title: LayoutYAxisAnchor
parent: SwiftWin32
---
# LayoutYAxisAnchor

A factory class for creating vertical layout constraint objects using a
fluent API.

``` swift
public class LayoutYAxisAnchor: LayoutAnchor<LayoutYAxisAnchor> 
```

## Inheritance

`LayoutAnchor<LayoutYAxisAnchor>`

## Methods

### `constraint(equalToSystemSpacingBelow:multiplier:)`

Returns a constraint that defines the specific distance at which the
current anchor is positioned below the specified anchor.

``` swift
public func constraint(equalToSystemSpacingBelow anchor: LayoutYAxisAnchor,
                         multiplier: Double) -> LayoutConstraint 
```

### `constraint(greaterThanOrEqualToSystemSpacingBelow:multiplier:)`

Returns a constraint that defines the minimum distance by which the
current anchor is positioned below the specified anchor.

``` swift
public func constraint(greaterThanOrEqualToSystemSpacingBelow anchor: LayoutYAxisAnchor,
                         multiplier: Double) -> LayoutConstraint 
```

### `constraint(lessThanOrEqualToSystemSpacingBelow:multiplier:)`

Returns a constraint that defines the maximum distance by which the
current anchor is positioned below the specified anchor.

``` swift
public func constraint(lessThanOrEqualToSystemSpacingBelow anchor: LayoutYAxisAnchor,
                         multiplier: Double) -> LayoutConstraint 
```

### `anchorWithOffset(to:)`

Creates a layout dimension object from two anchors.

``` swift
public func anchorWithOffset(to anchor: LayoutYAxisAnchor) -> LayoutDimension 
```
