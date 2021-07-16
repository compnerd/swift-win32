---
layout: default
title: Device
parent: SwiftWin32
---
# Device

``` swift
public struct Device 
```

## Properties

### `current`

``` swift
public static let current: Device 
```

### `isMultitaskingSupported`

Is multitasking supported on the current device

``` swift
public internal(set) var isMultitaskingSupported: Bool = true
```

### `name`

The name identifyying the device

``` swift
public var name: String 
```

### `systemName`

The name of the operating system running on the device represented by the

``` swift
public var systemName: String 
```

### `systemVersion`

The current version of the operating system.

``` swift
public var systemVersion: String 
```

### `model`

The model of the device.

``` swift
public var model: String 
```

### `localizedModel`

``` swift
public var localizedModel: String 
```

### `userInterfaceIdiom`

The style of interface to use on the current device.

``` swift
public var userInterfaceIdiom: UserInterfaceIdiom 
```

### `identifierForVendor`

An alphanumeric string that uniquely identifies a device to the
application vendor.

``` swift
public var identifierForVendor: UUID? 
```

### `orientation`

Tracking the Device Orientation

``` swift
public var orientation: Device.Orientation 
```

### `isGeneratingDeviceOrientationNotifications`

``` swift
public private(set) var isGeneratingDeviceOrientationNotifications: Bool =
      false
```

### `isPortrait`

Determining the Current Orientation

``` swift
public var isPortrait: Bool 
```

### `isLandscape`

``` swift
public var isLandscape: Bool 
```

### `isValidIntefaceOrientation`

``` swift
public var isValidIntefaceOrientation: Bool 
```

### `batteryLevel`

Getting the Device Battery State

``` swift
public var batteryLevel: Float 
```

### `isBatteryMonitoringEnabled`

``` swift
public var isBatteryMonitoringEnabled: Bool = false 
```

### `batteryState`

``` swift
public var batteryState: Device.BatteryState 
```

### `batteryLevelDidChangeNotification`

``` swift
public static var batteryLevelDidChangeNotification: NSNotification.Name 
```

### `batteryStateDidChangeNotification`

``` swift
public static var batteryStateDidChangeNotification: NSNotification.Name 
```

### `orientationDidChangeNotification`

``` swift
public static var orientationDidChangeNotification: NSNotification.Name 
```

### `proximityStateDidChangeNotification`

``` swift
public static var proximityStateDidChangeNotification: NSNotification.Name 
```

## Methods

### `beginGeneratingDeviceOrientationNotifications()`

``` swift
public func beginGeneratingDeviceOrientationNotifications() 
```

### `endGeneratingDeviceOrientationNotifications()`

``` swift
public func endGeneratingDeviceOrientationNotifications() 
```
