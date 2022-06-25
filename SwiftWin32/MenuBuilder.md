---
layout: default
title: MenuBuilder
parent: SwiftWin32
---
# MenuBuilder

An interface for adding and removing menus from a menu system.

``` swift
public protocol MenuBuilder 
```

## Requirements

### system

The menu system that the menu builder modifies.

``` swift
var system: MenuSystem 
```

### menu(for:​)

Gets the menu for the specified menu identifier.

``` swift
func menu(for identifier: Menu.Identifier) -> Menu?
```

### action(for:​)

Gets the action for the specified action identifier.

``` swift
func action(for identifier: Action.Identifier) -> Action?
```

### command(for:​propertyList:​)

Gets the command for the specified selector and property list.

``` swift
func command(for action: @escaping (_: AnyObject?) -> Void,
               propertyList: Any?) -> Command?
```

### insertChild(\_:​atStartOfMenu:​)

Adds a child menu as the first element of the specified parent menu.

``` swift
func insertChild(_ childMenu: Menu,
                   atStartOfMenu parentIdentifier: Menu.Identifier)
```

### insertChild(\_:​atEndOfMenu:​)

Adds a child menu as the last element of the specified parent menu.

``` swift
func insertChild(_ childMenu: Menu,
                   atEndOfMenu parentIdentifier: Menu.Identifier)
```

### insertSibling(\_:​beforeMenu:​)

Inserts a sibling menu before the specified menu.

``` swift
func insertSibling(_ siblingMenu: Menu,
                     beforeMenu siblingIdentifier: Menu.Identifier)
```

### insertSibling(\_:​afterMenu:​)

Inserts a sibling menu after the specified menu.

``` swift
func insertSibling(_ siblingMenu: Menu,
                     afterMenu siblingIdentifier: Menu.Identifier)
```

### replace(menu:​with:​)

Replaces the specified menu with a new menu.

``` swift
func replace(menu replacedIdentifier: Menu.Identifier,
               with replacementMenu: Menu)
```

### replaceChildren(ofMenu:​from:​)

Replaces the elements in a menu with the elements returned by the
specified handler block.

``` swift
func replaceChildren(ofMenu parentIdentifier: Menu.Identifier,
                       from childrenBlock: ([MenuElement]) -> [MenuElement])
```

### remove(menu:​)

Removes a menu from the menu system.

``` swift
func remove(menu removedIdentifier: Menu.Identifier)
```
