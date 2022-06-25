---
layout: default
title: ViewControllerTransitioningDelegate
parent: SwiftWin32
---
# ViewControllerTransitioningDelegate

A set of methods that vend objects used to manage a fixed-length or
interactive transition between view controllers.

``` swift
public protocol ViewControllerTransitioningDelegate: AnyObject 
```

## Inheritance

`AnyObject`

## Default Implementations

### `animationController(forPresented:presenting:source:)`

``` swift
public func animationController(forPresented presented: ViewController,
                                  presenting: ViewController, source: ViewController)
      -> ViewControllerAnimatedTransitioning? 
```

### `animationController(forDismissed:)`

``` swift
public func animationController(forDismissed dismissed: ViewController)
      -> ViewControllerAnimatedTransitioning? 
```

### `interactionControllerForPresentation(using:)`

``` swift
public func interactionControllerForPresentation(using animator: ViewControllerAnimatedTransitioning)
      -> ViewControllerInteractiveTransitioning? 
```

### `interactionControllerForDismissal(using:)`

``` swift
public func interactionControllerForDismissal(using animator: ViewControllerAnimatedTransitioning)
      -> ViewControllerInteractiveTransitioning? 
```

### `presentationController(forPresented:presenting:source:)`

``` swift
public func presentationController(forPresented presented: ViewController,
                                     presenting: ViewController?,
                                     source: ViewController)
      -> PresentationController? 
```

## Requirements

### animationController(forPresented:​presenting:​source:​)

Asks your delegate for the transition animator object to use when
presenting a view controller.

``` swift
func animationController(forPresented presented: ViewController,
                           presenting: ViewController, source: ViewController)
      -> ViewControllerAnimatedTransitioning?
```

### animationController(forDismissed:​)

Asks your delegate for the transition animator object to use when
dismissing a view controller.

``` swift
func animationController(forDismissed dismissed: ViewController)
      -> ViewControllerAnimatedTransitioning?
```

### interactionControllerForPresentation(using:​)

Asks your delegate for the interactive animator object to use when
presenting a view controller.

``` swift
func interactionControllerForPresentation(using animator: ViewControllerAnimatedTransitioning)
      -> ViewControllerInteractiveTransitioning?
```

### interactionControllerForDismissal(using:​)

Asks your delegate for the interactive animator object to use when
dismissing a view controller.

``` swift
func interactionControllerForDismissal(using animator: ViewControllerAnimatedTransitioning)
      -> ViewControllerInteractiveTransitioning?
```

### presentationController(forPresented:​presenting:​source:​)

Asks your delegate for the custom presentation controller to use for
managing the view hierarchy when presenting a view controller.

``` swift
func presentationController(forPresented presented: ViewController,
                              presenting: ViewController?,
                              source: ViewController)
      -> PresentationController?
```
