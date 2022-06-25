---
layout: default
title: TransitionContextViewControllerKey
parent: SwiftWin32
---
# TransitionContextViewControllerKey

The keys you use to identify the view controllers involved in a transition.

``` swift
public struct TransitionContextViewControllerKey: Equatable, Hashable, RawRepresentable 
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

A key that identifies the view controller that is visible at the beginning
of the transition, or at the end of a canceled transition.

``` swift
public static var from: TransitionContextViewControllerKey 
```

### `to`

A key that identifies the view controller that is visible at the end of a
completed transition.

``` swift
public static var to: TransitionContextViewControllerKey 
```
