---
layout: default
title: FocusItemContainer
parent: SwiftWin32
---
# FocusItemContainer

The container responsible for providing geometric context to focus items
within a given focus environment.

``` swift
public protocol FocusItemContainer 
```

## Requirements

### focusItems(in:​)

Retrieves all of the focus items within this container that intersect with
the provided rectangle.

``` swift
func focusItems(in rect: Rect) -> [FocusItem]
```

### coordinateSpace

The coordinate space of the focus items contained in the focus item
container.

``` swift
var coordinateSpace: CoordinateSpace 
```
