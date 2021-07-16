---
layout: default
title: MenuSystem
parent: SwiftWin32
---
# MenuSystem

An object representing a main or contextual menu system.

``` swift
open class MenuSystem 
```

## Properties

### `main`

The main menu system.

``` swift
open class var main: MenuSystem 
```

### `context`

The context menu system.

``` swift
open class var context: MenuSystem 
```

## Methods

### `setNeedsRebuild()`

Tells the menu system to rebuild all of its menus.

``` swift
open func setNeedsRebuild() 
```

### `setNeedsRevalidate()`

Tells the menu system to validate all of its menus.

``` swift
open func setNeedsRevalidate() 
```
