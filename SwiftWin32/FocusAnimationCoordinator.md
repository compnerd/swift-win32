---
layout: default
title: FocusAnimationCoordinator
parent: SwiftWin32
---
# FocusAnimationCoordinator

A coordinator of focus-related animations during a focus update.

``` swift
public class FocusAnimationCoordinator 
```

## Methods

### `addCoordinatedFocusingAnimations(_:completion:)`

Runs the specified set of animations together with the system animations
for adding focus to an item.

``` swift
public func addCoordinatedFocusingAnimations(_ animations: ((FocusAnimationContext) -> Void)?,
                                               completion: (() -> Void)? = nil) 
```

### `addCoordinatedUnfocusingAnimations(_:completion:)`

Runs the specified set of animations together with the system animations
for removing focus from an item.

``` swift
public func addCoordinatedUnfocusingAnimations(_ animations: ((FocusAnimationContext) -> Void)?,
                                                 completion: (() -> Void)? = nil) 
```

### `addCoordinatedAnimations(_:completion:)`

Specifies the animations to coordinate with the active focus animation.

``` swift
public func addCoordinatedAnimations(_ animations: (() -> Void)?,
                                       completion: (() -> Void)? = nil) 
```
