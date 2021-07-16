---
layout: default
title: PointerInteraction
parent: SwiftWin32
---
# PointerInteraction

An interaction that enables support for effects on a view or customizes the
pointer's appearance within a region of an app.

``` swift
public class PointerInteraction 
```

## Inheritance

[`Interaction`](https://compnerd.github.io/swift-win32/SwiftWin32/Interaction)

## Initializers

### `init(delegate:)`

Initializes a pointer interaction object with a specified delegate object.

``` swift
public init(delegate: PointerInteractionDelegate?) 
```

## Properties

### `delegate`

An object that responds to pointer movements.

``` swift
public private(set) weak var delegate: PointerInteractionDelegate?
```

### `isEnabled`

A boolean value that indicates whether the pointer interaction is enabled.

``` swift
public var isEnabled: Bool = true
```

### `view`

``` swift
public private(set) weak var view: View?
```

## Methods

### `invalidate()`

Causes the interaction to update the pointer in response to an event.

``` swift
public func invalidate() 
```

### `didMove(to:)`

``` swift
public func didMove(to view: View?) 
```

### `willMove(to:)`

``` swift
public func willMove(to view: View?) 
```
