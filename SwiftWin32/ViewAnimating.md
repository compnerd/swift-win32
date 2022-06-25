---
layout: default
title: ViewAnimating
parent: SwiftWin32
---
# ViewAnimating

An interface for implementing custom animator objects.

``` swift
public protocol ViewAnimating 
```

## Requirements

### startAnimation()

Starts the animation from its current position.

``` swift
func startAnimation()
```

### startAnimation(afterDelay:​)

Starts the animation after the specified delay.

``` swift
func startAnimation(afterDelay delay: TimeInterval)
```

### pauseAnimation()

Pauses a running animation at its current position.

``` swift
func pauseAnimation()
```

### stopAnimation(\_:​)

Stops the animations at their current positions.

``` swift
func stopAnimation(_ withoutFinishing: Bool)
```

### finishAnimation(at:​)

Finishes the animations and returns the animator to the inactive state.

``` swift
func finishAnimation(at finalPositiong: ViewAnimatingPosition)
```

### fractionComplete

The completion percentage of the animation.

``` swift
var fractionComplete: Double 
```

### isReversed

A boolean value indicating whether the animation is running in the reverse
direction.

``` swift
var isReversed: Bool 
```

### state

The current state of the animation.

``` swift
var state: ViewAnimatingState 
```

### isRunning

A boolean value indicating whether the animation is currently running.

``` swift
var isRunning: Bool 
```
