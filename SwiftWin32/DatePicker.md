---
layout: default
title: DatePicker
parent: SwiftWin32
---
# DatePicker

``` swift
public class DatePicker: Control 
```

## Inheritance

[`Control`](https://compnerd.github.io/swift-win32/SwiftWin32/Control)

## Initializers

### `init(frame:)`

``` swift
public init(frame: Rect) 
```

## Properties

### `date`

The date displayed by the date picker.

``` swift
public var date: Date 
```

### `datePickerStyle`

``` swift
public private(set) var datePickerStyle: DatePickerStyle = .inline
```

### `preferredDatePickerStyle`

``` swift
public private(set) var preferredDatePickerStyle: DatePickerStyle = .automatic 
```

## Methods

### `setDate(_:animated:)`

Sets the date to display in the date picker, with an option to animate the
setting.

``` swift
public func setDate(_ date: Date, animated: Bool) 
```
