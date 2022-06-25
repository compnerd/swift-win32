---
layout: default
title: LayoutConstraint.Relation
parent: SwiftWin32
---
# LayoutConstraint.Relation

The relation between the first attribute and the modified second attribute
in a constraint.

``` swift
public enum Relation: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `lessThanOrEqual`

The constraint requires the first attribute to be less than or equal to
the modified second attribute.

``` swift
case lessThanOrEqual
```

### `equal`

The constraint requires the first attribute to be exactly equal to the
modified second attribute.

``` swift
case equal
```

### `greaterThanOrEqual`

The constraint requires the first attribute to be greater than or equal to
the modified second attribute.

``` swift
case greaterThanOrEqual
```
