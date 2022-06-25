---
layout: default
title: ViewControllerInteractiveTransitioning
parent: SwiftWin32
---
# ViewControllerInteractiveTransitioning

A set of methods that enable an object (such as a navigation controller) to
drive a view controller transition.

``` swift
public protocol ViewControllerInteractiveTransitioning 
```

## Default Implementations

### `wantsInteractiveStart`

``` swift
public var wantsInteractiveStart: Bool 
```

### `completionCurve`

``` swift
public var completionCurve: View.AnimationCurve 
```

### `completionSpeed`

``` swift
public var completionSpeed: Double 
```

## Requirements

### startInteractiveTransition(\_:​)

Called when the system needs to set up the interactive portions of a view
controller transition and start the animations.

``` swift
func startInteractiveTransition(_ transitionContext: ViewControllerContextTransitioning)
```

### wantsInteractiveStart

A boolean value indicating whether the transition is interactive when it
starts.

``` swift
var wantsInteractiveStart: Bool 
```

The value of this property is `true` when the transition is interactive
from the moment it starts. The property is `false` when the transition
starts off as noninteractive. However, even a transition that starts off
as noninteractive may become interactive later if it implements the
`interruptibleAnimator(using:)` method of the
`ViewControllerAnimatedTransitioning` protocol.

### completionCurve

Called when the system needs the animation completion curve for an
interactive view controller transition.

``` swift
var completionCurve: View.AnimationCurve 
```

### completionSpeed

Called when the system needs the speed at which to complete an interactive
transition, after the interactive portion is finished.

``` swift
var completionSpeed: Double 
```
