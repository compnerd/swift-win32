---
layout: default
title: FocusMovementHint
parent: SwiftWin32
---
# FocusMovementHint

Provides movement hint information for the focused item.

``` swift
public class FocusMovementHint 
```

## Properties

### `movementDirection`

A vector representing how close focus is to moving to another item in the
swiped direction.

``` swift
public private(set) var movementDirection: Vector
```

### `interactionTransform`

A 3D transform that contains the combined transformations of perspective,
rotation, and translation.

``` swift
public private(set) var interactionTransform: Transform3D
```

### `perspectiveTransform`

A 3D transform that represents a perspective matrix to be applied to match
the system interaction hinting.

``` swift
public private(set) var perspectiveTransform: Transform3D
```

### `rotation`

A vector to apply to a transform to match system interaction hinting.

``` swift
public private(set) var rotation: Vector
```

### `translation`

A vector to apply to a transform to match system interaction hinting.

``` swift
public private(set) var translation: Vector
```
