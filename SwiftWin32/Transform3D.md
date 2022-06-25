---
layout: default
title: Transform3D
parent: SwiftWin32
---
# Transform3D

The standard transform matrix.

``` swift
public struct Transform3D 
```

## Initializers

### `init()`

``` swift
public init() 
```

### `init(m11:m12:m13:m14:m21:m22:m23:m24:m31:m32:m33:m34:m41:m42:m43:m44:)`

``` swift
public init(m11: Double, m12: Double, m13: Double, m14: Double,
              m21: Double, m22: Double, m23: Double, m24: Double,
              m31: Double, m32: Double, m33: Double, m34: Double,
              m41: Double, m42: Double, m43: Double, m44: Double) 
```

## Properties

### `identity`

The identity transform.
\[1, 0, 0, 0\]
\[0, 1, 0, 0\]
\[0, 0, 1, 0\]
\[0, 0, 0, 1\]

``` swift
public static var identity: Transform3D 
```
