---
layout: default
title: Touch
parent: SwiftWin32
---
# Touch

An object representing the location, size, movement, and force of a touch
occurring on the screen.

``` swift
public class Touch 
```

## Inheritance

`Hashable`

## Properties

### `view`

Getting the Location of a Touch
The view to which touches are being delivered, if any.

``` swift
public let view: View?
```

### `timestamp`

Getting Touch Attriutes
The time when the touch occurred or when it was last mutated.

``` swift
public let timestamp: TimeInterval
```

## Methods

### `hash(into:)`

``` swift
public func hash(into hasher: inout Hasher) 
```

## Operators

### `==`

``` swift
public static func ==(_ lhs: Touch, _ rhs: Touch) -> Bool 
```
