---
layout: default
title: FontDescriptor.FeatureKey
parent: SwiftWin32
---
# FontDescriptor.FeatureKey

Keys for retrieving feature settings.

``` swift
public struct FeatureKey: Equatable, Hashable, RawRepresentable 
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

### `init(_:)`

``` swift
public init(_ rawValue: RawValue) 
```

## Properties

### `rawValue`

``` swift
public let rawValue: RawValue
```

### `featureIdentifier`

A key for identifying a font feature type such as ligature or character
shape.

``` swift
public static var featureIdentifier: FontDescriptor.FeatureKey 
```

### `typeIdentifier`

A key for identifying the font feature selector.

``` swift
public static var typeIdentifier: FontDescriptor.FeatureKey 
```
