---
layout: default
title: PreviewParameters
parent: SwiftWin32
---
# PreviewParameters

Additional parameters to use when animating a preview interface.

``` swift
public class PreviewParameters 
```

## Initializers

### `init()`

Creating Preview Parameters
Creates a default set of preview parameters.

``` swift
public init() 
```

### `init(textLineRects:)`

Creates a preview paramters object with information about the text you
want to preview.

``` swift
public init(textLineRects: [NSValue]) 
```

## Properties

### `backgroundColor`

Configuring the Preview Attributes
The background color to display behind the preview.

``` swift
public var backgroundColor: Color!
```

### `visiblePath`

The portion of the view to show in the preview.

``` swift
public var visiblePath: BezierPath?
```

### `shadowPath`

``` swift
public var shadowPath: BezierPath?
```
