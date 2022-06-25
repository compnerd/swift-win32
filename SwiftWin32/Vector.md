---
layout: default
title: Vector
parent: SwiftWin32
---
# Vector

A structure that contains a two-dimensional vector.

``` swift
public struct Vector 
```

## Inheritance

`CustomDebugStringConvertible`

## Initializers

### `init()`

Creates a vector whose components are both zero.

``` swift
public init() 
```

### `init(dx:dy:)`

Creates a vector with components specified as floating-point values.

``` swift
public init(dx: Double, dy: Double) 
```

### `init(dx:dy:)`

Creates a vector with components specified as floating-point values.

``` swift
public init(dx: Float, dy: Float) 
```

### `init(dx:dy:)`

Creates a vector with components specified as integer values.

``` swift
public init(dx: Int, dy: Int) 
```

## Properties

### `zero`

The vector whose components are both zero.

``` swift
public static var zero: Vector 
```

### `dx`

The x component of the vector.

``` swift
public var dx: Double
```

### `dy`

The y component of the vector.

``` swift
public var dy: Double
```

### `debugDescription`

``` swift
public var debugDescription: String 
```
