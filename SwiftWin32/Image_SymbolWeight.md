---
layout: default
title: Image.SymbolWeight
parent: SwiftWin32
---
# Image.SymbolWeight

Constants that indicate which weight variant of a symbol image to use.

``` swift
public enum SymbolWeight: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `unspecified`

An unspecified symbol image weight.

``` swift
case unspecified
```

### `ultraLight`

An ultralight weight.

``` swift
case ultraLight
```

### `thin`

A thin weight

``` swift
case thin
```

### `light`

A light weight.

``` swift
case light
```

### `regular`

A regular weight.

``` swift
case regular
```

### `medium`

A medium weight.

``` swift
case medium
```

### `semibold`

A semibold weight.

``` swift
case semibold
```

### `bold`

A bold weight.

``` swift
case bold
```

### `heavy`

A heavy weight.

``` swift
case heavy
```

### `black`

An ultra-heavy weight.

``` swift
case black
```

## Methods

### `fontWeight()`

The font weight for the specified symbol weight.

``` swift
public func fontWeight() -> Font.Weight 
```
