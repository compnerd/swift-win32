---
layout: default
title: Event.ButtonMask
parent: SwiftWin32
---
# Event.ButtonMask

Set of buttons pressed for the current event

``` swift
public struct ButtonMask: OptionSet 
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
public init(rawValue: Int) 
```

## Properties

### `rawValue`

``` swift
public let rawValue: RawValue
```

### `primary`

``` swift
public static var primary: ButtonMask 
```

### `secondary`

``` swift
public static var secondary: ButtonMask 
```

## Methods

### `button(_:)`

Convenience initializer for a button mask where `buttonNumber` is a
one-based index of the button on the input device

``` swift
public static func button(_ buttonNumber: Int) -> ButtonMask 
```
