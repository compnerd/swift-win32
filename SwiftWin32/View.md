---
layout: default
title: View
parent: SwiftWin32
---
# View

An object that manages the content for a rectangular area on the screen.

``` swift
public class View: Responder 
```

## Inheritance

[`Responder`](https://compnerd.github.io/swift-win32/SwiftWin32/Responder), `Equatable`, [`TraitEnvironment`](https://compnerd.github.io/swift-win32/SwiftWin32/TraitEnvironment)

## Initializers

### `init(frame:)`

Initializes and returns a newly allocated view object with the specified
frame rectangle.

``` swift
public convenience init(frame: Rect) 
```

## Properties

### `backgroundColor`

The view's background color.

``` swift
public var backgroundColor: Color?
```

### `isHidden`

A boolean that determines if the view is hidden.

``` swift
public var isHidden: Bool 
```

### `isUserInteractionEnabled`

A boolean value that determines whether user events are ignored and removed
from the event queue.

``` swift
public var isUserInteractionEnabled: Bool 
```

### `frame`

The frame rectangle, which describes the view's location and size in it's
superview's coordinate system.

``` swift
public var frame: Rect 
```

### `bounds`

The bounds rectangle, which describes the view’s location and size in its
own coordinate system.

``` swift
public var bounds: Rect 
```

### `center`

The center point of the view's frame rectangle

``` swift
public var center: Point 
```

### `transform`

Specifies the transform applied to the view, relative to the center of its
bounds.

``` swift
public var transform: AffineTransform = .identity 
```

### `superview`

The receiver's superview, or `nil` if it has none.

``` swift
public private(set) weak var superview: View?
```

### `subviews`

The receiver's immediate subviews.

``` swift
public private(set) var subviews: [View] = []
```

### `window`

The receiver's window object, or `nil` if it has none.

``` swift
public private(set) weak var window: Window?
```

### `directionalLayoutMargins`

The default spacing to use when laying out content in a view, taking into
account the current language direction.

``` swift
public var directionalLayoutMargins: DirectionalEdgeInsets 
```

### `preservesSuperviewLayoutMargins`

A boolean value indicating whether the current view also respects the
margins of its superview.

``` swift
public var preservesSuperviewLayoutMargins: Bool = false
```

### `constraints`

The constraints held by the view.

``` swift
public private(set) var constraints: [LayoutConstraint] = []
```

### `bottomAnchor`

A layout anchor representing the bottom edge of the view's frame.

``` swift
public var bottomAnchor: LayoutYAxisAnchor 
```

### `centerXAnchor`

A layout anchor representing the horizontal center of the view's frame.

``` swift
public var centerXAnchor: LayoutXAxisAnchor 
```

### `centerYAnchor`

A layout anchor representing the vertical center of the view's frame.

``` swift
public var centerYAnchor: LayoutYAxisAnchor 
```

### `firstBaselineAnchor`

A layout anchor representing the baseline for the topmost line of text in
the view.

``` swift
public var firstBaselineAnchor: LayoutYAxisAnchor 
```

### `heightAnchor`

A layout anchor representing the height of the view's frame.

``` swift
public var heightAnchor: LayoutDimension 
```

### `lastBaselineAnchor`

A layout anchor representing the baseline for the bottommost line of text
in the view.

``` swift
public var lastBaselineAnchor: LayoutYAxisAnchor 
```

### `leadingAnchor`

A layout anchor representing the leading edge of the view's frame.

``` swift
public var leadingAnchor: LayoutXAxisAnchor 
```

### `leftAnchor`

A layout anchor representing the left edge of the view's frame.

``` swift
public var leftAnchor: LayoutXAxisAnchor 
```

### `rightAnchor`

A layout anchor representing the right edge of the view's frame.

``` swift
public var rightAnchor: LayoutXAxisAnchor 
```

### `topAnchor`

A layout anchor representing the top edge of the view's frame.

``` swift
public var topAnchor: LayoutYAxisAnchor 
```

### `trailingAnchor`

A layout anchor representing the top edge of the view's frame.

``` swift
public var trailingAnchor: LayoutXAxisAnchor 
```

### `widthAnchor`

A layout anchor representing the trailing edge of the view's frame.

``` swift
public var widthAnchor: LayoutDimension 
```

### `contentMode`

``` swift
public var contentMode: View.ContentMode = .scaleToFill
```

### `autoresizesSubviews`

Determines whether the receiver automatically resizes its subviews when
its bounds changes.

``` swift
public var autoresizesSubviews: Bool = true
```

### `autoresizingMask`

A bitmask that determines how the receiver resizes itself when its
superview's bounds changes.

``` swift
public var autoresizingMask: View.AutoresizingMask = .none
```

### `contentScaleFactor`

The scale factor applied to the view.

``` swift
public var contentScaleFactor: Float 
```

### `interactions`

The array of interactions for the view.

``` swift
public var interactions: [Interaction] = []
```

### `tag`

An integer that you can use to identify view objects in your application.

``` swift
public var tag: Int = 0
```

### `next`

``` swift
public override var next: Responder? 
```

### `traitCollection`

``` swift
public var traitCollection: TraitCollection 
```

## Methods

### `addSubview(_:)`

Add a subview to the end of the reciever's list of subviews.

``` swift
public func addSubview(_ view: View) 
```

### `bringSubviewToFront(_:)`

Moves the specified subview so that it appears on top of its siblings.

``` swift
public func bringSubviewToFront(_ view: View) 
```

### `sendSubviewToBack(_:)`

Moves the specified subview so that it appears behind its siblings.

``` swift
public func sendSubviewToBack(_ view: View) 
```

### `removeFromSuperview()`

Unlinks the view from its superview and its window, and removes it from
the responder chain.

``` swift
public func removeFromSuperview() 
```

### `insertSubview(_:at:)`

Inserts a subview at the specified index.

``` swift
public func insertSubview(_ view: View, at index: Int) 
```

### `insertSubview(_:aboveSubview:)`

Inserts a view above another view in the view hierarchy.

``` swift
public func insertSubview(_ view: View, aboveSubview subview: View) 
```

### `insertSubview(_:belowSubview:)`

Inserts a view below another view in the view hierarchy.

``` swift
public func insertSubview(_ view: View, belowSubview subview: View) 
```

### `exchangeSubview(at:withSubviewAt:)`

Exchanges the subviews at the specified indices.

``` swift
public func exchangeSubview(at index1: Int, withSubviewAt index2: Int) 
```

### `isDescendant(of:)`

Returns a boolean value indicating whether the receiver is a subview of a
given view or identical to that view.

``` swift
public func isDescendant(of view: View) -> Bool 
```

### `didAddSubview(_:)`

Informs the view that a subview was added.

``` swift
public func didAddSubview(_ subview: View) 
```

### `willRemoveSubview(_:)`

Informs the view that a subview is about to be removed.

``` swift
public func willRemoveSubview(_ subview: View) 
```

### `willMove(toSuperview:)`

Informs the view that its superview is about to change to the specified
superview.

``` swift
public func willMove(toSuperview: View?) 
```

### `didMoveToSuperview()`

Informs the view that its superview changed.

``` swift
public func didMoveToSuperview() 
```

### `willMove(toWindow:)`

Informs the view that its window object is about to change.

``` swift
public func willMove(toWindow: Window?) 
```

### `diMoveToWindow()`

Informs the view that its window object changed.

``` swift
public func diMoveToWindow() 
```

### `layoutMarginsDidChange()`

Informs the view that its layout margins changed.

``` swift
public func layoutMarginsDidChange() 
```

### `addConstraint(_:)`

Adds a constraint on the layout of the receiving view or its subviews.

``` swift
public func addConstraint(_ constraint: LayoutConstraint) 
```

### `removeConstraint(_:)`

Removes the specified constraint from the view.

``` swift
public func removeConstraint(_ constraint: LayoutConstraint) 
```

### `removeConstraints(_:)`

Removes the specified constraints from the view.

``` swift
public func removeConstraints(_ constraints: [LayoutConstraint]) 
```

### `sizeThatFits(_:)`

Asks the view to calculate and return the size that best fits the
specified size.

``` swift
public func sizeThatFits(_ size: Size) -> Size 
```

### `sizeToFit()`

Resizes and moves the receiver view so it just encloses its subviews.

``` swift
public func sizeToFit() 
```

### `draw(_:)`

Draws the receiver's image within the passed-in rectangle.

``` swift
public func draw(_ rect: Rect) 
```

### `setNeedsDisplay()`

Mark the receiver's entire bounds rectangle as needing to be redrawn.

``` swift
public func setNeedsDisplay() 
```

### `setNeedsDisplay(_:)`

Marks the specified rectangle of the receiver as needing to be redrawn.

``` swift
public func setNeedsDisplay(_ rect: Rect) 
```

### `addInteraction(_:)`

Adds an interaction to the view.

``` swift
public func addInteraction(_ interaction: Interaction) 
```

### `removeInteraction(_:)`

Removes an interaction from the view.

``` swift
public func removeInteraction(_ interaction: Interaction) 
```

### `viewWithTag(_:)`

Returns the view whose tag matches the specified value.

``` swift
public func viewWithTag(_ tag: Int) -> View? 
```

### `convert(_:to:)`

Converts a point from the receiver’s coordinate system to that of the
specified view.

``` swift
public func convert(_ point: Point, to view: View?) -> Point 
```

### `convert(_:from:)`

Converts a point from the coordinate system of a given view to that of the
receiver.

``` swift
public func convert(_ point: Point, from view: View?) -> Point 
```

### `convert(_:to:)`

Converts a rectangle from the receiver’s coordinate system to that of
another view.

``` swift
public func convert(_ rect: Rect, to view: View?) -> Rect 
```

### `convert(_:from:)`

Converts a rectangle from the coordinate system of another view to that of
the receiver.

``` swift
public func convert(_ rect: Rect, from view: View?) -> Rect 
```

### `traitCollectionDidChange(_:)`

``` swift
public func traitCollectionDidChange(_ previousTraitCollection: TraitCollection?) 
```

## Operators

### `==`

``` swift
public static func ==(_ lhs: View, _ rhs: View) -> Bool 
```
