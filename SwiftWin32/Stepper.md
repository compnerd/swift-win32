---
layout: default
title: Stepper
parent: SwiftWin32
---
# Stepper

A control for incrementing or decrementing a value.

``` swift
public class Stepper: Control 
```

## Inheritance

[`Control`](https://compnerd.github.io/swift-win32/SwiftWin32/Control)

## Initializers

### `init(frame:)`

``` swift
public init(frame: Rect) 
```

## Properties

### `isContinuous`

A boolean value that determines whether to send value changes during user
interaction or after user interaction ends.

``` swift
public var isContinuous: Bool = true 
```

### `autorepeat`

A boolean value that determines whether to repeatedly change the stepper's
value as the user presses and holds a stepper button.

``` swift
public var autorepeat: Bool = true 
```

### `wraps`

A boolean value that determines whether the stepper can wrap its value to
the minimum or maximum value when incrementing and decrementing the value.

``` swift
public var wraps: Bool 
```

### `minimumValue`

The lowest possible numeric value for the stepper.

``` swift
public var minimumValue: Double 
```

### `maximumValue`

The highest possible numeric value for the stepper.

``` swift
public var maximumValue: Double 
```

### `stepValue`

The step, or increment, value for the stepper.

``` swift
public var stepValue: Double 
```

### `value`

The numeric value of the stepper.

``` swift
public var value: Double 
```
