---
layout: default
title: AffineTransform
parent: CoreGraphics
---
# AffineTransform

An affine transformation matrix for use in drawing 2D graphics.

``` swift
public struct AffineTransform 
```

## Initializers

### `init()`

``` swift
public init() 
```

### `init(a:b:c:d:tx:ty:)`

``` swift
public init( a: Double,  b: Double,
               c: Double,  d: Double,
              tx: Double, ty: Double) 
```

### `init(rotationAngle:)`

Returns an affine transformation matrix constructed from a rotation value
you provide.

``` swift
public init(rotationAngle radians: Double) 
```

### `init(scaleX:y:)`

Returns an affine transformation matrix constructed from scaling values
you provide.

``` swift
public init(scaleX sx: Double, y sy: Double) 
```

### `init(translationX:y:)`

Returns an affine transformation matrix constructed from translation
values you provide.

``` swift
public init(translationX tx: Double, y ty: Double) 
```

## Properties

### `identity`

The identity transform.

``` swift
public static var identity: AffineTransform 
```

### `a`

The entry at position \[1,1\] in the matrix.

``` swift
public var a: Double
```

### `b`

The entry at position \[1,2\] in the matrix.

``` swift
public var b: Double
```

### `c`

The entry at position \[2,1\] in the matrix.

``` swift
public var c: Double
```

### `d`

The entry at position \[2,2\] in the matrix.

``` swift
public var d: Double
```

### `tx`

The entry at position \[3,1\] in the matrix.

``` swift
public var tx: Double
```

### `ty`

The entry at position \[3,2\] in the matrix.

``` swift
public var ty: Double
```

### `isIdentity`

Checks whether an affine transform is the identity transform.

``` swift
public var isIdentity: Bool 
```

## Methods

### `concatenating(_:)`

Returns an affine transformation matrix constructed by combining two
existing affine transforms.

``` swift
public func concatenating(_ transform: AffineTransform) -> AffineTransform 
```

### `inverted()`

Returns an affine transformation matrix constructed by inverting an
existing affine transform.

``` swift
public func inverted() -> AffineTransform 
```
