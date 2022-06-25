---
layout: default
title: PointerEffect
parent: SwiftWin32
---
# PointerEffect

An effect that alters a view's appearance when a pointer enters the current
region.

``` swift
public enum PointerEffect 
```

## Enumeration Cases

### `automatic`

A pointer content effect with the given preview's view.

``` swift
case automatic(TargetedPreview)
```

### `highlight`

An effect where the pointer slides under the given view and morphs into
the view's shape.

``` swift
case highlight(TargetedPreview)
```

### `hover`

An effect where visual changes are applied to the view and the pointer
retains its default shape.

``` swift
case hover(TargetedPreview,
             preferredTintMode: PointerEffect.TintMode = .overlay,
             prefersShadow: Bool = false,
             prefersScaledContent: Bool = true)
```

### `lift`

An effect where the pointer slides under the given view and disappears as
the view scales up and gains a shadow.

``` swift
case lift(TargetedPreview)
```

## Properties

### `preview`

A preview of the view used during an interaction's animations.

``` swift
public var preview: TargetedPreview 
```
