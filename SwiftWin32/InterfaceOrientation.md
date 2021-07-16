---
layout: default
title: InterfaceOrientation
parent: SwiftWin32
---
# InterfaceOrientation

The orientation of the application's user interface

``` swift
public enum InterfaceOrientation: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `unknown`

The orientation of the device is unknown.

``` swift
case unknown
```

### `portrait`

The device is in portrait mode, with the device upright.

``` swift
case portrait
```

### `portraitUpsideDown`

The device is in portrait mode, with the device upside down.

``` swift
case portraitUpsideDown
```

### `landscapeLeft`

The device is in landscape mode, with the device upright.

``` swift
case landscapeLeft
```

### `landscapeRight`

The device is in landscape mode, with the device upright.

``` swift
case landscapeRight
```

## Properties

### `isLandscape`

``` swift
public var isLandscape: Bool 
```

### `isPortrait`

``` swift
public var isPortrait: Bool 
```
