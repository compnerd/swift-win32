---
layout: default
title: ViewController
parent: SwiftWin32
---
# ViewController

An object that manages a view hierarchy for your application.

``` swift
public class ViewController: Responder 
```

## Inheritance

[`Responder`](https://compnerd.github.io/swift-win32/SwiftWin32/Responder), [`TraitEnvironment`](https://compnerd.github.io/swift-win32/SwiftWin32/TraitEnvironment), [`ContentContainer`](https://compnerd.github.io/swift-win32/SwiftWin32/ContentContainer), `Equatable`

## Initializers

### `init()`

``` swift
override public init() 
```

## Properties

### `view`

The view that the controller manages.

``` swift
public var view: View! 
```

This property represents the root view of the view controller's view
hierarchy. The default value of this property is `nil`.

If you access this property when its value is `nil`, the view controller
automatically calls the `loadView()` method and returns the resulting
view.

Each view controller is the sole owner of its view object. Don't associate
the same view object with multiple view controllers. The only exception is
that a container view controller implementation may add another view
controller's view object to its own view hierarchy. Before adding the
subview, the container must first call its `addChild(_:)` method to create
a parent-child relationship between the two view controller objects.

Because accessing this property can cause the view to be loaded
automatically, you can use `isViewLoaded` to determine if the view is
currently in memory. Unlike this property, `isViewLoaded` doesn't force
the loading of the view if it's not currently in memory.

### `viewIfLoaded`

The controller's view or `nil` if the view is not yet loaded.

``` swift
public private(set) var viewIfLoaded: View?
```

If the view controller's view has already been loaded, this property
contains that view. If the view has not yet been loaded, this property is
set to `nil`.

### `isViewLoaded`

Indicates if the view is loaded into memory.

``` swift
public var isViewLoaded: Bool 
```

The value of this property is `true` when the view is in memory or `false`
when it is not. Accessing this property does not attempt to load the view
if it is not currently in memory.

### `title`

A localized string that represents the view this controller manages.

``` swift
public var title: String? 
```

Set the title to a human-readable string that describes the view. If the
view controller has a valid navigation item or tab-bar item, assigning a
value to this property updates the title text of those objects.

### `preferredContentSize`

The preferred size for the view controller's view.

``` swift
public var preferredContentSize: Size 
```

The value in this property is used primarily when displaying the view
controller's content in a popover but may also be used in other
situations. Changing the value of this property while the view controller
is being displayed in a popover animates the size change; however, the
change is not animated if you specify a width or height of 0.0.

### `isBeingDismissed`

A boolean value indicating whether the view controller is being dismissed.

``` swift
public private(set) var isBeingDismissed: Bool = false
```

### `isBeingPresented`

A boolean value indicating whether the view controller is being presented.

``` swift
public private(set) var isBeingPresented: Bool = false
```

### `isMovingFromParent`

A boolean value indicating whether the view controller is being removed
from a parent view controller.

``` swift
public private(set) var isMovingFromParent: Bool = false
```

### `isMovingToParent`

A boolean value indicating whether the view controller is being moved to a
parent view controller.

``` swift
public private(set) var isMovingToParent: Bool = false
```

### `additionalSafeAreaInsets`

The inset distances for views.

``` swift
public var additionalSafeAreaInsets: EdgeInsets = .zero 
```

Use this property to adjust the safe area insets of this view controller's
views by the specified amount. The safe area defines the portion of your
view controller's visible area that is guaranteed to be unobscured by the
system status bar or by an ancestor-provided view such as the navigation
bar.

You might use this property to extend the safe area to include custom
content in your interface. For example, a drawing app might use this
property to avoid displaying content underneath tool palettes.

### `viewRespectsSystemMinimumLayoutMargins`

A boolean value indicating whether the view controller's view uses the
system-defined minimum layout margins.

``` swift
public var viewRespectsSystemMinimumLayoutMargins: Bool = true
```

When the value of this property is `true`, the root view's layout margins
are guaranteed to be no smaller than the values in the
`systemMinimumLayoutMargins` property. The default value of this property
is `true`.

Changing this property to `false` causes the view to obtain its margins
solely from its `directionalLayoutMargins` property. Setting the margins
in that property to 0 allows you to eliminate the view's margins
altogether.

### `systemMinimumLayoutMargins`

The minimum layout margins for the view controller's root view.

``` swift
public private(set) var systemMinimumLayoutMargins: DirectionalEdgeInsets = .zero 
```

This property contains the minimum layout margins expected by the system
for the view controller's root view. Do not override this property. To
stop considering the system's minimum layout margins for the root view,
set the `viewRespectsSystemMinimumLayoutMargins` property to `false`. This
property does not affect the margins associated with subviews of the root
view.

If you assign a custom value to the `directionalLayoutMargins` property of
the view controller's root view, the root view's actual margins are set to
either your custom values or the minimum values defined by this property,
whichever values are greater. For example, if the value for one system
minimum margin is 20 points and you specify a value of 10 for the same
margin on the view, the view uses the value 20 for the margin.

### `edgesForExtendedLayout`

The edges that you extend for your view controller.

``` swift
public var edgesForExtendedLayout: RectEdge = .all
```

Instead of this property, use the safe area of your view to determine
which parts of your interface are occluded by other content. For more
information, see the `safeAreaLayoutGuide` and `safeAreaInsets` properties
of `View`.

The default value of this property is `.all`, and it is recommended that
you do not change that value.

If you remove an edge value from this property, the system does not lay
out your content underneath other bars on that same edge. In addition, the
system provides a default background so that translucent bars have an
appropriate appearance. The window’s root view controller does not react
to this property.

### `extendedLayoutIncludesOpaqueBars`

A boolean value indicating whether or not the extended layout includes
opaque bars.

``` swift
public var extendedLayoutIncludesOpaqueBars: Bool = false
```

The default value of this property is `false`.

### `shouldAutorotate`

A boolean value that indicates whether the view controller's contents
should autorotate.

``` swift
public private(set) var shouldAutorotate: Bool = true
```

### `supportedInterfaceOrientations`

The interface orientations that the view controller supports.

``` swift
public private(set) var supportedInterfaceOrientations: InterfaceOrientationMask = .allButUpsideDown
```

This property returns a bit mask that specifies which orientations the
view controller supports. For more information, see
`InterfaceOrientationMask`.

When the device orientation changes, the system calls this method on the
root view controller or the topmost modal view controller that fills the
window. If the view controller supports the new orientation, the system
rotates the window and the view controller. The system only calls this
method if the view controller's `shouldAutorotate` method returns `true`.

Override this method to declare which orientations the view controller
supports. The default value is `.all`. The value you return must not be 0.

To determine whether to rotate, the system compares the view controller's
supported orientations with the app's supported orientations — as
determined by the `Info.plist` file or the app delegate's
`application(_:supportedInterfaceOrientationsFor:)` method — and the
device's supported orientations.

If your app supports multitasking, the system doesn't call this method on
your view controller because multitasking apps must support all
orientations. You can opt out of multitasking by enablin by not declaring
support for all possible orientations within the `Info.plist` file.

### `preferredInterfaceOrientationForPresentation`

The interface orientation to use when presenting the view controller.

``` swift
public private(set) var preferredInterfaceOrientationForPresentation: InterfaceOrientation = .portrait
```

The system calls this method when presenting the view controller full
screen. When your view controller supports two or more orientations but
the content appears best in one of those orientations, override this
method and return the preferred orientation.

If your view controller implements this method, your view controller's
view is shown in the preferred orientation (although it can later be
rotated to another supported rotation). If you do not implement this
method, the system presents the view controller using the current
orientation of the status bar.

### `modalPresentationStyle`

The presentation style for modal view controllers.

``` swift
public var modalPresentationStyle: ModalPresentationStyle = .automatic 
```

Presentation style defines how the system presents a modal view
controller. The system uses this value only in regular-width size classes.
In compact-width size classes, some styles take on the behavior of other
styles. You can influence this behavior by implementing the
`adaptivePresentationStyle(for:traitCollection:)` method.

Presentation style also impacts the content size of a modal view
controller. For example, `ModalPresentationStyle.pageSheet` uses an
explicit size that the system provides. By contrast,
`ModalPresentationStyle.formSheet` uses the view controller's
`preferredContentSize` property, which you can set.

The default value is `ModalPresentationStyle.automatic`. For a list of
presentation styles and their compatibility with the various transition
styles, see `ModalPresentationStyle`.

### `modalTransitionStyle`

The transition style to use when presenting the view controller.

``` swift
public var modalTransitionStyle: ModalTransitionStyle = .coverVertical
```

This property determines how the view controller's is animated onscreen
when it is presented using the `present(_:animated:completion:)` method.
To change the transition type, you must set this property before
presenting the view controller. The default value for this property is
`ModalTransitionStyle.coverVertical`.

For a list of possible transition styles, and their compatibility with the
available presentation styles, see the `ModalTransitionStyle` constant
descriptions.

### `isModalInPresentation`

A boolean value indicating whether the view controller enforces a modal
behavior.

``` swift
public var isModalInPresentation: Bool = false 
```

The default value of this property is `false`. When you set it to `true`,
the framework ignores events outside the view controller's bounds and
prevents the interactive dismissal of the view controller while it is
onscreen.

### `definesPresentationContext`

A boolean value that indicates whether this view controller's view is
covered when the view controller or one of its descendants presents a view
controller.

``` swift
public var definesPresentationContext: Bool = false 
```

When using the `ModalPresentationStyle.currentContext` or
`ModalPresentationStyle.overCurrentContext` style to present a view
controller, this property controls which existing view controller in your
view controller hierarchy is actually covered by the new content. When a
context-based presentation occurs, the framework starts at the presenting
view controller and walks up the view controller hierarchy. If it finds a
view controller whose value for this property is `true`, it asks that view
controller to present the new view controller. If no view controller
defines the presentation context, the framework asks the window's root
view controller to handle the presentation.

The default value for this property is `false`. Some system-provided view
controllers, such as `NavigationController`, change the default value to
`true`.

### `providesPresentationContextTransitionStyle`

A boolean value that indicates whether the view controller specifies the
transition style for view controllers it presents.

``` swift
public var providesPresentationContextTransitionStyle: Bool = false 
```

When a view controller's `definesPresentationContext` property is `true`,
it can replace the transition style of the presented view controller with
its own. When the value of this property to `true`, the current view
controller's transition style is used instead of the style associated with
the presented view controller. When the value of this property is `false`,
the framework uses the transition style of the presented view controller.
The default value of this property is `false`.

### `showDetailTargetDidChangeNotification`

Posted when a split view controller is expanded or collapsed.

``` swift
public class var showDetailTargetDidChangeNotification: NSNotification.Name 
```

When a view controller is using `show(_:sender:)` or
`showDetailViewController(_:sender:)`, it may need to know when a split
view controller higher in the view hierarchy has changed. This
notification is sent when a split view controller expands or collapses.
The object of this notification is the view controller that caused the
change.

### `transitioningDelegate`

The delegate object that provides transition animator, interactive
controller, and custom presentation controller objects.

``` swift
public weak var transitioningDelegate: ViewControllerTransitioningDelegate?
```

When the view controller's `modalPresentationStyle` property is
`ModalPresentationStyle.custom`, the framework uses the object in this
property to facilitate transitions and presentations for the view
controller. The transitioning delegate object is a custom object that you
provide and that conforms to the `ViewControllerTransitioningDelegate`
protocol. Its job is to vend the animator objects used to animate this
view controller's view onscreen and an optional presentation controller
to provide any additional chrome and animations.

### `transitionCoordinator`

Returns the active transition coordinator object.

``` swift
public private(set) var transitionCoordinator: ViewControllerTransitionCoordinator?
```

When a presentation or dismissal is in progress, this method returns the
transition coordinator object associated with that transition. If there is
no in-progress transition associated with the current view controller,
the framework checks the view controller's ancestors for a transition
coordinator object and returns that object if it exists. You can use this
object to create additional animations and synchronize them with the
transition animations.

Container view controllers can override this method but in most cases
should not need to. If you do override this method, first call `super` to
see if there is an appropriate transition coordinator to return, and, if
there is, return it.

For more information about the role of transition coordinators, see
`ViewControllerTransitionCoordinator`.

### `presentationController`

The presentation controller that's managing the current view controller.

``` swift
public private(set) var presentationController: PresentationController?
```

If the view controller is managed by a presentation controller, this
property contains that object. This property is `nil` if the view
controller isn't managed by a presentation controller.

If you've not yet presented the current view controller, accessing this
property creates a presentation controller based on the current value in
the `modalPresentationStyle` property. Always set the value of that
property before accessing any presentation controllers.

### `popoverPresentationController`

<dl>
<dt><code>false</code></dt>
<dd>

``` swift
public private(set) var popoverPresentationController: PopoverPresentationController?
```

</dd>
</dl>

### `restoresFocusAfterTransition`

A boolean value that indicates whether an item that previously was focused
should again become focused when the item's view controller becomes
visible and focusable.

``` swift
public var restoresFocusAfterTransition: Bool = true
```

When the value of this property is true, the item that was last focused
automatically becomes focused when its view controller becomes visible and
focusable. For example, if an item in the view controller is focused and a
second view controller is presented, the original item becomes focused
again when the second view controller is dismissed. The default value of
this property is `true`.

### `children`

An array of view controllers that are children of the current view
controller.

``` swift
public private(set) var children: [ViewController] = []
```

This property does not include any presented view controllers. This
property is only intended to be read by an implementation of a custom
container view controller.

### `shouldAutomaticallyForwardAppearanceMethods`

Returns a boolean value indicating whether appearance methods are
forwarded to child view controllers.

``` swift
public private(set) var shouldAutomaticallyForwardAppearanceMethods: Bool = true
```

This method is called to determine whether to automatically forward
appearance-related containment callbacks to child view controllers.

The default implementation returns true. Subclasses of the `ViewController`
class that implement containment logic may override this method to control
how these methods are forwarded. If you override this method and return
`false`, you are responsible for telling the child when its views are going
to appear or disappear. You do this by calling the child view controller's
`beginAppearanceTransition(_:animated:)` and `endAppearanceTransition()`
methods.

### `hierarchyInconsistencyException`

Raised if the view controller hierarchy is inconsistent with the view
hierarchy.

``` swift
public class var hierarchyInconsistencyException: NSExceptionName 
```

When a view controller's view is added to the view hierarchy, the system
walks up the view hierarchy to find the first parent view that has a view
controller. That view controller must be the parent of the view controller
whose view is being added. Otherwise, this exception is raised. This
consistency check is also performed when a view controller is added as a
child by calling the `addChild(_:)` method.

It is also allowed for a view controller that has no parent to add its
view to the view hierarchy. This is generally not recommended, but is
useful in some special cases.

### `presentingViewController`

The view controller that presented this view controller.

``` swift
public private(set) var presentingViewController: ViewController?
```

When you present a view controller modally (either explicitly or
implicitly) using the `present(_:animated:completion:)` method, the view
controller that was presented has this property set to the view controller
that presented it. If the view controller was not presented modally, but
one of its ancestors was, this property contains the view controller that
presented the ancestor. If neither the current view controller or any of
its ancestors were presented modally, the value in this property is `nil`.

### `presentedViewController`

The view controller that presented this view controller.

``` swift
public private(set) var presentedViewController: ViewController?
```

When you present a view controller modally (either explicitly or
implicitly) using the `present(_:animated:completion:)` method, the view
controller that called the method has this property set to the view
controller that it presented. If the current view controller did not
present another view controller modally, the value in this property is
`nil`.

### `parent`

The view controller that presented this view controller.

``` swift
public private(set) var parent: ViewController? 
```

If the recipient is a child of a container view controller, this property
holds the view controller it is contained in. If the recipient has no
parent, the value in this property is `nil`.

Use the `presentingViewController` property to access the presenting view
controller.

### `next`

``` swift
override public var next: Responder? 
```

### `traitCollection`

``` swift
public var traitCollection: TraitCollection 
```

## Methods

### `loadView()`

Creates the view that the controller manages.

``` swift
public func loadView() 
```

You should never call this method directly. The view controller calls this
method when its view property is requested but is currently `nil`. This
method loads or creates a view and assigns it to the view property.

You can override this method in order to create your views manually. If
you choose to do so, assign the root view of your view hierarchy to the
view property. The views you create should be unique instances and should
not be shared with any other view controller object. Your custom
implementation of this method should not call `super`.

If you want to perform any additional initialization of your views, do so
in the `viewDidLoad()` method.

### `viewDidLoad()`

Called after the controller's view is loaded info memory.

``` swift
public func viewDidLoad() 
```

This method is called after the view controller has loaded its view
hierarchy into memory.

### `loadViewIfNeeded()`

Loads the controller's view if it has not yet been loaded.

``` swift
public func loadViewIfNeeded() 
```

Calling this method loads the view controller's, creating the view as
needed based on the established rules.

### `viewWillAppear(_:)`

Notifies the view controller that its view is about to be added to a view
hierarchy.

``` swift
public func viewWillAppear(_ animated: Bool) 
```

This method is called before the view controller's view is about to be
added to a view hierarchy and before any animations are configured for
showing the view. You can override this method to perform custom tasks
associated with displaying the view. For example, you might use this
method to change the orientation or style of the status bar to coordinate
with the orientation or style of the view being presented. If you override
this method, you must call `super` at some point in your implementation.

### `viewDidAppear(_:)`

Notifies the view controller that its view was added to a view hierarchy.

``` swift
public func viewDidAppear(_ animated: Bool) 
```

You can override this method to perform additional tasks associated with
presenting the view. If you override this method, you must call `super` at
some point in your implementation.

  - Note
    If a view controller is presented by a view controller inside of a
    popover, this method is not invoked on the presenting view controller
    after the presented controller is dismissed.

### `viewWillDisappear(_:)`

Notifies the view controller that its view is about to be removed from a
view hierarchy.

``` swift
public func viewWillDisappear(_ animated: Bool) 
```

This method is called in response to a view being removed from a view
hierarchy. This method is called before the view is actually removed and
before any animations are configured.

Subclasses can override this method and use it to commit editing changes,
resign the first responder status of the view, or perform other relevant
tasks. For example, you might use this method to revert changes to the
orientation or style of the status bar that were made in the
`viewDidAppear(_:)` method when the view was first presented. If you
override this method, you must call `super` at some point in your
implementation.

### `viewDidDisappear(_:)`

Notifies the view controller that its view was removed from a view
hierarchy.

``` swift
public func viewDidDisappear(_ animated: Bool) 
```

You can override this method to perform additional tasks associated with
dismissing or hiding the view. If you override this method, you must call
`super` at some point in your implementation.

### `viewSafeAreaInsetsDidChange()`

Notifies the view controller that the safe area insets of its root view
changed.

``` swift
public func viewSafeAreaInsetsDidChange() 
```

Use this method to update your interface to accommodate the new safe area.
The framework updates the safe area in response to size changes to system
bars or when you modify the additional safe area insets of your view
controller. The framework also calls this method immediately before your
view appears onscreen.

### `viewLayoutMarginsDidChange()`

Notifies the view controller that the layout margins of its root view
changed.

``` swift
public func viewLayoutMarginsDidChange() 
```

Use this method to update the position of content based on the new margin
values.

### `viewWillLayoutSubviews()`

Notifies the view controller that its view is about to layout its
subviews.

``` swift
public func viewWillLayoutSubviews() 
```

When a view's bounds change, the view adjusts the position of its
subviews. Your view controller can override this method to make changes
before the view lays out its subviews. The default implementation of this
method does nothing.

### `viewDidLayoutSubviews()`

Notifes the view controller that its view has just laid out its subviews.

``` swift
public func viewDidLayoutSubviews() 
```

When the bounds change for a view controller's view, the view adjusts the
positions of its subviews and then the system calls this method. However,
this method being called does not indicate that the individual layouts of
the view's subviews have been adjusted. Each subview is responsible for
adjusting its own layout.

Your view controller can override this method to make changes after the
view lays out its subviews. The default implementation of this method does
nothing.

### `updateViewConstraints()`

Called when the view controller's view needs to update its constraints.

``` swift
public func updateViewConstraints() 
```

Override this method to optimize changes to your constraints.

  - Note
    It is almost always cleaner and easier to update a constraint
    immediately after the affecting change has occurred. For example, if you
    want to change a constraint in response to a button tap, make that
    change directly in the button's action method.
    
    You should only override this method when changing constraints in place
    is too slow, or when a view is producing a number of redundant changes.

To schedule a change, call `setNeedsUpdateConstraints()` on the view. The
system then calls your implementation of `updateViewConstraints()` before
the layout occurs. This lets you verify that all necessary constraints for
your content are in place at a time when your properties are not changing.

Your implementation must be as efficient as possible. Do not deactivate
all your constraints, then reactivate the ones you need. Instead, your app
must have some way of tracking your constraints, and validating them
during each update pass. Only change items that need to be changed. During
each update pass, you must ensure that you have the appropriate
constraints for the app’s current state.

Do not call `setNeedsUpdateConstraints()` inside your implementation.
Calling `setNeedsUpdateConstraints()` schedules another update pass,
creating a feedback loop.

  - Important
    Call `super.updateViewConstraints()` as the final step in your
    implementation.

### `attemptRotationToDeviceOrientation()`

Attempts to rotate all windows to the orientation of the device.

``` swift
public class func attemptRotationToDeviceOrientation() 
```

Some view controllers may want to use app-specific conditions to determine
what interface orientations are supported. If your view controller does
this, when those conditions change, your app should call this class
method. The system immediately attempts to rotate to the new orientation.

### `show(_:sender:)`

Presents a view controller in a primary context.

``` swift
public func show(_ viewController: ViewController, sender: Any?) 
```

You use this method to decouple the need to display a view controller from
the process of actually presenting that view controller onscreen. Using
this method, a view controller does not need to know whether it is
embedded inside a navigation controller or split-view controller. It calls
the same method for both. The `SplitViewController` and
`NavigationController` classes override this method and handle the
presentation according to their design. For example, a navigation
controller overrides this method and uses it to push a view controller
onto its navigation stack.

The default implementation of this method calls the
`targetViewController(forAction:sender:)` method to locate an object in
the view controller hierarchy that overrides this method. It then calls
the method on that target object, which displays the view controller in an
appropriate way. If the `targetViewController(forAction:sender:)` method
returns `nil`, this method uses the window's root view controller to
present the view controller modally.

You can override this method in custom view controllers to display the
view controller yourself. Use this method to display the view controller
in a primary context. For example, a container view controller might use
this method to replace its primary child. Your implementation should adapt
its behavior for both regular and compact environments.

### `showDetailViewController(_:sender:)`

Presents a view controller in a secondary (or detail) context.

``` swift
public func showDetailViewController(_ viewController: ViewController,
                                       sender: Any?) 
```

You use this method to decouple the need to display a view controller from
the process of actually presenting that view controller onscreen. Using
this method, a view controller does not need to know whether it is
embedded inside a navigation controller or split-view controller. It calls
the same method for both. In a regular environment, the
`SplitViewController` class overrides this method and installs the view
controller as its detail view controller; in a compact environment, the
split view controller's implementation of this method calls
`show(_:sender:)` instead.

The default implementation of this method calls the
`targetViewController(forAction:sender:)` method to locate an object in
the view controller hierarchy that overrides this method. It then calls
the method on that target object, which displays the view controller in an
appropriate way. If the `targetViewController(forAction:sender:)` method
returns `nil`, this method uses the window's root view controller to
present the view controller modally.

You can override this method in custom view controllers to display the
view controller yourself. Use this method to display the view controller
in a secondary context. For example, a container view controller might use
this method to replace its secondary child. Your implementation should
adapt its behavior for both regular and compact environments.

### `present(_:animated:completion:)`

Presents a view controller modally.

``` swift
public func present(_ viewController: ViewController, animated flag: Bool,
                      completion: (() -> Void)? = nil) 
```

In a horizontally regular environment, the view controller is presented in
the style specified by the `modalPresentationStyle` property. In a
horizontally compact environment, the view controller is presented full
screen by default. If you associate an adaptive delegate with the
presentation controller associated with the object in
`viewControllerToPresent`, you can modify the presentation style
dynamically.

The object on which you call this method may not always be the one that
handles the presentation. Each presentation style has different rules
governing its behavior. For example, a full-screen presentation must be
made by a view controller that itself covers the entire screen. If the
current view controller is unable to fulfill a request, it forwards the
request up the view controller hierarchy to its nearest parent, which can
then handle or forward the request.

Before displaying the view controller, this method resizes the presented
view controller's view based on the presentation style. For most
presentation styles, the resulting view is then animated onscreen using
the transition style in the `modalTransitionStyle` property of the
presented view controller. For custom presentations, the view is animated
onscreen using the presented view controller's transitioning delegate. For
current context presentations, the view may be animated onscreen using the
current view controller's transition style.

The completion handler is called after the `viewDidAppear(_:)` method is
called on the presented view controller.

### `dismiss(animated:completion:)`

Dismisses the view controller that was presented modally by the view
controller.

``` swift
public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) 
```

The presenting view controller is responsible for dismissing the view
controller it presented. If you call this method on the presented view
controller itself, the framework asks the presenting view controller to
handle the dismissal.

If you present several view controllers in succession, thus building a
stack of presented view controllers, calling this method on a view
controller lower in the stack dismisses its immediate child view
controller and all view controllers above that child on the stack. When
this happens, only the top-most view is dismissed in an animated fashion;
any intermediate view controllers are simply removed from the stack.
The top-most view is dismissed using its modal transition style, which may
differ from the styles used by other view controllers lower in the stack.

If you want to retain a reference to the view controller's presented view
controller, get the value in the `presentedViewController` property before
calling this method.

The completion handler is called after the `viewDidDisappear(_:)` method
is called on the presented view controller.

### `targetViewController(forAction:sender:)`

Returns the view controller that responds to the action.

``` swift
public func targetViewController<Target: AnyObject>(forAction action: (Target) -> () -> Void,
                                                      sender: Any?) -> ViewController? 
```

This method returns the current view controller if that view controller
overrides the method indicated by the action parameter. If the current
view controller does not override that method, the framework walks up the
view hierarchy and returns the first view controller that does override
it. If no view controller handles the action, this method returns `nil`.

A view controller can selectively respond to an action by returning an
appropriate value from its `canPerformAction(_:withSender:)` method.

### `targetViewController(forAction:sender:)`

``` swift
public func targetViewController<Target: AnyObject>(forAction action: (Target) -> (_: Any?) -> Void,
                                                      sender: Any?) -> ViewController? 
```

### `willMove(toParent:)`

Called just before the view controller is added or removed from a
container view controller.

``` swift
public func willMove(toParent viewController: ViewController?) 
```

### `didMove(toParent:)`

Called after the view controller is added or removed from a container view
controller.

``` swift
public func didMove(toParent viewController: ViewController?) 
```

### `addChild(_:)`

Adds the specified view controller as a child of the current view
controller.

``` swift
public func addChild(_ controller: ViewController) 
```

This method creates a parent-child relationship between the current view
controller and the object in the childController parameter. This
relationship is necessary when embedding the child view controller's view
into the current view controller's content. If the new child view
controller is already the child of a container view controller, it is
removed from that container before being added.

This method is only intended to be called by an implementation of a custom
container view controller. If you override this method, you must call
`super` in your implementation.

### `removeFromParent()`

Removes the view controller from its parent.

``` swift
public func removeFromParent() 
```

This method is only intended to be called by an implementation of a custom
container view controller. If you override this method, you must call
`super` in your implementation.

### `transition(from:to:duration:options:animations:completion:)`

Transitions between two of the view controller's child view controllers.

``` swift
public func transition(from source: ViewController,
                         to destination: ViewController, duration: TimeInterval,
                         options: View.AnimationOptions = [],
                         animations: (() -> Void)?,
                         completion: ((Bool) -> Void)? = nil) 
```

This method adds the second view controller's view to the view hierarchy
and then performs the animations defined in your animations block. After
the animation completes, it removes the first view controller's view from
the view hierarchy.

This method is only intended to be called by an implementation of a custom
container view controller. If you override this method, you must call
`super` in your implementation.

### `beginAppearanceTransition(_:animated:)`

Tells a child controller its appearance is about to change.

``` swift
public func beginAppearanceTransition(_ isAppearing: Bool, animated: Bool) 
```

If you are implementing a custom container controller, use this method to
tell the child that its views are about to appear or disappear. Do not
invoke `viewWillAppear(_:)`, `viewWillDisappear(_:)`, `viewDidAppear(_:)`,
or `viewDidDisappear(_:)` directly.

### `endAppearanceTransition()`

Tells a child controller its appearance has changed.

``` swift
public func endAppearanceTransition() 
```

If you are implementing a custom container controller, use this method to
tell the child that the view transition is complete.

### `setOverrideTraitCollection(_:forChild:)`

Changes the traits assigned to the specified child view controller.

``` swift
public func setOverrideTraitCollection(_ collection: TraitCollection?,
                                         forChild childViewController: ViewController) 
```

Usually, traits are passed unmodified from the parent view controller to
its child view controllers. When implementing a custom container view
controller, you can use this method to change the traits of any embedded
child view controllers to something more appropriate for your layout.
Making such a change alters other view controller behaviors associated
with that child. For example, modal presentations behave differently in a
horizontally compact versus horizontally regular environment. You might
also make such a change to force the same set of traits on the child view
controller regardless of the actual trait environment.

### `overrideTraitCollection(forChild:)`

Retrieves the trait collection for a child view controller.

``` swift
public func overrideTraitCollection(forChild childViewController: ViewController)
      -> TraitCollection? 
```

Use this method to retrieve the trait collection for a child view
controller. You can then modify the trait collection for the designated
child view controller and set it using the
`setOverrideTraitCollection(_:forChild:)` method.

### `willTransition(to:with:)`

Notifies the container that the size of its view is about to change.

``` swift
public func willTransition(to: Size,
                             with coodinator: ViewControllerTransitionCoordinator) 
```

### `willTransition(to:with:)`

Notifies the container that its trait collection changed.

``` swift
public func willTransition(to: TraitCollection,
                             with coordinator: ViewControllerTransitionCoordinator) 
```

### `size(forChildContentContainer:withParentContainerSize:)`

Returns the size of the specified child view controller’s content.

``` swift
public func size(forChildContentContainer container: ContentContainer,
                   withParentContainerSize parentSize: Size) -> Size 
```

### `preferredContentSizeDidChange(forChildContentContainer:)`

Notifies an interested controller that the preferred content size of one
of its children changed.

``` swift
public func preferredContentSizeDidChange(forChildContentContainer container: ContentContainer) 
```

### `systemLayoutFittingSizeDidChange(forChildContentContainer:)`

Notifies the container that a child view controller was resized using auto
layout.

``` swift
public func systemLayoutFittingSizeDidChange(forChildContentContainer container: ContentContainer) 
```

### `traitCollectionDidChange(_:)`

``` swift
public func traitCollectionDidChange(_ previousTraitCollection: TraitCollection?) 
```

## Operators

### `==`

``` swift
public static func ==(_ lhs: ViewController, _ rhs: ViewController) -> Bool 
```
