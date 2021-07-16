---
layout: default
title: PointerRegionRequest
parent: SwiftWin32
---
# PointerRegionRequest

An object to describe the pointer's location in the interaction's view.

``` swift
public class PointerRegionRequest 
```

## Properties

### `location`

The location of the pointer in the interaction's view's coordinate space.

``` swift
public private(set) var location: Point
```

### `modifiers`

Key modifier flags representing keyboard keys pressed by the user at the
time of this request.

``` swift
public private(set) var modifiers: KeyModifierFlags
```
