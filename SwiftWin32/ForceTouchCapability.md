---
layout: default
title: ForceTouchCapability
parent: SwiftWin32
---
# ForceTouchCapability

Keys that indicate the availability of 3D Touch on a device.

``` swift
public enum ForceTouchCapability: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `unspecified`

The availability of 3D Touch is unknown.

``` swift
case unspecified
```

A view has this trait after you create it but before you add it your
application's view hierarchy.

### `available`

3D Touch is available on the device.

``` swift
case available
```

### `unavailable`

3D Touch is not available on the device.

``` swift
case unavailable
```
