---
layout: default
title: TapGestureRecognizer
parent: SwiftWin32
---
# TapGestureRecognizer

A discrete gesture recognizer that interprets single or multiple taps.

``` swift
public class TapGestureRecognizer: GestureRecognizer 
```

## Inheritance

[`GestureRecognizer`](https://compnerd.github.io/swift-win32/SwiftWin32/GestureRecognizer)

## Properties

### `buttonMaskRequired`

The bitmask of the buttons the user must press for gesture recognition.

``` swift
public var buttonMaskRequired: Event.ButtonMask = [.primary]
```

### `numberOfTapsRequired`

The number of taps necessary for gesture recognition.

``` swift
public var numberOfTapsRequired: Int = 1
```

### `numberOfTouchesRequired`

The number of fingers that the user must tap for gesture recognition.

``` swift
public var numberOfTouchesRequired: Int = 1
```
