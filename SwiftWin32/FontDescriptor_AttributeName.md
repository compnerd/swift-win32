---
layout: default
title: FontDescriptor.AttributeName
parent: SwiftWin32
---
# FontDescriptor.AttributeName

Constants that describe font attributes.

``` swift
public struct AttributeName: Equatable, Hashable, RawRepresentable 
```

## Inheritance

`Equatable`, `Hashable`, `RawRepresentable`

## Nested Type Aliases

### `RawValue`

``` swift
public typealias RawValue = String
```

## Initializers

### `init(rawValue:)`

``` swift
public init(rawValue: RawValue) 
```

## Properties

### `rawValue`

``` swift
public let rawValue: RawValue
```

### `cascadeList`

The cascading list attribute.

``` swift
public static var cascadeList: FontDescriptor.AttributeName 
```

### `characterSet`

The character set attribute.

``` swift
public static var characterSet: FontDescriptor.AttributeName 
```

### `face`

The font face attribute.

``` swift
public static var face: FontDescriptor.AttributeName 
```

### `family`

The font family attribute.

``` swift
public static var family: FontDescriptor.AttributeName 
```

### `featureSettings`

The font feature settings attribute.

``` swift
public static var featureSettings: FontDescriptor.AttributeName 
```

### `fixedAdvance`

The glyph advancement attribute.

``` swift
public static var fixedAdvance: FontDescriptor.AttributeName 
```

### `matrix`

The font's transformation matrix attribute.

``` swift
public static var matrix: FontDescriptor.AttributeName 
```

### `name`

The font name attribute.

``` swift
public static var name: FontDescriptor.AttributeName 
```

### `size`

The font size attribute.

``` swift
public static var size: FontDescriptor.AttributeName 
```

### `symbolic`

The font's stylistic properties attribute.

``` swift
public static var symbolic: FontDescriptor.AttributeName 
```

### `textStyle`

The text style attribute.

``` swift
public static var textStyle: FontDescriptor.AttributeName 
```

### `traits`

The font traits dictionary attribute.

``` swift
public static var traits: FontDescriptor.AttributeName 
```

### `visibleName`

The font's visible name attribute.

``` swift
public static var visibleName: FontDescriptor.AttributeName 
```
