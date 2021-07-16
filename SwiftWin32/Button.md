---
layout: default
title: Button
parent: SwiftWin32
---
# Button

A control that executes your custom code in response to user interactions.

``` swift
public class Button: Control 
```

## Inheritance

[`Control`](https://compnerd.github.io/swift-win32/SwiftWin32/Control)

## Initializers

### `init(frame:)`

Creates a new button with the specified frame.

``` swift
public init(frame: Rect) 
```

### `init(frame:primaryAction:)`

Creates a new button with the specified frame, registers the primary
action event, and sets the title and image to the action's title and
image.

``` swift
public convenience init(frame: Rect, primaryAction: Action?) 
```

## Methods

### `setTitle(_:forState:)`

Sets the title to use for the specified state.

``` swift
public func setTitle(_ title: String?, forState state: Control.State) 
```
