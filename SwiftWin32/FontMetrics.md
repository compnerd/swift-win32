---
layout: default
title: FontMetrics
parent: SwiftWin32
---
# FontMetrics

``` swift
public class FontMetrics 
```

## Initializers

### `init(forTextStyle:)`

Creating a Font Metrics Object
Creates a font metrics object for the specified text style.

``` swift
public init (forTextStyle style: Font.TextStyle) 
```

## Properties

### `` `default` ``

The default font metrics object for content.

``` swift
public static let `default`: FontMetrics 
```

## Methods

### `scaledFont(for:)`

Creating Scaled Fonts
Returns a version of the specified font that adopts the current font
metrics.

``` swift
public func scaledFont(for font: Font) -> Font 
```

### `scaledFont(for:compatibleWith:)`

Returns a version of the specified font that adopts the current font
metrics and suports the specified traitss.

``` swift
public func scaledFont(for font: Font,
                         compatibleWith traitCollection: TraitCollection?)
      -> Font 
```

### `scaledFont(for:maximumPointSize:)`

Returns a version of the specified font that adopts the current font
metrics and is constrained to the specified maximum size.

``` swift
public func scaledFont(for font: Font, maximumPointSize: Double) -> Font 
```

### `scaledFont(for:maximumPointSize:compatibleWith:)`

Returns a version of the specified font that adopts the current font
metrics and is constrained to the specified traits and size.

``` swift
public func scaledFont(for font: Font, maximumPointSize: Double,
                         compatibleWith traitCollection: TraitCollection?)
      -> Font 
```
