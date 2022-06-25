---
layout: default
title: TableViewFocusUpdateContext
parent: SwiftWin32
---
# TableViewFocusUpdateContext

A context object that provides information relevant to a specific focus
update from one view to another.

``` swift
public class TableViewFocusUpdateContext: FocusUpdateContext 
```

## Inheritance

[`FocusUpdateContext`](https://compnerd.github.io/swift-win32/SwiftWin32/FocusUpdateContext)

## Properties

### `previouslyFocusedIndexPath`

Returns the index path of the cell containing the context's previously
focused view.

``` swift
public internal(set) var previouslyFocusedIndexPath: IndexPath?
```

### `nextFocusedIndexPath`

Returns the index path of the cell containing the context's next focused
view.

``` swift
public internal(set) var nextFocusedIndexPath: IndexPath?
```
