---
layout: default
title: ViewControllerTransitionCoordinatorContext
parent: SwiftWin32
---
# ViewControllerTransitionCoordinatorContext

A set of methods that provides information about an in-progress view
controller transition.

``` swift
public protocol ViewControllerTransitionCoordinatorContext 
```

## Requirements

### viewController(forKey:​)

Returns the view controllers involved in the transition.

``` swift
func viewController(forKey key: TransitionContextViewControllerKey)
    -> ViewController?
```

### view(forKey:​)

Returns the specified view involved in the transition.

``` swift
func view(forKey key: TransitionContextViewKey) -> View?
```

### containerView

Returns the view in which the transition takes place.

``` swift
var containerView: View 
```

### presentationStyle

Returns the presentation style being used for the transition.

``` swift
var presentationStyle: ModalPresentationStyle 
```

### transitionDuration

Returns the noninteractive duration of a transition.

``` swift
var transitionDuration: TimeInterval 
```

### completionCurve

Returns the completion curve associated with the transition.

``` swift
var completionCurve: View.AnimationCurve 
```

### completionVelocity

Returns the starting velocity to use for any final animations.

``` swift
var completionVelocity: Double 
```

### percentComplete

Returns the percentage of completion for an interactive transition when it
moves to its noninteractive phase.

``` swift
var percentComplete: Double 
```

### initiallyInteractive

A Boolean value indicating whether the transition started as an
interactive transition.

``` swift
var initiallyInteractive: Bool 
```

### isInteractive

A Boolean value indicating whether the transition is currently interactive.

``` swift
var isInteractive: Bool 
```

### isAnimated

A Boolean value indicating whether the transition is explicitly animated.

``` swift
var isAnimated: Bool 
```

### isCancelled

A Boolean value indicating whether an interactive transition was cancelled.

``` swift
var isCancelled: Bool 
```

### isInterruptible

A Boolean value indicating whether the transition animations can be
interrupted.

``` swift
var isInterruptible: Bool 
```

### targetTransform

Returns a transform indicating the amount of rotation being applied during
the transition.

``` swift
var targetTransform: AffineTransform 
```
