---
layout: default
title: TargetedPreview
parent: SwiftWin32
---
# TargetedPreview

``` swift
public class TargetedPreview 
```

## Initializers

### `init(view:parameters:target:)`

Creting a Targeted Preview Object
Creates a targeted preview with the specified view, parameters, and target
container.

``` swift
public init(view: View, parameters: PreviewParameters, target: PreviewTarget) 
```

### `init(view:parameters:)`

Creates a targeted preview for a view in the current window and including
the specified parameters.

``` swift
public convenience init(view: View, parameters: PreviewParameters) 
```

### `init(view:)`

Creates a targeted preview for a view in the current window.

``` swift
public convenience init(view: View) 
```

## Properties

### `view`

Getting the Preview Attributes
The view that is the target of the animation

``` swift
public let view: View
```

### `target`

The view that is the container for the target view.

``` swift
public let target: PreviewTarget
```

### `size`

The size of the view.

``` swift
public let size: Size
```

### `parameters`

Additional parameters to use when configuring the animations.

``` swift
public let parameters: PreviewParameters
```

## Methods

### `retargetedPreview(with:)`

Changing the Target's Container
Returns a targeted preview object with the same view and parameters, but
with a different target container.

``` swift
public func retargetedPreview(with newTarget: PreviewTarget)
      -> TargetedPreview 
```
