---
layout: default
title: TransitionContextViewKey
parent: SwiftWin32
---
# TransitionContextViewKey

The keys you use to identify the views involved in a transition.

``` swift
public struct TransitionContextViewKey: Equatable, Hashable, RawRepresentable 
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

## Properties

### `rawValue`

``` swift
public let rawValue: RawValue
```

### `from`

A key that identifies the view shown at the beginning of the transition,
or at the end of a canceled transition.

``` swift
public static var from: TransitionContextViewKey 
```

### `to`

A key that identifies the view shown at the end of a completed transition.

``` swift
public static var to: TransitionContextViewKey 
```
