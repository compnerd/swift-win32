---
layout: default
title: LayoutGuide
parent: SwiftWin32
---
# LayoutGuide

``` swift
public class LayoutGuide 
```

## Properties

### `identifier`

A string used to identify the layout guide.

``` swift
public var identifier: String = ""
```

### `layoutFrame`

The layout guide's frame in its owning view's coordinate system.

``` swift
public private(set) var layoutFrame: Rect = .zero
```

### `owningView`

The view that owns the layout guide.

``` swift
public weak var owningView: View?
```

### `bottomAnchor`

A layout anchor representing the bottom edge of the layout guide's frame.

``` swift
public var bottomAnchor: LayoutYAxisAnchor 
```

### `centerXAnchor`

A layout anchor representing the horizontal center of the layout guide's
frame.

``` swift
public var centerXAnchor: LayoutXAxisAnchor 
```

### `centerYAnchor`

A layout anchor representing the vertical center of the layout guide's
frame.

``` swift
public var centerYAnchor: LayoutYAxisAnchor 
```

### `heightAnchor`

A layout anchor representing the height of the layout guide's frame.

``` swift
public var heightAnchor: LayoutDimension 
```

### `leadingAnchor`

A layout anchor representing the leading edge of the layout guide's frame.

``` swift
public var leadingAnchor: LayoutXAxisAnchor 
```

### `leftAnchor`

A layout anchor representing the left edge of the layout guide's frame.

``` swift
public var leftAnchor: LayoutXAxisAnchor 
```

### `rightAnchor`

A layout anchor representing the right edge of the layout guide's frame.

``` swift
public var rightAnchor: LayoutXAxisAnchor 
```

### `topAnchor`

A layout anchor representing the top edge of teh layout guide's frame.

``` swift
public var topAnchor: LayoutYAxisAnchor 
```

### `trailingAnchor`

A layout anchor representing the trailing edge of teh layout guide's
frame.

``` swift
public var trailingAnchor: LayoutXAxisAnchor 
```

### `widthAnchor`

A layout anchor representing the width of the layout guide's frame.

``` swift
public var widthAnchor: LayoutDimension 
```
