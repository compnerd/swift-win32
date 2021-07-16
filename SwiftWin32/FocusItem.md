---
layout: default
title: FocusItem
parent: SwiftWin32
---
# FocusItem

An object that can become focused.

``` swift
public protocol FocusItem: FocusEnvironment 
```

## Inheritance

[`FocusEnvironment`](https://compnerd.github.io/swift-win32/SwiftWin32/FocusEnvironment)

## Default Implementations

### `isFocused`

``` swift
public var isFocused: Bool 
```

### `didHintFocusMovement(_:)`

``` swift
public func didHintFocusMovement(_ hint: FocusMovementHint) 
```

## Requirements

### canBecomeFocused

A boolean value that indicates whether the item can become focused.

``` swift
var canBecomeFocused: Bool 
```

### isFocused

A boolean value indicating whether the item is currently focused.

``` swift
var isFocused: Bool 
```

### frame

The geometric frame of the item.

``` swift
var frame: Rect 
```

### didHintFocusMovement(\_:​)

``` swift
func didHintFocusMovement(_ hint: FocusMovementHint)
```
