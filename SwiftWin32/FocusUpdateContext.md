---
layout: default
title: FocusUpdateContext
parent: SwiftWin32
---
# FocusUpdateContext

An object that provides information relevant to a specific focus update from
one view to another.

``` swift
public class FocusUpdateContext 
```

## Properties

### `previouslyFocusedView`

The view that was focused before the focus update.

``` swift
public private(set) weak var previouslyFocusedView: View?
```

### `nextFocusedView`

The view that takes the focus after the focus update.

``` swift
public private(set) weak var nextFocusedView: View?
```

### `focusHeading`

The heading in which the focus update is occurring.

``` swift
public private(set) var focusHeading: FocusHeading = .none
```

### `previouslyFocusedItem`

The item that was focused before the update.

``` swift
public private(set) weak var previouslyFocusedItem: FocusItem?
```

### `nextFocusedItem`

The item to be focused after the update.

``` swift
public private(set) weak var nextFocusedItem: FocusItem?
```

### `didUpdateNotification`

The focus for the UI has been updated.

``` swift
public static var didUpdateNotification: NSNotification.Name 
```

### `movementDidFailNotification`

The focus failed to move to another item.

``` swift
public static var movementDidFailNotification: NSNotification.Name 
```

### `animationCoordinatorUserInfoKey`

Updates the animation coordinator.

``` swift
public static var animationCoordinatorUserInfoKey: String 
```

### `focusUpdateContextUserInfoKey`

Updates the context key.

``` swift
public static var focusUpdateContextUserInfoKey: String 
```
