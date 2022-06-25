---
layout: default
title: MenuElement.Attributes
parent: SwiftWin32
---
# MenuElement.Attributes

Attributes that determine the style of the menu element.

``` swift
public struct Attributes: OptionSet 
```

## Inheritance

`OptionSet`

## Nested Type Aliases

### `RawValue`

``` swift
public typealias RawValue = Int
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

### `destructive`

An attribute indicating the destructive style.

``` swift
public static var destructive: MenuElement.Attributes 
```

### `disabled`

An attribute indicating the disabled style.

``` swift
public static var disabled: MenuElement.Attributes 
```

### `hidden`

An attribute indicating the hidden style.

``` swift
public static var hidden: MenuElement.Attributes 
```
