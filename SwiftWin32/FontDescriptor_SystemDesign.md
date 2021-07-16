---
layout: default
title: FontDescriptor.SystemDesign
parent: SwiftWin32
---
# FontDescriptor.SystemDesign

Constants that describe the system-defined typeface designs.

``` swift
public struct SystemDesign: Hashable, Equatable, RawRepresentable 
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

### `` `default` ``

The default typeface for an app's user interface.

``` swift
public static var `default`: FontDescriptor.SystemDesign 
```

### `monospaced`

The monospace variant of the default typeface.

``` swift
public static var monospaced: FontDescriptor.SystemDesign 
```

### `rounded`

The rounded variant of the default typeface.

``` swift
public static var rounded: FontDescriptor.SystemDesign 
```

### `serif`

The serif variant of the default typeface.

``` swift
public static var serif: FontDescriptor.SystemDesign 
```
