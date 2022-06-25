---
layout: default
title: Control.Event
parent: SwiftWin32
---
# Control.Event

Constants describing the types of events possible for controls.

``` swift
public struct Event: Equatable, Hashable, RawRepresentable 
```

## Inheritance

`Equatable`, `Hashable`, `RawRepresentable`

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

### `touchDown`

A touch-down event in the control.

``` swift
public static var touchDown: Control.Event 
```

### `touchDownRepeat`

A repeated touch-down event in the control; for this event the value of
the UITouch tapCount method is greater than one.

``` swift
public static var touchDownRepeat: Control.Event 
```

### `touchDragInside`

An event where a finger is dragged inside the bounds of the control.

``` swift
public static var touchDragInside: Control.Event 
```

### `touchDragOutside`

An event where a finger is dragged just outside the bounds of the control.

``` swift
public static var touchDragOutside: Control.Event 
```

### `touchDragEnter`

An event where a finger is dragged into the bounds of the control.

``` swift
public static var touchDragEnter: Control.Event 
```

### `touchDragExit`

An event where a finger is dragged from within a control to outside its
bounds.

``` swift
public static var touchDragExit: Control.Event 
```

### `touchUpInside`

A touch-up event in the control where the finger is inside the bounds of
the control.

``` swift
public static var touchUpInside: Control.Event 
```

### `touchUpOutside`

A touch-up event in the control where the finger is outside the bounds of
the control.

``` swift
public static var touchUpOutside: Control.Event 
```

### `touchCancel`

A system event canceling the current touches for the control.

``` swift
public static var touchCancel: Control.Event 
```

### `valueChanged`

A touch dragging or otherwise manipulating a control, causing it to emit
a series of different values.

``` swift
public static var valueChanged: Control.Event 
```

### `menuActionTriggered`

A menu action has triggered prior to the menu being presented.

``` swift
public static var menuActionTriggered: Control.Event 
```

### `primaryActionTriggered`

A semantic action triggered by buttons.

``` swift
public static var primaryActionTriggered: Control.Event 
```

### `editingDidBegin`

A touch initiating an editing session in a `TextField` object by entering
its bounds.

``` swift
public static var editingDidBegin: Control.Event 
```

### `editingChanged`

A touch making an editing change in a `TextField` object.

``` swift
public static var editingChanged: Control.Event 
```

### `editingDidEnd`

A touch ending an editing session in a `TextField` object by leaving its
bounds.

``` swift
public static var editingDidEnd: Control.Event 
```

### `editingDidEndOnExit`

A touch ending an editing session in a `TextField` object.

``` swift
public static var editingDidEndOnExit: Control.Event 
```

### `allTouchEvents`

All touch events.

``` swift
public static var allTouchEvents: Control.Event 
```

### `allEditingEvents`

All editing touches for `TextField` objects.

``` swift
public static var allEditingEvents: Control.Event 
```

### `applicationReserved`

A range of control-event values available for application use.

``` swift
public static var applicationReserved: Control.Event 
```

### `systemReserved`

A range of control-event values reserved for internal framework use.

``` swift
public static var systemReserved: Control.Event 
```

### `allEvents`

All events, including system events.

``` swift
public static var allEvents: Control.Event 
```
