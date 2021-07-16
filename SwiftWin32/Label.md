---
layout: default
title: Label
parent: SwiftWin32
---
# Label

``` swift
public class Label: Control 
```

## Inheritance

[`Control`](https://compnerd.github.io/swift-win32/SwiftWin32/Control)

## Initializers

### `init(frame:)`

``` swift
public init(frame: Rect) 
```

## Properties

### `text`

``` swift
public var text: String? 
```

### `font`

``` swift
public override var font: Font! 
```

### `frame`

``` swift
public override var frame: Rect 
```

### `adjustsFontForContentSizeCategory`

``` swift
public var adjustsFontForContentSizeCategory = false
```

## Methods

### `sizeThatFits(_:)`

``` swift
override public func sizeThatFits(_ size: Size) -> Size 
```

### `traitCollectionDidChange(_:)`

``` swift
override public func traitCollectionDidChange(_ previousTraitCollection: TraitCollection?) 
```
