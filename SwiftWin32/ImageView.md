---
layout: default
title: ImageView
parent: SwiftWin32
---
# ImageView

An object that displays a single image or a sequence of animated images in
your interface.

``` swift
public class ImageView: View 
```

## Inheritance

[`View`](https://compnerd.github.io/swift-win32/SwiftWin32/View)

## Initializers

### `init(image:)`

Returns an image view initialized with the specified image.

``` swift
public init(image: Image?) 
```

### `init(image:highlightedImage:)`

Returns an image view initialized with the specified regular and
highlighted images.

``` swift
public init(image: Image?, highlightedImage: Image?) 
```

## Properties

### `image`

The image displayed in the image view.

``` swift
public var image: Image?
```

### `highlightedImage`

The highlighted image displayed in the image view.

``` swift
public var highlightedImage: Image?
```

### `adjustsImageSizeForAccessibilityContentSizeCategory`

``` swift
public var adjustsImageSizeForAccessibilityContentSizeCategory = false
```
