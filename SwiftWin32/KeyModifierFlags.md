---
layout: default
title: KeyModifierFlags
parent: SwiftWin32
---
# KeyModifierFlags

Constants that indicate which modifier keys are pressed.

``` swift
public struct KeyModifierFlags: OptionSet 
```

## Inheritance

`OptionSet`

## Nested Type Aliases

### `RawValue`

``` swift
public typealias RawValue = Int
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

### `alphaShift`

A modifier flag that indicates the user pressed the Caps Lock key.

``` swift
public static var alphaShift: KeyModifierFlags 
```

### `shift`

A modifier flag that indicates the user pressed the Shift key.

``` swift
public static var shift: KeyModifierFlags 
```

### `control`

A modifier flag that indicates the user pressed the Control key.

``` swift
public static var control: KeyModifierFlags 
```

### `alternate`

A modifier flag that indicates the user pressed the Option key.

``` swift
public static var alternate: KeyModifierFlags 
```

### `command`

A modifier flag that indicates the user pressed the Command key.

``` swift
public static var command: KeyModifierFlags 
```

### `numericPad`

A modifier flag that indicates the user pressed a key located on the
numeric keypad.

``` swift
public static var numericPad: KeyModifierFlags 
```
