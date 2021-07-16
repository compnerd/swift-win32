---
layout: default
title: FocusEnvironment
parent: SwiftWin32
---
# FocusEnvironment

A set of methods that define the focus behavior for a branch of the view
hierarchy.

``` swift
public protocol FocusEnvironment: AnyObject 
```

## Inheritance

`AnyObject`

## Default Implementations

### `soundIdentifierForFocusUpdate(in:)`

``` swift
public func soundIdentifierForFocusUpdate(in context: FocusUpdateContext)
      -> FocusSoundIdentifier? 
```

### `focusGroupIdentifier`

``` swift
public var focusGroupIdentifier: String? 
```

## Requirements

### setNeedsFocusUpdate()

Submits a request to the focus engine for a focus update in this
environment.

``` swift
func setNeedsFocusUpdate()
```

### updateFocusIfNeeded()

Tells the focus engine to force a focus update immediately.

``` swift
func updateFocusIfNeeded()
```

### shouldUpdateFocus(in:​)

Returns a boolean value indicating whether the focus engine should allow
the focus update described by the specified context to occur.

``` swift
func shouldUpdateFocus(in context: FocusUpdateContext) -> Bool
```

### didUpdateFocus(in:​with:​)

Called immediately after the system updates the focus to a new view.

``` swift
func didUpdateFocus(in context: FocusUpdateContext,
                      with coordinator: FocusAnimationCoordinator)
```

### preferredFocusEnvironments

An array of focus environments, ordered by priority, to which this
environment prefers focus to be directed during a focus update.

``` swift
var preferredFocusEnvironments: [FocusEnvironment] 
```

### soundIdentifierForFocusUpdate(in:​)

Asks the delegate for the identifier of the sound to play when the object
gains focus.

``` swift
func soundIdentifierForFocusUpdate(in context: FocusUpdateContext)
      -> FocusSoundIdentifier?
```

### contains(\_:​)

Returns a boolean value indicating whether the focus environment contains
the specified environment.

``` swift
func contains(_ environment: FocusEnvironment) -> Bool
```

### parentFocusEnvironment

The parent focus environment for this environment.

``` swift
var parentFocusEnvironment: FocusEnvironment? 
```

### focusItemContainer

The container for the child focus items in this focus environment.

``` swift
var focusItemContainer: FocusItemContainer? 
```

### focusGroupIdentifier

``` swift
var focusGroupIdentifier: String? 
```
