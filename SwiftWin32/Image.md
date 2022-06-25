---
layout: default
title: Image
parent: SwiftWin32
---
# Image

An object that manages image data in your app.

``` swift
public class Image 
```

## Initializers

### `init?(contentsOfFile:)`

Initializes and returns the image object with the contents of the
specified file.

``` swift
public init?(contentsOfFile path: String) 
```

## Properties

### `scale`

The scale factor of the image.

``` swift
public var scale: Float 
```

### `size`

The logical dimensions, in points, for the image.

``` swift
public var size: Size 
```
