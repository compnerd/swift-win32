---
layout: default
title: ViewControllerAnimatedTransitioning
parent: SwiftWin32
---
# ViewControllerAnimatedTransitioning

A set of methods for implementing the animations for a custom view controller
transition.

``` swift
public protocol ViewControllerAnimatedTransitioning 
```

## Default Implementations

### `animationEnded(_:)`

``` swift
public func animationEnded(_ transitionCompleted: Bool) 
```

## Requirements

### animateTransition(using:​)

Tells your animator object to perform the transition animations.

``` swift
func animateTransition(using transitionContext: ViewControllerContextTransitioning)
```

### animationEnded(\_:​)

Tells your animator object that the transition animations have finished.

``` swift
func animationEnded(_ transitionCompleted: Bool)
```

### transitionDuration(using:​)

Asks your animator object for the duration (in seconds) of the transition
animation.

``` swift
func transitionDuration(using transitionContext: ViewControllerContextTransitioning?)
      -> TimeInterval
```

### interruptibleAnimator(using:​)

Returns the interruptible animator to use during the transition.

``` swift
func interruptibleAnimator(using transitionContext: ViewControllerContextTransitioning)
      -> ViewImplicitlyAnimating
```
