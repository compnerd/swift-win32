---
layout: default
title: ViewAnimatingState
parent: SwiftWin32
---
# ViewAnimatingState

Constants indicating the current state of the animation.

``` swift
public enum ViewAnimatingState: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `inactive`

The animations have not yet started executing. This is the initial state
of the animator object.

``` swift
case inactive
```

### `active`

The animator object is active and animations are either running or paused.
An animator moves to this state after the first call to `startAnimation()`
or `pauseAnimation()`. It stays in the active state until the animations
finish naturally or until you call the `stopAnimation(_:​)` method.

``` swift
case active
```

### `stopped`

The animation is stopped. Putting an animation into this state ends the
animation and leaves any animatable properties at their current values,
instead of updating them to their intended final values. An animation
cannot be started while in this state.

``` swift
case stopped
```
