---
layout: default
title: PressesEvent
parent: SwiftWin32
---
# PressesEvent

An event that describes the state of a set of physical buttons that are
available to the device, such as those on an associated remote or game
controller.

``` swift
open class PressesEvent: Event 
```

## Inheritance

[`Event`](https://compnerd.github.io/swift-win32/SwiftWin32/Event)

## Properties

### `allPresses`

Returns the state of all physical buttons in the event.

``` swift
open private(set) var allPresses: Set<Press>
```

## Methods

### `presses(for:)`

Returns the state of all physical buttons in the event that are associated
with a particular gesture recognizer.

``` swift
open func presses(for guesture: GestureRecognizer) -> Set<Press> 
```
