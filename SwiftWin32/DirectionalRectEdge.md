---
layout: default
title: DirectionalRectEdge
parent: SwiftWin32
---
# DirectionalRectEdge

Constants that specify an edge or a set of edges, taking the user interface
layout direction into account.

``` swift
public struct DirectionalRectEdge: OptionSet 
```

## Inheritance

`OptionSet`

## Initializers

### `init(rawValue:)`

``` swift
public init(rawValue: UInt) 
```

## Properties

### `rawValue`

``` swift
public let rawValue: UInt
```

### `none`

No specified edge.

``` swift
public static var none: DirectionalRectEdge 
```

### `top`

The top edge.

``` swift
public static var top: DirectionalRectEdge 
```

### `leading`

The leading edge.

``` swift
public static var leading: DirectionalRectEdge 
```

### `bottom`

The bottom edge.

``` swift
public static var bottom: DirectionalRectEdge 
```

### `trailing`

The trailing edge.

``` swift
public static var trailing: DirectionalRectEdge 
```

### `all`

All edges.

``` swift
public static var all: DirectionalRectEdge 
```
