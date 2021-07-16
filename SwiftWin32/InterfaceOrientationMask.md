---
layout: default
title: InterfaceOrientationMask
parent: SwiftWin32
---
# InterfaceOrientationMask

These constants are mask bits for specifying a view controller's supported
interface orientations.

``` swift
public struct InterfaceOrientationMask: OptionSet 
```

## Inheritance

`OptionSet`

## Nested Type Aliases

### `RawValue`

``` swift
public typealias RawValue = UInt
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

### `portrait`

The view controller supports a portrait interface orientation.

``` swift
public static var portrait: InterfaceOrientationMask 
```

### `landscapeLeft`

The view controller supports a landscape-left interface orientation.

``` swift
public static var landscapeLeft: InterfaceOrientationMask 
```

### `landscapeRight`

The view controller supports a landscape-right interface orientation.

``` swift
public static var landscapeRight: InterfaceOrientationMask 
```

### `portraitUpsideDown`

The view controller supports an upside-down portrait interface
orientation.

``` swift
public static var portraitUpsideDown: InterfaceOrientationMask 
```

### `landscape`

The view controller supports both landscape-left and landscape-right
interface orientation.

``` swift
public static var landscape: InterfaceOrientationMask 
```

### `all`

The view controller supports all interface orientations.

``` swift
public static var all: InterfaceOrientationMask 
```

### `allButUpsideDown`

The view controller supports all but the upside-down portrait interface
orientation.

``` swift
public static var allButUpsideDown: InterfaceOrientationMask 
```
