---
layout: default
title: FontDescriptor.TraitKey
parent: SwiftWin32
---
# FontDescriptor.TraitKey

``` swift
public struct TraitKey: Equatable, Hashable, RawRepresentable 
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

### `slant`

The relative slant angle of the font.

``` swift
public static var slant: FontDescriptor.TraitKey 
```

### `symbolic`

The symbolic font traits.

``` swift
public static var symbolic: FontDescriptor.TraitKey 
```

### `weight`

The normalized font weight.

``` swift
public static var weight: FontDescriptor.TraitKey 
```

### `width`

The inter-glyph spacing of the font.

``` swift
public static var width: FontDescriptor.TraitKey 
```
