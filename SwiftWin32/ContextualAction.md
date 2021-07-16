---
layout: default
title: ContextualAction
parent: SwiftWin32
---
# ContextualAction

An action to display when the user swipes a table row.

``` swift
public class ContextualAction 
```

## Nested Type Aliases

### `Handler`

The handler block to call in response to the selection of an action.

``` swift
public typealias Handler =
      (ContextualAction, View, @escaping (Bool) -> Void) -> Void
```

## Initializers

### `init(style:title:handler:)`

Creates a new contextual action with the specified title and handler.

``` swift
public /*convenience*/ init(style: ContextualAction.Style, title: String?,
                              handler: @escaping ContextualAction.Handler) 
```

## Properties

### `title`

The title displayed on the action button.

``` swift
public var title: String?
```

### `backgroundColor`

The background color of the action button.

``` swift
public let backgroundColor: Color!
```

### `image`

The image to display in the action button.

``` swift
public var image: Image?
```

### `handler`

The handler block to execute when the user selects the action.

``` swift
public let handler: ContextualAction.Handler
```

### `style`

The style that is applied to the action button.

``` swift
public let style: ContextualAction.Style
```
