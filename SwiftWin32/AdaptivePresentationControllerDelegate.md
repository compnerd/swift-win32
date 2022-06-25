---
layout: default
title: AdaptivePresentationControllerDelegate
parent: SwiftWin32
---
# AdaptivePresentationControllerDelegate

A set of methods that, in conjunction with a presentation controller,
determine how to respond to trait changes in your application.

``` swift
public protocol AdaptivePresentationControllerDelegate: AnyObject 
```

## Inheritance

`AnyObject`

## Default Implementations

### `adaptivePresentationStyle(for:traitCollection:)`

``` swift
public func adaptivePresentationStyle(for controller: PresentationController,
                                        traitCollection: TraitCollection)
      -> ModalPresentationStyle 
```

### `adaptivePresentationStyle(for:)`

``` swift
public func adaptivePresentationStyle(for controller: PresentationController)
      -> ModalPresentationStyle 
```

### `presentationController(controller:viewControllerForAdaptivePresentationStyle:)`

``` swift
public func presentationController(controller: PresentationController,
                                     viewControllerForAdaptivePresentationStyle style: ModalPresentationStyle)
      -> ViewController? 
```

### `presentationController(_:willPresentWithAdaptiveStyle:transitionCoordinator:)`

``` swift
public func presentationController(_ controller: PresentationController,
                                     willPresentWithAdaptiveStyle style: ModalPresentationStyle,
                                     transitionCoordinator: ViewControllerTransitionCoordinator?) 
```

### `presentationControllerDidAttemptToDismiss(_:)`

``` swift
public func presentationControllerDidAttemptToDismiss(_ presentationController: PresentationController) 
```

### `presentationControllerShouldDismiss(_:)`

``` swift
public func presentationControllerShouldDismiss(_ presentationController: PresentationController) -> Bool 
```

### `presentationControllerDidDismiss(_:)`

``` swift
public func presentationControllerDidDismiss(_ presentationController: PresentationController) 
```

### `presentationControllerWillDismiss(_:)`

``` swift
public func presentationControllerWillDismiss(_ presentationController: PresentationController) 
```

### `presentationController(_:prepare:)`

``` swift
public func presentationController(_ presentationController: PresentationController,
                                     prepare adaptivePresentationController: PresentationController) 
```

## Requirements

### adaptivePresentationStyle(for:​traitCollection:​)

Asks the delegate for the presentation style to use when the specified set
of traits are active.

``` swift
func adaptivePresentationStyle(for controller: PresentationController,
                                 traitCollection: TraitCollection)
      -> ModalPresentationStyle
```

The presentation controller calls this method when the traits of the
current environment are about to change. Your implementation of this
method can return the preferred presentation style to use for the
specified traits. If you do not return one of the allowed styles, the
presentation controller uses its preferred default style.

If you do not implement this method in your delegate, the framework calls
the `adaptivePresentationStyle(for:)` method instead.

### adaptivePresentationStyle(for:​)

Asks the delegate for the new presentation style to use.

``` swift
func adaptivePresentationStyle(for controller: PresentationController)
      -> ModalPresentationStyle
```

Use the `adaptivePresentationStyle(for:traitCollection:)` method to handle
all trait changes instead of this method. If you do not implement that
method, you can use this method to change the presentation style when
transitioning to a horizontally compact environment.

If you do not implement this method or if you return an invalid style, the
current presentation controller returns its preferred default style.

### presentationController(\_:​viewControllerForAdaptivePresentationStyle:​)

Asks the delegate for the view controller to display when adapting to the
specified presentation style.

``` swift
func presentationController(_ controller: PresentationController,
                              viewControllerForAdaptivePresentationStyle style: ModalPresentationStyle)
      -> ViewController?
```

When a size class change causes a change to the underlying presentation
style, the presentation controller calls this method to ask for the view
controller to display in that new style. This method is your opportunity
to replace the current view controller with one that is better suited for
the new presentation style. For example, you might use this method to
insert a navigation controller into your view hierarchy to facilitate
pushing new view controllers more easily in the compact environment. In
that instance, you would return a navigation controller whose root view
controller is the currently presented view controller. You could also
return an entirely different view controller if you prefer.

If you do not implement this method or your implementation returns `nil`,
the presentation controller uses its existing presented view controller.

### presentationController(\_:​willPresentWithAdaptiveStyle:​transitionCoordinator:​)

Notifies the delegate that an adaptivity-related transition is about to
occur.

``` swift
func presentationController(_ presentationController: PresentationController,
                              willPresentWithAdaptiveStyle style: ModalPresentationStyle,
                              transitionCoordinator: ViewControllerTransitionCoordinator?)
```

When a size class change occurs, the framework calls this method to let
you know how the presentation controller will adapt. Use this method to
make any additional changes. For example, you might use the transition
coordinator object to create additional animations for the transition.

### presentationControllerDidAttemptToDismiss(\_:​)

Notifies the delegate that a user-initiated attempt to dismiss a view was
prevented.

``` swift
func presentationControllerDidAttemptToDismiss(_ presentationController: PresentationController)
```

The framework supports refusing to dismiss a presentation when the
`presentationController.isModalInPresentation` returns `true` or
`presentationControllerShouldDismiss(_:)` returns `false`.

Use this method to inform the user why the presentation can't be
dismissed, for example, by presenting an instance of `AlertController`.

### presentationControllerShouldDismiss(\_:​)

Asks the delegate for permission to dismiss the presentation.

``` swift
func presentationControllerShouldDismiss(_ presentationController: PresentationController)
      -> Bool
```

The system may call this method at any time. This method isn't guaranteed
to be followed by a call to `presentationControllerWillDismiss(_:)` or
`presentationControllerDidDismiss(_:)`. Make sure that your implementation
of this method returns quickly.

### presentationControllerDidDismiss(\_:​)

Notifies the delegate after a presentation is dismissed.

``` swift
func presentationControllerDidDismiss(_ presentationController: PresentationController)
```

This method is not called if the presentation is dismissed
programmatically.

### presentationControllerWillDismiss(\_:​)

Notifies the delegate before a presentation is dismissed.

``` swift
func presentationControllerWillDismiss(_ presentationController: PresentationController)
```

You can use this method to set up animations or interaction notifications
with the `presentationController`'s `transitionCoordinator`.

This method is not called if the presentation is dismissed
programmatically.

### presentationController(\_:​prepare:​)

Provides an opportunity to configure the adaptive presentation controller
after an adaptivity change.

``` swift
func presentationController(_ presentationController: PresentationController,
                              prepare adaptivePresentationController: PresentationController)
```

The system calls this method during adaptation so the delegate can
configure properties of the adaptive presentation controller before it
presents.

For example, the system automatically adapts a view controller that
presents as a popover in standard size classes to a sheet in compact size
classes. You can implement this method to customize the sheet's
properties before it presents.
