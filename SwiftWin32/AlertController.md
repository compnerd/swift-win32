---
layout: default
title: AlertController
parent: SwiftWin32
---
# AlertController

An object that displays an alert message to the user.

``` swift
public class AlertController: ViewController 
```

## Inheritance

[`ViewController`](https://compnerd.github.io/swift-win32/SwiftWin32/ViewController)

## Initializers

### `init(title:message:preferredStyle:)`

Creates and returns a view controller for displaying an alert to the user.

``` swift
public init(title: String?, message: String?,
              preferredStyle: AlertController.Style) 
```

## Properties

### `message`

Descriptive text that provides more details about the reason for the
alert.

``` swift
public var message: String?
```

### `preferredStyle`

The style of the alert controller.

``` swift
public let preferredStyle: AlertController.Style
```

### `actions`

The actions that the user can take in response to the alert or action
sheet.

``` swift
public private(set) var actions: [AlertAction] = []
```

### `preferredAction`

The preferred action for the user to take from an alert.

``` swift
public var preferredAction: AlertAction?
```

### `textFields`

The array of text fields displayed by the alert.

``` swift
public private(set) var textFields: [TextField]?
```

## Methods

### `addAction(_:)`

Attaches an action object to the alert or action sheet.

``` swift
public func addAction(_ action: AlertAction) 
```

### `addTextField(configurationHandler:)`

Adds a text field to an alert.

``` swift
public func addTextField(configurationHandler: ((TextField) -> Void)? = nil) 
```
