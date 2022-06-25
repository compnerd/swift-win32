---
layout: default
title: PresentationController
parent: SwiftWin32
---
# PresentationController

An object that manages the transition animations and the presentation of
view controllers onscreen.

``` swift
open class PresentationController 
```

## Initializers

### `init(presentedViewController:presenting:)`

Initializes and returns a presentation controller for transitioning
between the specified view controllers

``` swift
public init(presentedViewController: ViewController,
              presenting presentingViewController: ViewController?) 
```

This method is the designated initializer for the presentation controller.
You must call it from any custom initialization methods you define for
your presentation controller subclasses.

## Properties

### `delegate`

The delegate object for managing adaptive presentations.

``` swift
open weak var delegate: AdaptivePresentationControllerDelegate?
```

When the application's size changes, the presentation controller works
with this delegate object to determine an appropriate response. View
controllers presented using the `ModalPresentationStyle.formSheet`,
`ModalPresentationStyle.popover`, or `ModalPresentationStyle.custom` style
must change to use one of the full-screen presentation styles instead. The
delegate can also opt to change the presented view controller entirely.

The object you assign to this property must conform to the
`AdaptivePresentationControllerDelegate` protocol.

### `presentingViewController`

The view controller that is the starting point for the presentation.

``` swift
open private(set) var presentingViewController: ViewController
```

The object in this property could be the root view controller of the
window, a parent view controller that is marked as defining the current
context, or the last view controller that was presented onscreen. This
view controller may or may not be the same one whose
`present(_:animated:completion:)` method was called to initiate the
presentation process. It may also not be the view controller used to
initialize your presentation controller.

### `presentedViewController`

The view controller being presented.

``` swift
open private(set) var presentedViewController: ViewController
```

This object corresponds to the one passed as the first parameter of the
`present(_:animated:completion:)` method. The successful conclusion of the
presentation process causes this view controller's content to be displayed
onscreen.

### `containerView`

The view in which the presentation occurs.

``` swift
open private(set) var containerView: View?
```

The framework sets the value of this property shortly after receiving the
presentation controller from your transitioning delegate. The container
view is always an ancestor of the presented view controller's view. During
transition animations, the container view also contains the presenting
view controller's view. When adding custom views to a presentation, add
them to the container view.

If your transition also employs custom animator objects, those objects can
get this container view from the `containerView` property of the context
object provided by the framework.

### `presentedView`

The view to be animated by the animator objects during a transition.

``` swift
open private(set) var presentedView: View?
```

The default implementation of this method returns the presented view
controller's view. If you want to animate a different view, you may
override this method and return that view. The view you specify must
either be the presented view controller's view or must be one of its
ancestors.

The view returned by this method is given to the animator objects, which
are responsible for animating it onscreen. The animator objects retrieve
the view using the `view(forKey:)` method of the context object provided
by the framework.

The framework calls this method multiple times during the course of a
presentation, so your implementation should return the appropriate view as
quickly as possible. Do not use this method to actually configure your
view hierarchy. If you intend to return a custom view, configure your view
hierarchy in the `presentationTransitionWillBegin()` method.

### `frameOfPresentedViewInContainerView`

The frame rectangle to assign to the presented view at the end of the
animations.

``` swift
open var frameOfPresentedViewInContainerView: Rect
```

The default implementation of this method returns the frame rectangle of
the container view, which results in the presented view controller's
content occupying the entire presentation space. You can override this
method and return a different frame rectangle as needed. For example, you
might specify a smaller frame rectangle if you want some of the underlying
content to show around the edges of the presented view.

The framework calls this method multiple times during the course of a
presentation, so your implementation should return the same frame
rectangle each time. Do not use this method to make changes to your view
hierarchy or perform other one-time tasks.

### `overrideTraitCollection`

Interface traits for the presented view controller, to use in place of
traits from the current device environment.

``` swift
open var overrideTraitCollection: TraitCollection?
```

Use this property to provide an interface trait collection for the
presented view controller, overriding one or more values in the current
device trait environment.

Each value you place in the `overrideTraitCollection` property overrides
the corresponding value in the current device trait environment. For
example, the following code snippet shows how to override the display
scale for the presented view controller, leaving other traits as they are
provided by the system. Place such code, typically, in the implementation
file for the presenting view controller:

``` swift
viewController.presentationController.overrideTraitCollection = TraitCollection(traitsFrom: [.current, .init(displayScale: 1.5)])
self.present(viewController, animated: false, completion: nil)
```

The presenting view controller is not affected by use of this property.

The default value of the `overrideTraitCollection` property is `nil`,
which results in the full current device trait environment being used by
the presented view controller.

### `presentationStyle`

The presentation style of the presented view controller.

``` swift
open private(set) var presentationStyle: ModalPresentationStyle
```

This property is set to the presentation style of the presented view
controller. The presentation controller uses this style to determine the
initial appearance of the presented content.

### `adaptivePresentationStyle`

Returns the presentation style to use when the presented view controller
becomes horizontally compact.

``` swift
@available(*, unavailable)
  open var adaptivePresentationStyle: ModalPresentationStyle = .none
```

After the content managed by the presentation controller is onscreen, this
method returns the presentation style to use when transitioning to a
horizontally compact environment. This method is not meant to be
overridden. The implementation consults its delegate object and returns
the value provided by that object's `adaptivePresentationStyle(for:)`
method. Some system-supplied presentation controllers may also provide a
new style that is more suited for a compact environment. For example,
presentation controllers that manage popovers and form sheets return the
`ModalPresentationStyle.fullScreen` value.

This method only returns the presentation style to use in a horizontally
compact environment. It does not initiate a transition to the new style.
The system initiates the transition to the new style when the size class
actually changes. When transitioning to a new style, the actual
presentation controller object may change. As a result, do not cache the
presentation controller object in your code. Always retrieve it from your
view controller's presentationController property.

Use `adaptivePresentationStyle(for:)` instead.

### `shouldPresentInFullscreen`

A boolean value indicating whether the presentation covers the entire
screen.

``` swift
open private(set) var shouldPresentInFullscreen: Bool = true
```

The default implementation of this method returns `true`, indicating that
the presentation covers the entire screen. You can override this method
and return `false` to force the presentation to display only in the
current context.

If you override this method, do not call `super`.

### `shouldRemovePresentersView`

A boolean value indicating whether the presenting view controller's view
should be removed when the presentation animations finish.

``` swift
open private(set) var shouldRemovePresentersView: Bool = false
```

The default implementation of this method returns `false`. If you
implement a presentation that does not cover the presenting view
controller's content entirely, override this method and return `false`.

If you override this method, do not call `super`.

## Methods

### `containerViewWillLayoutSubviews()`

Notifies the presentation controller that layout is about to begin on the
views of the container view.

``` swift
open func containerViewWillLayoutSubviews() 
```

The framework calls this method before adjusting the layout of the views
in the container view. Use this method and the
`containerViewDidLayoutSubviews()` method to update any custom views
managed by your presentation controller.

### `containerViewDidLayoutSubviews()`

Called to notify the presentation controller that layout ended on the
views of the container view.

``` swift
open func containerViewDidLayoutSubviews() 
```

The framework calls this method after adjusting the layout of the views in
the container view. Use this method to make any additional changes to the
view hierarchy.

### `presentationTransitionWillBegin()`

Notifies the presentation controller that the presentation animations are
about to start.

``` swift
open func presentationTransitionWillBegin() 
```

The default implementation of this method does nothing. Subclasses can
override it and use it to add custom views to the view hierarchy and to
create any animations associated with those views. To perform your
animations, get the transition coordinator of the presented view
controller and call its `animate(alongsideTransition:completion:)` or
`animateAlongsideTransition(in:animation:completion:)` method. Calling
those methods ensures that your animations are executed at the same time
as any other transition animations.

### `presentationTransitionDidEnd(_:)`

Notifies the presentation controller that the presentation animations
finished.

``` swift
open func presentationTransitionDidEnd(_ completed: Bool) 
```

The default implementation of this method does nothing. Subclasses can
override this method and use it to perform any required cleanup. For
example, if the `completed` parameter is `false`, you would use this
method to remove your presentation's custom views from the view hierarchy.

### `dismissalTransitionWillBegin()`

Notifies the presentation controller that the dismissal animations are
about to start.

``` swift
open func dismissalTransitionWillBegin() 
```

The default implementation of this method does nothing. Subclasses can
override this method and use it to configure any animations associated
with your presentation's custom views. To perform your animations, get
the transition coordinator of the presented view controller and call
its `animate(alongsideTransition:completion:)` or
`animateAlongsideTransition(in:animation:completion:)` method. Calling
those methods ensures that your animations are executed at the same time
as any other transition animations.

Do not use this method to remove your views from the view hierarchy.
Remove your views in the `dismissalTransitionDidEnd(_:)` method instead.

### `dismissalTransitionDidEnd(_:)`

Notifies the presentation controller that the dismissal animations
finished.

``` swift
open func dismissalTransitionDidEnd(_ completed: Bool) 
```

The default implementation of this method does nothing. Subclasses can
override this method and use it to remove any custom views that the
presentation controller added to the view hierarchy. Remove your views
only if the `completed` parameter is `true`.

### `adaptivePresentationStyle(for:)`

Returns the presentation style to use for the specified set of traits.

``` swift
open func adaptivePresentationStyle(for traitCollection: TraitCollection)
      -> ModalPresentationStyle 
```

After the content managed by the presentation controller is onscreen, this
method returns the presentation style to use for the specified set of
traits. The default implementation of this method consults its delegate
object and returns the value returned by that object’s
`adaptivePresentationStyle(for:traitCollection:)` method. Some
system-supplied presentation controllers may also provide a new style that
is more suited to the new set of traits.

This method returns the presentation style for the new traits, but does
not initiate a transition to the new style. The system initiates the
transition to the new style when the traits actually change. When
transitioning to new traits, the actual presentation controller object may
change. As a result, do not cache the presentation controller object in
your code. Always retrieve it from your view controller's
`presentationController` property.
