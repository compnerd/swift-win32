---
layout: default
title: Offset
parent: SwiftWin32
---
# Offset

A structure that specifies an amount to offset a position.

``` swift
public struct Offset 
```

## Inheritance

`Equatable`

## Initializers

### `init()`

``` swift
public init() 
```

### `init(horizontal:vertical:)`

``` swift
public init(horizontal: Double, vertical: Double) 
```

## Properties

### `horizontal`

``` swift
public private(set) var horizontal: Double
```

### `vertical`

``` swift
public private(set) var vertical: Double
```

### `zero`

A `Offset` struct whose horizontal and vertical fields are set to the
value 0.

``` swift
public static var zero: Offset 
```

## Methods

### `string(for:)`

Returns a string formatted to contain the data from an offset structure.

``` swift
public static func string(for offset: Offset) -> String 
```

### `offset(for:)`

Returns an `Offset` structure corresponding to the data in a given string.

``` swift
public static func offset(for string: String) -> Offset 
```

In general, you should use this function only to convert strings that were

## Operators

### `==`

``` swift
public static func ==(_ lhs: Offset, _ rhs: Offset) -> Bool 
```
