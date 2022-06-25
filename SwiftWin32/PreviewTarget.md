---
layout: default
title: PreviewTarget
parent: SwiftWin32
---
# PreviewTarget

An object that specifies the container view to use for animations.

``` swift
public class PreviewTarget 
```

## Initializers

### `init(container:center:transform:)`

Creating a Preview Target Object
Creates a preview target object using the specified container view and
configuration details.

``` swift
public init(container: View, center: Point, transform: AffineTransform) 
```

### `init(container:center:)`

Creates a preview target object using the specified container view and
center point.

``` swift
public convenience init(container: View, center: Point) 
```

## Properties

### `container`

Getting the Target Attributes
The container for the view being animated.

``` swift
public let container: View
```

### `center`

The point in the containing view at which to place the center of the view
being animated.

``` swift
public let center: Point
```

### `transform`

An affine transform to apply to the view being animated.

``` swift
public let transform: AffineTransform
```
