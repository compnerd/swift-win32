---
layout: default
title: Action
parent: SwiftWin32
---
# Action

A menu element that performs its action in a closure.

``` swift
open class Action: MenuElement 
```

## Inheritance

[`MenuElement`](https://compnerd.github.io/swift-win32/SwiftWin32/MenuElement)

## Nested Type Aliases

### `ActionHandler`

A type that defines the closure for an action handler.

``` swift
public typealias ActionHandler = (Action) -> Void
```

## Initializers

### `init(title:image:identifier:discoverabilityTitle:attributes:state:handler:)`

Creates an action.

``` swift
public /*convenience*/ init(title: String = "", image: Image? = nil,
                              identifier: Action.Identifier? = nil,
                              discoverabilityTitle: String? = nil,
                              attributes: MenuElement.Attributes = [],
                              state: MenuElement.State = .off,
                              handler: @escaping ActionHandler) 
```

## Properties

### `title`

The action's title.

``` swift
open override var title: String 
```

### `image`

The action's image.

``` swift
open override var image: Image? 
```

### `identifier`

The unique identifier for the action.

``` swift
open private(set) var identifier: Action.Identifier
```

### `discoverabilityTitle`

An elaborated title that explains the purpose of the action.

``` swift
open var discoverabilityTitle: String?
```

### `attributes`

The attributes indicating the style of the action.

``` swift
open var attributes: MenuElement.Attributes
```

### `state`

The state of the action.

``` swift
open var state: MenuElement.State
```

### `sender`

The object responsible for the action handler.

``` swift
open internal(set) var sender: Any?
```
