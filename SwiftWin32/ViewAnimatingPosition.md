---
layout: default
title: ViewAnimatingPosition
parent: SwiftWin32
---
# ViewAnimatingPosition

Constants indicating positions within the animation.

``` swift
public enum ViewAnimatingPosition: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `end`

The end point of the animation. Use this constant when you want the final
values for any animatable properties — that is, you want to refer to the
values you specified in your animation blocks.

``` swift
case end
```

### `start`

The beginning of the animation. Use this constant when you want the
starting values for any animatable properties—that is, the values of the
properties before you applied any animations.

``` swift
case start
```

### `current`

The current position. Use this constant when you want the most recent
value set by an animator object.

``` swift
case current
```
