---
layout: default
title: Screen
parent: SwiftWin32
---
# Screen

``` swift
public final class Screen 
```

## Inheritance

`CustomDebugStringConvertible`, [`TraitEnvironment`](https://compnerd.github.io/swift-win32/SwiftWin32/TraitEnvironment)

## Properties

### `main`

Returns the screen object representing the device's screen.

``` swift
public static var main: Screen 
```

### `screens`

Returns an array containing all the screens attached to the device.

``` swift
public static var screens: [Screen] 
```

### `mirrored`

The screen being mirrored by an external display.

``` swift
public var mirrored: Screen?
```

### `bounds`

The bounding rectangle of the screen, measured in points.

``` swift
public let bounds: Rect
```

### `nativeBounds`

The bounding rectangle of the physical screen, measured in pixels.

``` swift
public let nativeBounds: Rect
```

### `nativeScale`

The native scale factor for the physical screen.

``` swift
public let nativeScale: Double
```

### `traitCollection`

``` swift
public private(set) var traitCollection: TraitCollection
```

### `debugDescription`

``` swift
public var debugDescription: String 
```

## Methods

### `traitCollectionDidChange(_:)`

``` swift
public func traitCollectionDidChange(_ previousTraitCollection: TraitCollection?) 
```
