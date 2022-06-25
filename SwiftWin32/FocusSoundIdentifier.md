---
layout: default
title: FocusSoundIdentifier
parent: SwiftWin32
---
# FocusSoundIdentifier

An identifier for a focus-related sound.

``` swift
public struct FocusSoundIdentifier: Equatable, Hashable, RawRepresentable 
```

## Inheritance

`Equatable`, `Hashable`, `RawRepresentable`

## Nested Type Aliases

### `RawValue`

``` swift
public typealias RawValue = String
```

## Initializers

### `init(rawValue:)`

``` swift
public init(rawValue: RawValue) 
```

### `init(_:)`

``` swift
public init(_ rawValue: String) 
```

## Properties

### `rawValue`

``` swift
public let rawValue: RawValue
```

### `` `default` ``

The identifier for the default system sound to play during focus updates.

``` swift
public static var `default`: FocusSoundIdentifier 
```

### `none`

The identifier for disabling sound during a focus update.

``` swift
public static var none: FocusSoundIdentifier 
```
