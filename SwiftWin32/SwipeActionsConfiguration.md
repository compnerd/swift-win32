---
layout: default
title: SwipeActionsConfiguration
parent: SwiftWin32
---
# SwipeActionsConfiguration

The set of actions to perform when swiping on rows of a table.

``` swift
public class SwipeActionsConfiguration 
```

## Initializers

### `init(actions:)`

Creates a swipe action configuration object with the specified set of
actions.

``` swift
public init(actions: [ContextualAction]) 
```

## Properties

### `actions`

The swipe actions.

``` swift
public private(set) var actions: [ContextualAction]
```

### `performsFirstActionWithFullSwipe`

A boolean value indicating whether a full swipe automatically performs the
first action.

``` swift
public var performsFirstActionWithFullSwipe: Bool = true
```
