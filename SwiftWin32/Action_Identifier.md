---
layout: default
title: Action.Identifier
parent: SwiftWin32
---
# Action.Identifier

A type that represents an action identifier.

``` swift
public struct Identifier: Equatable, Hashable, RawRepresentable 
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
