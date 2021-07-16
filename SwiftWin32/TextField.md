---
layout: default
title: TextField
parent: SwiftWin32
---
# TextField

``` swift
public class TextField: Control 
```

## Inheritance

[`Control`](https://compnerd.github.io/swift-win32/SwiftWin32/Control), [`TextInputTraits`](https://compnerd.github.io/swift-win32/SwiftWin32/TextInputTraits)

## Initializers

### `init(frame:)`

``` swift
public init(frame: Rect) 
```

## Properties

### `delegate`

``` swift
public weak var delegate: TextFieldDelegate?
```

### `text`

Accessing the Text Attributes

``` swift
@_Win32WindowText
  public var text: String?
```

### `placeholder`

``` swift
public var placeholder: String?
```

### `font`

``` swift
public override var font: Font? 
```

### `textAlignment`

``` swift
public var textAlignment: TextAlignment 
```

### `adjustsFontForContentSizeCategory`

``` swift
public var adjustsFontForContentSizeCategory = false
```

### `isSecureTextEntry`

``` swift
public var isSecureTextEntry: Bool 
```

## Methods

### `traitCollectionDidChange(_:)`

``` swift
override public func traitCollectionDidChange(_ previousTraitCollection: TraitCollection?) 
```
