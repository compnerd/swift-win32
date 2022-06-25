---
layout: default
title: SceneSession.Role
parent: SwiftWin32
---
# SceneSession.Role

Constants that indicate the possible roles for a scene.

``` swift
public struct Role: Equatable, Hashable, RawRepresentable 
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

### `windowApplication`

The scene displays noninteractive windows on an externally connected
screen.

``` swift
public static var windowApplication: SceneSession.Role 
```

### `windowExternalDisplay`

The scene displays interactive content on the device's main screen.

``` swift
public static var windowExternalDisplay: SceneSession.Role 
```
