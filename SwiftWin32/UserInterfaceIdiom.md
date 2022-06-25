---
layout: default
title: UserInterfaceIdiom
parent: SwiftWin32
---
# UserInterfaceIdiom

Constants that indicate the interface type for the device or an object that
has a trait environment, such as a view and view controller.

``` swift
public enum UserInterfaceIdiom: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `unspecified`

An unspecified idiom.

``` swift
case unspecified = -1
```

### `phone`

An interface designed for a phone.

``` swift
case phone
```

### `pad`

``` swift
@available(*, deprecated, renamed: "UserInterfaceIdiom.tablet")
  case pad
```

### `tv`

An interface designed for a TV.

``` swift
case tv
```

### `carPlay`

``` swift
@available(*, deprecated, message: "Use UserInterfaceIdiom.car")
  case carPlay
```

### `mac`

``` swift
@available(*, deprecated, renamed: "UserInterfaceIdiom.desktop")
  case mac
```

### `tablet`

An interface designed for a tablet.

``` swift
case tablet
```

### `car`

An interface designed for a car display.

``` swift
case car
```

### `desktop`

An interface designed for a desktop or laptop.

``` swift
case desktop
```

### `headset`

An interface designed for a AR/VR device.

``` swift
case headset
```
