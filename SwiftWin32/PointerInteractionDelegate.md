---
layout: default
title: PointerInteractionDelegate
parent: SwiftWin32
---
# PointerInteractionDelegate

An interface for handling pointer movements within the interaction's view.

``` swift
public protocol PointerInteractionDelegate: AnyObject 
```

## Inheritance

`AnyObject`

## Default Implementations

### `pointerInteraction(_:regionFor:defaultRegion:)`

``` swift
public func pointerInteraction(_ interaction: PointerInteraction,
                                 regionFor request: PointerRegionRequest,
                                 defaultRegion: PointerRegion)
      -> PointerRegion? 
```

### `pointerInteraction(_:styleFor:)`

``` swift
public func pointerInteraction(_ interaction: PointerInteraction,
                                 styleFor region: PointerRegion)
      -> PointerStyle? 
```

### `pointerInteraction(_:willEnter:animator:)`

``` swift
public func pointerInteraction(_ interaction: PointerInteraction,
                                 willEnter region: PointerRegion,
                                 animator: PointerInteractionAnimating) 
```

### `pointerInteraction(_:willExit:animator:)`

``` swift
public func pointerInteraction(_ interaction: PointerInteraction,
                                 willExit region: PointerRegion,
                                 animator: PointerInteractionAnimating) 
```

## Requirements

### pointerInteraction(\_:​regionFor:​defaultRegion:​)

Asks the delegate for a region as the pointer moves within the
interaction's view.

``` swift
func pointerInteraction(_ interaction: PointerInteraction,
                          regionFor request: PointerRegionRequest,
                          defaultRegion: PointerRegion) -> PointerRegion?
```

### pointerInteraction(\_:​styleFor:​)

Asks the delegate for a pointer style after an interaction receives a new
region.

``` swift
func pointerInteraction(_ interaction: PointerInteraction,
                          styleFor region: PointerRegion) -> PointerStyle?
```

### pointerInteraction(\_:​willEnter:​animator:​)

Informs the delegate when the pointer enters a given region.

``` swift
func pointerInteraction(_ interaction: PointerInteraction,
                          willEnter region: PointerRegion,
                          animator: PointerInteractionAnimating)
```

### pointerInteraction(\_:​willExit:​animator:​)

Informs the delegate when the pointer exits a given region.

``` swift
func pointerInteraction(_ interaction: PointerInteraction,
                          willExit region: PointerRegion,
                          animator: PointerInteractionAnimating)
```
