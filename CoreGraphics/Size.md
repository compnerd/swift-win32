---
layout: default
title: Size
parent: CoreGraphics
---
# Size

A structure that contains width and height values.

``` swift
public struct Size 
```

## Inheritance

`CustomDebugStringConvertible`

## Initializers

### `init()`

Creates a size with zero width and height.

``` swift
public init() 
```

### `init(width:height:)`

Creates a size with dimensions specified as floating-point values.

``` swift
public init(width: Double, height: Double) 
```

### `init(width:height:)`

``` swift
public init(width: Int, height: Int) 
```

## Properties

### `width`

A width value.

``` swift
public var width: Double
```

### `height`

A height value.

``` swift
public var height: Double
```

### `zero`

The size whose width and height are both zero.

``` swift
public static var zero: Size 
```

### `debugDescription`

``` swift
public var debugDescription: String 
```
