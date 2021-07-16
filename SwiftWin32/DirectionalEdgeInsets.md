---
layout: default
title: DirectionalEdgeInsets
parent: SwiftWin32
---
# DirectionalEdgeInsets

Edge insets that take language direction into account.

``` swift
public struct DirectionalEdgeInsets 
```

## Initializers

### `init()`

Initializes the edge inset struct to default values.

``` swift
public init() 
```

## Properties

### `bottom`

The bottom edge inset value.

``` swift
public var bottom: Double
```

### `leading`

The leading edge inset value.

``` swift
public var leading: Double
```

### `top`

The top edge inset value.

``` swift
public var top: Double
```

### `trailing`

The trailing edge inset value.

``` swift
public var trailing: Double
```

### `zero`

A directional edge insets struct whose top, leading, bottom, and trailing
fields are all set to 0.

``` swift
public static var zero: DirectionalEdgeInsets 
```

## Methods

### `string(for:)`

Returns a string formatted to contain the data from a directional edge
insets structure.

``` swift
public static func string(for insets: DirectionalEdgeInsets) -> String 
```

### `directionalEdgeInsets(for:)`

Returns a directional edge insets structure based on the data in the
specified string.

``` swift
public static func directionalEdgeInsets(for: String)
      -> DirectionalEdgeInsets 
```
