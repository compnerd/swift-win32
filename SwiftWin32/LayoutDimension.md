---
layout: default
title: LayoutDimension
parent: SwiftWin32
---
# LayoutDimension

A factory class for creating size-based layout constraint objects using a
fluent API.

``` swift
public class LayoutDimension: LayoutAnchor<LayoutDimension> 
```

## Inheritance

`LayoutAnchor<LayoutDimension>`

## Methods

### `constraint(equalTo:multiplier:)`

Returns a constraint that defines the anchor's size attribute as equal to
the specified anchor multiplied by the constant.

``` swift
public func constraint(equalTo anchor: LayoutDimension, multiplier: Double)
      -> LayoutConstraint 
```

### `constraint(equalTo:multiplier:constant:)`

Returns a constraint that defines the anchor's size attribute as equal to
the specified size attribute multiplied by a constant plus an offset.

``` swift
public func constraint(equalTo anchor: LayoutDimension, multiplier: Double,
                         constant offset: Double) -> LayoutConstraint 
```

### `constraint(equalToConstant:)`

Returns a constraint that defines a constant size for the anchor's size
attribute.

``` swift
public func constraint(equalToConstant constant: Double) -> LayoutConstraint 
```

### `constraint(greaterThanOrEqualTo:multiplier:)`

Returns a constraint that defines the anchor's size attribute as greater
than or equal to the specified anchor multiplied by the constant.

``` swift
public func constraint(greaterThanOrEqualTo anchor: LayoutDimension,
                         multiplier: Double) -> LayoutConstraint 
```

### `constraint(greaterThanOrEqualTo:multiplier:constant:)`

Returns a constraint that defines teh anchor's size attribute greater than
or equal to the specified anchor multiplied by the constant plus an
offset.

``` swift
public func constraint(greaterThanOrEqualTo anchor: LayoutDimension,
                         multiplier: Double, constant offset: Double)
      -> LayoutConstraint 
```

### `constraint(greaterThanOrEqualToConstant:)`

Returns a constraint that defines the minimum size for the anchor's size
attribute.

``` swift
public func constraint(greaterThanOrEqualToConstant constant: Double)
      -> LayoutConstraint 
```

### `constraint(lessThanOrEqualTo:multiplier:)`

Returns a constraint that defines the anchor's size attribute as less than
or requal to the specified anchor multiplied by the constant.

``` swift
public func constraint(lessThanOrEqualTo anchor: LayoutDimension,
                         multiplier: Double) -> LayoutConstraint 
```

### `constraint(lessThanOrEqualTo:multiplier:constant:)`

Returns a constraint that defines the anchor's size attribute as greater
than or equal to the specified anchor multiplied by the constant plus an
offset.

``` swift
public func constraint(lessThanOrEqualTo anchor: LayoutDimension,
                         multiplier: Double, constant offset: Double)
      -> LayoutConstraint 
```

### `constraint(lessThanOrEqualToConstant:)`

Returns a constraint that defines the maximum size for teh anchor's size
attribute.

``` swift
public func constraint(lessThanOrEqualToConstant constant: Double)
      -> LayoutConstraint 
```
