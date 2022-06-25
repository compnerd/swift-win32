---
layout: default
title: View.ContentMode
parent: SwiftWin32
---
# View.ContentMode

Options to specify how a view adjusts its content when its size changes.

``` swift
public enum ContentMode: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `scaleToFill`

Scale the content to fit the size of itself by changing the aspect ratio
of the content if necessary.

``` swift
case scaleToFill
```

### `scaleAspectFill`

Scale the content to fit the size of the view by maintaining the aspect
ratio.  Any remaining area of the view's bounds is transparent.

``` swift
case scaleAspectFill
```

### `redraw`

Scale the content to fill the size of the view.  Some portion of the
content may be clipped to fill the view's bounds.

``` swift
case redraw
```

### `center`

center the content in the view's bounds, keeping the proportions the
same.

``` swift
case center
```

### `top`

Center the content aligned to the top in the view's bounds.

``` swift
case top
```

### `bottom`

Center the content aligned at the bottom in the view's bounds.

``` swift
case bottom
```

### `left`

Align the content on the left of the view.

``` swift
case left
```

### `right`

Align the content on the right of the view.

``` swift
case right
```

### `topLeft`

Align the content in the top-left corner of the view.

``` swift
case topLeft
```

### `topRight`

Align the content in the top-right corner of the view.

``` swift
case topRight
```

### `bottomLeft`

Align the content in the bottom-left corner of the view.

``` swift
case bottomLeft
```

### `bottomRight`

Align the content in the bottom-right corner of the view.

``` swift
case bottomRight
```
