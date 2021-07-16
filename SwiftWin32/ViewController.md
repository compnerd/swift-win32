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

[`Responder`](https://compnerd.github.io/swift-win32/SwiftWin32/Responder), [`ContentContainer`](https://compnerd.github.io/swift-win32/SwiftWin32/ContentContainer), `Equatable`

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

### `viewIfLoaded`

The controller's view or `nil` if the view is not yet loaded.

``` swift
public private(set) var viewIfLoaded: View?
```

### `isViewLoaded`

Indicates if the view is loaded into memory.

``` swift
public var isViewLoaded: Bool 
```

### `title`

A localized string that represents the view this controller manages.

``` swift
public var title: String? 
```

### `preferredContentSize`

The preferred size for the view controller's view.

``` swift
public var preferredContentSize: Size 
```

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

### `viewRespectsSystemMinimumLayoutMargins`

A boolean value indicating whether the view controller's view uses the
system-defined minimum layout margins.

``` swift
public var viewRespectsSystemMinimumLayoutMargins: Bool = true
```

### `systemMinimumLayoutMargins`

The minimum layout margins for the view controller's root view.

``` swift
public private(set) var systemMinimumLayoutMargins: DirectionalEdgeInsets = .zero 
```

### `edgesForExtendedLayout`

The edges that you extend for your view controller.

``` swift
public var edgesForExtendedLayout: RectEdge = .all
```

### `extendedLayoutIncludesOpaqueBars`

A boolean value indicating whether or not the extended layout includes
opaque bars.

``` swift
public var extendedLayoutIncludesOpaqueBars: Bool = false
```

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

### `preferredInterfaceOrientationForPresentation`

The interface orientation to use when presenting the view controller.

``` swift
public private(set) var preferredInterfaceOrientationForPresentation: InterfaceOrientation = .portrait
```

### `modalPresentationStyle`

The presentation style for modal view controllers.

``` swift
public var modalPresentationStyle: ModalPresentationStyle = .automatic 
```

### `modalTransitionStyle`

The transition style to use when presenting the view controller.

``` swift
public var modalTransitionStyle: ModalTransitionStyle = .coverVertical
```

### `isModalInPresentation`

A boolean value indicating whether the view controller enforces a modal
behavior.

``` swift
public var isModalInPresentation: Bool = false 
```

### `definesPresentationContext`

A boolean value that indicates whether this view controller's view is
covered when the view controller or one of its descendants presents a view
controller.

``` swift
public var definesPresentationContext: Bool = false 
```

### `providesPresentationContextTransitionStyle`

A boolean value that indicates whether the view controller specifies the
transition style for view controllers it presents.

``` swift
public var providesPresentationContextTransitionStyle: Bool = false 
```

### `showDetailTargetDidChangeNotification`

Posted when a split view controller is expanded or collapsed.

``` swift
public class var showDetailTargetDidChangeNotification: NSNotification.Name 
```

### `children`

An array of view controllers that are children of the current view
controller.

``` swift
public private(set) var children: [ViewController] = []
```

### `presentingViewController`

The view controller that presented this view controller.

``` swift
public private(set) var presentingViewController: ViewController?
```

### `presentedViewController`

The view controller that presented this view controller.

``` swift
public private(set) var presentedViewController: ViewController?
```

### `parent`

The view controller that presented this view controller.

``` swift
public private(set) var parent: ViewController? 
```

### `next`

``` swift
override public var next: Responder? 
```

## Methods

### `loadView()`

Creates the view that the controller manages.

``` swift
public func loadView() 
```

### `viewDidLoad()`

Called after the controller's view is loaded info memory.

``` swift
public func viewDidLoad() 
```

### `loadViewIfNeeded()`

Loads the controller's view if it has not yet been loaded.

``` swift
public func loadViewIfNeeded() 
```

### `viewWillAppear(_:)`

Notifies the view controller that its view is about to be added to a view
hierarchy.

``` swift
public func viewWillAppear(_ animated: Bool) 
```

### `viewDidAppear(_:)`

Notifies the view controller that its view was added to a view hierarchy.

``` swift
public func viewDidAppear(_ animated: Bool) 
```

### `viewWillDisappear(_:)`

Notifies the view controller that its view is about to be removed from a
view hierarchy.

``` swift
public func viewWillDisappear(_ animated: Bool) 
```

### `viewDidDisappear(_:)`

Notifies the view controller that its view was removed from a view
hierarchy.

``` swift
public func viewDidDisappear(_ animated: Bool) 
```

### `viewSafeAreaInsetsDidChange()`

Notifies the view controller that the safe area insets of its root view
changed.

``` swift
public func viewSafeAreaInsetsDidChange() 
```

### `viewLayoutMarginsDidChange()`

Notifies the view controller that the layout margins of its root view
changed.

``` swift
public func viewLayoutMarginsDidChange() 
```

### `viewWillLayoutSubviews()`

Notifies the view controller that its view is about to layout its
subviews.

``` swift
public func viewWillLayoutSubviews() 
```

### `viewDidLayoutSubviews()`

Notifes the view controller that its view has just laid out its subviews.

``` swift
public func viewDidLayoutSubviews() 
```

### `updateViewConstraints()`

Called when the view controller's view needs to update its constraints.

``` swift
public func updateViewConstraints() 
```

### `attemptRotationToDeviceOrientation()`

Attempts to rotate all windows to the orientation of the device.

``` swift
public class func attemptRotationToDeviceOrientation() 
```

### `show(_:sender:)`

Presents a view controller in a primary context.

``` swift
public func show(_ viewController: ViewController, sender: Any?) 
```

### `showDetailViewController(_:sender:)`

Presents a view controller in a secondary (or detail) context.

``` swift
public func showDetailViewController(_ viewController: ViewController,
                                       sender: Any?) 
```

### `present(_:animated:completion:)`

Presents a view controller modally.

``` swift
public func present(_ viewController: ViewController, animated flag: Bool,
                      completion: (() -> Void)? = nil) 
```

### `dismiss(animated:completion:)`

Dismisses the view controller that was presented modally by the view
controller.

``` swift
public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) 
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

### `removeFromParent()`

Removes the view controller from its parent.

``` swift
public func removeFromParent() 
```

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

## Operators

### `==`

``` swift
public static func ==(_ lhs: ViewController, _ rhs: ViewController) -> Bool 
```
