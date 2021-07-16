---
layout: default
title: Switch
parent: SwiftWin32
---
# Switch

A control that offers a binary choice, such as on/off.

``` swift
public class Switch: Control 
```

## Inheritance

[`Control`](https://compnerd.github.io/swift-win32/SwiftWin32/Control)

## Initializers

### `init(frame:)`

Returns an initialized switch object.

``` swift
public init(frame: Rect) 
```

## Properties

### `isOn`

A Boolean value that determines the off/on state of the switch.

``` swift
public var isOn: Bool 
```

### `preferredStyle`

The preferred display style for the switch.

``` swift
public var preferredStyle: Switch.Style = .automatic 
```

### `style`

The display style for the switch.

``` swift
public private(set) var style: Switch.Style = .checkbox
```

### `title`

The title displayed next to a checkbox-style switch.

``` swift
@_Win32WindowText
  public var title: String?
```

## Methods

### `setOn(_:animated:)`

Set the state of the switch to On or Off, optionally animating the
transition.

``` swift
public func setOn(_ on: Bool, animated: Bool) 
```
