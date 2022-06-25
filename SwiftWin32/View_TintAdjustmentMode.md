---
layout: default
title: View.TintAdjustmentMode
parent: SwiftWin32
---
# View.TintAdjustmentMode

The tint adjustment mode for the view.

``` swift
public enum TintAdjustmentMode: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `automatic`

The tint adjustment mode of the view is the same as its superview's tint
adjustment mode (or `ViewTintAdjustmentModeNormal` if the view has no
superview).

``` swift
case automatic
```

### `normal`

The view's tintColor property returns the completely unmodified tint
color of the view.

``` swift
case normal
```

### `dimmed`

The view's `tintColor` property returns a desaturated, dimmed version
of the view's original tint color.

``` swift
case dimmed
```
