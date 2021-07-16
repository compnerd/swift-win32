---
layout: default
title: Menu.Options
parent: SwiftWin32
---
# Menu.Options

Options for configuring a menu's appearance.

``` swift
public struct Options: OptionSet 
```

## Inheritance

`OptionSet`

## Nested Type Aliases

### `RawValue`

``` swift
public typealias RawValue = UInt
```

## Initializers

### `init(rawValue:)`

``` swift
public init(rawValue: RawValue) 
```

## Properties

### `rawValue`

``` swift
public let rawValue: RawValue
```

### `displayInline`

An option indicating the menu displays inline with its parent menu instead
of displaying as a submenu.

``` swift
public static var displayInline: Menu.Options 
```

### `destructive`

An Option indicating the menu's appearance represents a destructive
action.

``` swift
public static var destructive: Menu.Options 
```
