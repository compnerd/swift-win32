---
layout: default
title: ViewControllerTransitionCoordinator
parent: SwiftWin32
---
# ViewControllerTransitionCoordinator

``` swift
public protocol ViewControllerTransitionCoordinator: ViewControllerTransitionCoordinatorContext 
```

## Inheritance

[`ViewControllerTransitionCoordinatorContext`](https://compnerd.github.io/swift-win32/SwiftWin32/ViewControllerTransitionCoordinatorContext)

## Requirements

### animate(alongsideTransition:​completion:​)

Responding to View Controller Transition Progress

``` swift
func animate(alongsideTransition animation: ((ViewControllerTransitionCoordinatorContext) -> Void)?,
               completion: ((ViewControllerTransitionCoordinatorContext) -> Void)?)
      -> Bool
```

### animateAlongsideTransition(in:​animation:​completion:​)

``` swift
func animateAlongsideTransition(in view: View?,
                                  animation: ((ViewControllerTransitionCoordinatorContext) -> Void)?,
                                  completion: ((ViewControllerTransitionCoordinatorContext) -> Void)?)
      -> Bool
```

### notifyWhenInteractionChanges(\_:​)

``` swift
func notifyWhenInteractionChanges(_ handler: @escaping (ViewControllerTransitionCoordinatorContext) -> Void)
```
