---
layout: default
title: PointerInteractionAnimating
parent: SwiftWin32
---
# PointerInteractionAnimating

An interface for modifying an interaction animation in coordination with the
pointer effect animations.

``` swift
public protocol PointerInteractionAnimating 
```

## Requirements

### addAnimations(\_:​)

Adds the specified animation block to the animator.

``` swift
func addAnimations(_ animations: @escaping () -> Void)
```

### addCompletion(\_:​)

Adds the specified completion block to the animator.

``` swift
func addCompletion(_ completion: @escaping (Bool) -> Void)
```
