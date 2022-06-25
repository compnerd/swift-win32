---
layout: default
title: ViewImplicitlyAnimating
parent: SwiftWin32
---
# ViewImplicitlyAnimating

An interface for modifying an animation while it is running.

``` swift
public protocol ViewImplicitlyAnimating: ViewAnimating 
```

## Inheritance

[`ViewAnimating`](https://compnerd.github.io/swift-win32/SwiftWin32/ViewAnimating)

## Default Implementations

### `addAnimations(_:)`

``` swift
public func addAnimations(_ animation: @escaping () -> Void) 
```

### `addAnimations(_:delayFactor:)`

``` swift
public func addAnimations(_ animation: @escaping () -> Void,
                            delayFactor: Double) 
```

### `addCompletion(_:)`

``` swift
public func addCompletion(_ completion: @escaping (ViewAnimatingPosition) -> Void) 
```

### `continueAnimation(withTimingParameters:durationFactor:)`

``` swift
public func continueAnimation(withTimingParameters paramters: TimingCurveProvider?,
                                durationFactor: Double) 
```

## Requirements

### addAnimations(\_:​)

Adds the specified animation block to the animator.

``` swift
func addAnimations(_ animation: @escaping () -> Void)
```

### addAnimations(\_:​delayFactor:​)

Adds the specified animation block to the animator with a delay.

``` swift
func addAnimations(_ animation: @escaping () -> Void, delayFactor: Double)
```

### addCompletion(\_:​)

Adds the specified completion block to the animator.

``` swift
func addCompletion(_ completion: @escaping (ViewAnimatingPosition) -> Void)
```

### continueAnimation(withTimingParameters:​durationFactor:​)

Adjusts the final timing and duration of a paused animation.

``` swift
func continueAnimation(withTimingParameters paramters: TimingCurveProvider?,
                         durationFactor: Double)
```
