---
layout: default
title: FocusHeading
parent: SwiftWin32
---
# FocusHeading

The general type of an event.

``` swift
public struct FocusHeading: OptionSet 
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

### `up`

The focus update is heading in the up direction.

``` swift
public static var up: FocusHeading 
```

### `down`

The focus update is heading in the down direction.

``` swift
public static var down: FocusHeading 
```

### `left`

The focus update is heading in the left direction.

``` swift
public static var left: FocusHeading 
```

### `right`

The focus update is heading in the right direction.

``` swift
public static var right: FocusHeading 
```

### `next`

The focus update is heading to the next item.

``` swift
public static var next: FocusHeading 
```

### `previous`

The focus update is heading to the previous item.

``` swift
public static var previous: FocusHeading 
```
