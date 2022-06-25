---
layout: default
title: LayoutConstraint.Attribute
parent: SwiftWin32
---
# LayoutConstraint.Attribute

The part of the object's visual representation that should be used to get
the value for the constraint.

``` swift
public enum Attribute: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `left`

The left side of the object's alignment rectangle.

``` swift
case left
```

### `right`

The right side of  the object's alignment rectangle.

``` swift
case right
```

### `top`

The top of the object's alignment rectangle.

``` swift
case top
```

### `bottom`

The bottom of the object's alignment rectangle.

``` swift
case bottom
```

### `leading`

The leading edge of the object's alignment rectangle.

``` swift
case leading
```

### `trailing`

The trailing edge of the object's alignment rectangle.

``` swift
case trailing
```

### `width`

The width of the object's alignment rectangle.

``` swift
case width
```

### `height`

The height of the object's alignment rectangle.

``` swift
case height
```

### `centerX`

Tne center along the x-axis of the object's alignment rectangle.

``` swift
case centerX
```

### `centerY`

The center along the y-axis of the object's alignment rectangle.

``` swift
case centerY
```

### `lastBaseline`

The object's baseline.  For objects with more than one line of text, this
is the baseline for the bottom-most line of text.

``` swift
case lastBaseline
```

### `firstBaseline`

The object's baseline.  For objects with more than one line of text, this
is the baseline for the top-most line of text.

``` swift
case firstBaseline
```

### `leftMargin`

The object's left margin.  For `View` objects, the margins are defined by
their `layoutMargins` property.

``` swift
case leftMargin
```

### `rightMargin`

The object's right margin.  For `View` objects, the margins are defined by
their `layoutMargins` property.

``` swift
case rightMargin
```

### `topMargin`

The object's top margin.  For `View` objects, the margins are defined by
their `layoutMargins` property.

``` swift
case topMargin
```

### `bottomMargin`

The object's bottom margin.  For `View` objects, the margins are defined
by their `layoutMargins` property.

``` swift
case bottomMargin
```

### `leadingMargin`

The object's leading margin.  For `View` objects, the margins are defined
by their `layoutMargins` property.

``` swift
case leadingMargin
```

### `trailingMargin`

The object's trailing margin.  For `View` objects, the margins are defined
by thier `layoutMargins` property.

``` swift
case trailingMargin
```

### `centerXWithinMargins`

The center along the x-axis between the object's left and right margin.
For `View` objects, the margins are defined by their `layoutMargins`
property.

``` swift
case centerXWithinMargins
```

### `centerYWithinMargins`

The center along the y-axis between the object's top and bottom margin.
For `View` objects, the margins are defined by thier `layoutMargins`
property.

``` swift
case centerYWithinMargins
```

### `notAnAttribute`

A placeholder value that is used to indicate taht the constraint's second
item and second attribute are not used in any calculations.

``` swift
case notAnAttribute
```
