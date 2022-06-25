---
layout: default
title: View.AnimationOptions
parent: SwiftWin32
---
# View.AnimationOptions

Options for animating views using block objects.

``` swift
public struct AnimationOptions: OptionSet 
```

## Inheritance

`OptionSet`

## Nested Type Aliases

### `RawValue`

``` swift
public typealias RawValue = UInt
```

## Initializers

### `init(rawValue:)`

``` swift
public init(rawValue: RawValue) 
```

## Properties

### `rawValue`

``` swift
public let rawValue: RawValue
```

### `layoutSubviews`

Lay out subviews at commit time so that they are animated along with their
parent.

``` swift
public static var layoutSubviews: View.AnimationOptions 
```

### `allowUserInteraction`

Allow the user to interact with views while they are being animated.

``` swift
public static var allowUserInteraction: View.AnimationOptions 
```

### `beginFromCurrentState`

Start the animation from the current setting associated with an already
in-flight animation.

``` swift
public static var beginFromCurrentState: View.AnimationOptions 
```

If this key is not present, all in-flight animations are allowed to finish
before the new animation is started. If another animation is not in
flight, this key has no effect.

### `` `repeat` ``

Repeat the animation indefinitely.

``` swift
public static var `repeat`: View.AnimationOptions 
```

### `autoreverse`

Run the animation backwards and forwards (must be combined with the repeat
option).

``` swift
public static var autoreverse: View.AnimationOptions 
```

### `overrideInheritedDuration`

Force the animation to use the original duration value specified when the
animation was submitted.

``` swift
public static var overrideInheritedDuration: View.AnimationOptions 
```

### `overrideInheritedCurve`

Force the animation to use the original curve value specified when the
animation was submitted.

``` swift
public static var overrideInheritedCurve: View.AnimationOptions 
```

If this key is not present, the animation inherits the curve of the
in-flight animation, if any.

### `allowAnimatedContent`

Animate the views by changing the property values dynamically and
redrawing the view.

``` swift
public static var allowAnimatedContent: View.AnimationOptions 
```

### `showHideTransitionViews`

Hide or show views during a view transition.

``` swift
public static var showHideTransitionViews: View.AnimationOptions 
```

When present, this key causes views to be hidden or shown (instead of
removed or added) when performing a view transition. Both views must
already be present in the parent view's hierarchy when using this key. If
this key is not present, the to-view in a transition is added to, and the
from-view is removed from, the parent view's list of subviews.

### `overrideInheritedOptions`

The option to not inherit the animation type or any options.

``` swift
public static var overrideInheritedOptions: View.AnimationOptions 
```

### `curveEaseInOut`

Specify an ease-in ease-out curve, which causes the animation to begin
slowly, accelerate through the middle of its duration, and then slow again
before completing.

``` swift
public static var curveEaseInOut: View.AnimationOptions 
```

### `curveEaseIn`

An ease-in curve causes the animation to begin slowly, and then speed up
as it progresses.

``` swift
public static var curveEaseIn: View.AnimationOptions 
```

### `curveEaseOut`

An ease-out curve causes the animation to begin quickly, and then slow as
it completes.

``` swift
public static var curveEaseOut: View.AnimationOptions 
```

### `curveLinear`

A linear animation curve causes an animation to occur evenly over its
duration.

``` swift
public static var curveLinear: View.AnimationOptions 
```

### `transitionFlipFromLeft`

A transition that flips a view around its vertical axis from left to right
(the left side of the view moves toward the front and right side toward
the back).

``` swift
public static var transitionFlipFromLeft: View.AnimationOptions 
```

### `transitionFlipFromRight`

A transition that flips a view around its vertical axis from right to left
(the right side of the view moves toward the front and left side toward
the back).

``` swift
public static var transitionFlipFromRight: View.AnimationOptions 
```

### `transitionCurlUp`

A transition that curls a view up from the bottom.

``` swift
public static var transitionCurlUp: View.AnimationOptions 
```

### `transitionCurlDown`

A transition that curls a view down from the top.

``` swift
public static var transitionCurlDown: View.AnimationOptions 
```

### `transitionCrossDissolve`

A transition that dissolves from one view to the next.

``` swift
public static var transitionCrossDissolve: View.AnimationOptions 
```

### `transitionFlipFromTop`

A transition that flips a view around its horizontal axis from top to
bottom (the top side of the view moves toward the front and the bottom
side toward the back).

``` swift
public static var transitionFlipFromTop: View.AnimationOptions 
```

### `preferredFramesPerSecond30`

A frame rate of 30 frames per second.

``` swift
public static var preferredFramesPerSecond30: View.AnimationOptions 
```

Specify this value to request a preferred frame rate. It's recommended
that you use the default value unless you have identified a specific need
for an explicit rate.

### `preferredFramesPerSecond60`

A frame rate of 60 frames per second.

``` swift
public static var preferredFramesPerSecond60: View.AnimationOptions 
```

Specify this value to request a preferred frame rate. It's recommended
that you use the default value unless you have identified a specific need
for an explicit rate.
