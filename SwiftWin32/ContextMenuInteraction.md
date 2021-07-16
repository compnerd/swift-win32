---
layout: default
title: ContextMenuInteraction
parent: SwiftWin32
---
# ContextMenuInteraction

An interaction object that you use to display relevant actions for your
content.

``` swift
public class ContextMenuInteraction: Interaction 
```

## Inheritance

[`Interaction`](https://compnerd.github.io/swift-win32/SwiftWin32/Interaction)

## Initializers

### `init(delegate:)`

Creates a context menu interaction object with the specified delegate
object.

``` swift
public init(delegate: ContextMenuInteractionDelegate) 
```

## Properties

### `delegate`

The object that provides the preview and contextual menu for your content
and responds to interaction-related events.

``` swift
public private(set) weak var delegate: ContextMenuInteractionDelegate?
```

### `view`

``` swift
public private(set) weak var view: View?
```

### `appearance`

The appearance of the context menu.

``` swift
public var appearance: ContextMenuInteraction.Appearance = .compact
```

## Methods

### `willMove(to:)`

``` swift
public func willMove(to view: View?) 
```

### `didMove(to:)`

``` swift
public func didMove(to view: View?) 
```

### `location(in:)`

Returns the location of the user interaction in the specified view's
coordinate system.

``` swift
public func location(in view: View?) -> Point 
```

### `dismissMenu()`

Dismisses the context menu.

``` swift
public func dismissMenu() 
```

### `updateVisibleMenu(_:)`

Updates the currently visible menu.

``` swift
public func updateVisibleMenu(_ block: (Menu) -> Menu) 
```
