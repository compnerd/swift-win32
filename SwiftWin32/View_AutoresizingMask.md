---
layout: default
title: View.AutoresizingMask
parent: SwiftWin32
---
# View.AutoresizingMask

Options for automatic view resizing.

``` swift
public struct AutoresizingMask: OptionSet 
```

## Inheritance

`OptionSet`

## Initializers

### `init(rawValue:)`

``` swift
public init(rawValue: UInt) 
```

## Properties

### `rawValue`

``` swift
public let rawValue: UInt
```

### `none`

``` swift
public static var none: View.AutoresizingMask 
```

### `flexibleLeftMargin`

Resizing performed by expanding or shrinking a view in the direction of
the left margin.

``` swift
public static var flexibleLeftMargin: View.AutoresizingMask 
```

### `flexibleWidth`

Resizing performed by expanding or shrinking a view's width.

``` swift
public static var flexibleWidth: View.AutoresizingMask 
```

### `flexibleRightMargin`

Resizing performed by expanding or shrinking a view in the direction of
the right margin.

``` swift
public static var flexibleRightMargin: View.AutoresizingMask 
```

### `flexibleTopMargin`

Resizing performed by expanding or shrinking a view in the direction of
the top margin.

``` swift
public static var flexibleTopMargin: View.AutoresizingMask 
```

### `flexibleHeight`

Resizing performed by expanding or shrinking a view's height.

``` swift
public static var flexibleHeight: View.AutoresizingMask 
```

### `flexibleBottomMargin`

Resizing performed by expanding or shrinking a view in the direction of
the bottom margin.

``` swift
public static var flexibleBottomMargin: View.AutoresizingMask 
```
