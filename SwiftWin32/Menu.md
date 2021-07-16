---
layout: default
title: Menu
parent: SwiftWin32
---
# Menu

A container for grouping related menu elements in an application menu or
contextual menu.

``` swift
open class Menu: MenuElement 
```

## Inheritance

[`MenuElement`](https://compnerd.github.io/swift-win32/SwiftWin32/MenuElement), `Equatable`, `Hashable`

## Initializers

### `init(title:image:identifier:options:children:)`

Creates a new menu with the specified values.

``` swift
public /*convenience*/ init(title: String = "", image: Image? = nil,
                              identifier: Menu.Identifier? = nil,
                              options: Menu.Options = [],
                              children: [MenuElement] = []) 
```

## Properties

### `children`

The contents of the menu.

``` swift
public internal(set) var children: [MenuElement]
```

### `identifier`

The unique identifier for the current menu.

``` swift
open private(set) var identifier: Menu.Identifier
```

### `options`

The configuration options for the current menu.

``` swift
open private(set) var options: Menu.Options
```

## Methods

### `replacingChildren(_:)`

Creates a new menu with the same configuration as the current menu, but
with a new set of child elements.

``` swift
open func replacingChildren(_ newChildren: [MenuElement]) -> Menu 
```

### `hash(into:)`

``` swift
public func hash(into hasher: inout Hasher) 
```

## Operators

### `==`

``` swift
public static func ==(_ lhs: Menu, _ rhs: Menu) -> Bool 
```
