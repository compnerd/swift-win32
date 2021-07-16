---
layout: default
title: AlertAction
parent: SwiftWin32
---
# AlertAction

An action that can be taken when the user taps a button in an alert.

``` swift
public class AlertAction 
```

## Initializers

### `init(title:style:handler:)`

Create and return an action with the specified title and behavior.

``` swift
public init(title: String?, style: AlertAction.Style,
              handler: ((AlertAction) -> Void)? = nil) 
```

## Properties

### `title`

The title of the action’s button.

``` swift
public let title: String?
```

### `style`

The style that is applied to the action’s button.

``` swift
public let style: AlertAction.Style
```

### `isEnabled`

A Boolean value indicating whether the action is currently enabled.

``` swift
public var isEnabled: Bool
```
