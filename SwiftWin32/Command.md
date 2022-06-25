---
layout: default
title: Command
parent: SwiftWin32
---
# Command

A menu element that performs its action in a selector.

``` swift
public class Command: MenuElement 
```

## Inheritance

[`MenuElement`](https://compnerd.github.io/swift-win32/SwiftWin32/MenuElement)

## Initializers

### `init(title:image:action:propertyList:alternates:discoverabilityTitle:attributes:state:)`

Creates a command.

``` swift
public /*convenience*/ init(title: String = "", image: Image? = nil,
                              action: @escaping (_: AnyObject?) -> Void,
                              propertyList: Any? = nil,
                              alternates: [CommandAlternate] = [],
                              discoverabilityTitle: String? = nil,
                              attributes: MenuElement.Attributes = [],
                              state: MenuElement.State = .off) 
```

## Properties

### `title`

The command's title.

``` swift
public override var title: String 
```

### `image`

The command's image.

``` swift
public override var image: Image? 
```

### `action`

The selector identifying the action method called after the user selects
the command.

``` swift
public var action: (_: AnyObject?) -> Void
```

### `discoverabilityTitle`

An elaborated title that explains the purpose of the command.

``` swift
public var discoverabilityTitle: String?
```

### `attributes`

The attributes indicating the style of the command.

``` swift
public var attributes: MenuElement.Attributes
```

### `state`

The state of the command.

``` swift
public var state: MenuElement.State
```

### `alternates`

An array of alternative actions to take for the command.

``` swift
public private(set) var alternates: [CommandAlternate]
```
