---
layout: default
title: LayoutAnchor
parent: SwiftWin32
---
# LayoutAnchor

A factory class for creating layout constraint objects using a fluent API.

``` swift
public class LayoutAnchor<AnchorType: AnyObject> 
```

## Methods

### `constraint(equalTo:)`

Returns a constraint that defines one item's attribute as equal to
another.

``` swift
public func constraint(equalTo anchor: LayoutAnchor<AnchorType>)
      -> LayoutConstraint 
```

### `constraint(equalTo:constant:)`

Returns a constraint that defines one item's attribute as equal to another
item's attribute plus a constant offset.

``` swift
public func constraint(equalTo anchor: LayoutAnchor<AnchorType>,
                         constant offset: Double) -> LayoutConstraint 
```

### `constraint(greaterThanOrEqualTo:)`

Returns a constraint that defines one item's attribute as greater than or
equal to another.

``` swift
public func constraint(greaterThanOrEqualTo anchor: LayoutAnchor<AnchorType>)
      -> LayoutConstraint 
```

### `constraint(greaterThanOrEqualTo:constant:)`

Returns a constraint that defines one item's attribute as greater than or
equal to another item's attribute plus a constant offset.

``` swift
public func constraint(greaterThanOrEqualTo anchor: LayoutAnchor<AnchorType>,
                         constant offset: Double) -> LayoutConstraint 
```

### `constraint(lessThanOrEqualTo:)`

Returns a constraint that defines one item's attribute as less than or
equal to another.

``` swift
public func constraint(lessThanOrEqualTo anchor: LayoutAnchor<AnchorType>)
      -> LayoutConstraint 
```

### `constraint(lessThanOrEqualTo:constant:)`

Returns a constraint that defines one item's attribute as less than or
equal to another item's attribute plus a constant offset.

``` swift
public func constraint(lessThanOrEqualTo anchor: LayoutAnchor<AnchorType>,
                         constant offset: Double) -> LayoutConstraint 
```
