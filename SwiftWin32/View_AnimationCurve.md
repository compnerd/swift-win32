---
layout: default
title: View.AnimationCurve
parent: SwiftWin32
---
# View.AnimationCurve

Specifies the supported animation curves.

``` swift
public enum AnimationCurve: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `easeInOut`

An ease-in ease-out curve causes the animation to begin slowly,
accelerate through the middle of its duration, and then slow again
before completing. This is the default curve for most animations.

``` swift
case easeInOut
```

### `easeIn`

An ease-in curve causes the animation to begin slowly, and then speed up
as it progresses.

``` swift
case easeIn
```

### `easeOut`

An ease-out curve causes the animation to begin quickly, and then slow
down as it completes.

``` swift
case easeOut
```

### `linear`

A linear animation curve causes an animation to occur evenly over its
duration.

``` swift
case linear
```
