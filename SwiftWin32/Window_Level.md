---
layout: default
title: Window.Level
parent: SwiftWin32
---
# Window.Level

The positioning of windows relative to each other.

``` swift
public struct Level: Equatable, Hashable, RawRepresentable 
```

## Inheritance

`Equatable`, `Hashable`, `RawRepresentable`

## Nested Type Aliases

### `RawValue`

``` swift
public typealias RawValue = Double
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

### `normal`

The default level.

``` swift
public static var normal: Window.Level 
```

### `statusBar`

The level for a status window.

``` swift
public static var statusBar: Window.Level 
```

### `alert`

The level for an alert view.

``` swift
public static var alert: Window.Level 
```
