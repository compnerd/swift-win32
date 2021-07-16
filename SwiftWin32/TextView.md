---
layout: default
title: TextView
parent: SwiftWin32
---
# TextView

``` swift
public class TextView: View 
```

## Inheritance

[`View`](https://compnerd.github.io/swift-win32/SwiftWin32/View)

## Initializers

### `init(frame:)`

``` swift
public init(frame: Rect) 
```

## Properties

### `editable`

``` swift
public var editable: Bool 
```

### `font`

``` swift
public override var font: Font? 
```

### `text`

``` swift
@_Win32WindowText
  public var text: String?
```

### `adjustsFontForContentSizeCategory`

``` swift
public var adjustsFontForContentSizeCategory = false
```

## Methods

### `scrollRangeToVisible(_:)`

``` swift
public func scrollRangeToVisible(_ range: NSRange) 
```

### `traitCollectionDidChange(_:)`

``` swift
override public func traitCollectionDidChange(_ previousTraitCollection: TraitCollection?) 
```
