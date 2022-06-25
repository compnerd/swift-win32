---
layout: default
title: ViewControllerContextTransitioning
parent: SwiftWin32
---
# ViewControllerContextTransitioning

A set of methods that provide contextual information for transition
animations between view controllers.

``` swift
public protocol ViewControllerContextTransitioning 
```

## Requirements

### containerView

The view that acts as the superview for the views involved in the
transition.

``` swift
var containerView: View 
```

### viewController(forKey:​)

Returns a view controller involved in the transition.

``` swift
func viewController(forKey key: TransitionContextViewControllerKey)
      -> ViewController?
```

### view(forKey:​)

Returns the specified view involved in the transition.

``` swift
func view(forKey key: TransitionContextViewKey) -> View?
```

### initialFrame(for:​)

Returns the starting frame rectangle for the specified view controller's
view.

``` swift
func initialFrame(for viewController: ViewController) -> Rect
```

### finalFrame(for:​)

Returns the ending frame rectangle for the specified view controller's
view.

``` swift
func finalFrame(for viewController: ViewController) -> Rect
```

### isAnimated

A boolean value indicating whether the transition should be animated.

``` swift
var isAnimated: Bool 
```

### isInteractive

A boolean value indicating whether the transition is currently
interactive.

``` swift
var isInteractive: Bool 
```

### presentationStyle

Returns the presentation style for the view controller transition.

``` swift
var presentationStyle: ModalPresentationStyle 
```

### completeTransition(\_:​)

Notifies the system that the transition animation is done.

``` swift
func completeTransition(_ didComplete: Bool)
```

### updateInteractiveTransition(\_:​)

Updates the completion percentage of the transition.

``` swift
func updateInteractiveTransition(_ percentComplete: Double)
```

### pauseInteractiveTransition()

Tells the system to pause the animations.

``` swift
func pauseInteractiveTransition()
```

### finishInteractiveTransition()

Notifies the system that user interactions signaled the completion of the
transition.

``` swift
func finishInteractiveTransition()
```

### cancelInteractiveTransition()

Notifies the system that user interactions canceled the transition.

``` swift
func cancelInteractiveTransition()
```

### transitionWasCancelled

Returns a boolean value indicating whether the transition was canceled.

``` swift
var transitionWasCancelled: Bool 
```

### targetTransform

Returns a transform indicating the amount of rotation being applied during
the transition.

``` swift
var targetTransform: AffineTransform 
```
