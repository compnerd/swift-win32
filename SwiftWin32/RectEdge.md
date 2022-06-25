---
layout: default
title: RectEdge
parent: SwiftWin32
---
# RectEdge

Constants that specify the edges of a rectangle.

``` swift
public struct RectEdge: OptionSet 
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

### `top`

The top edge of the rectangle.

``` swift
public static var top: RectEdge 
```

### `left`

The left edge of the rectangle.

``` swift
public static var left: RectEdge 
```

### `bottom`

The bottom edge of the rectangle.

``` swift
public static var bottom: RectEdge 
```

### `right`

The right edge of the rectangle.

``` swift
public static var right: RectEdge 
```

### `all`

All edges of the rectangle.

``` swift
public static var all: RectEdge 
```
