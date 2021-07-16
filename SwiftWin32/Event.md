---
layout: default
title: Event
parent: SwiftWin32
---
# Event

An object that describes a single user interaction with your app.

``` swift
open class Event 
```

## Properties

### `allTouches`

Returns all touches associated with the event.

``` swift
open private(set) var allTouches: Set<Touch>?
```

### `timestamp`

The time when the event occurred.

``` swift
open private(set) var timestamp: TimeInterval
```

### `type`

Returns the type of the event.

``` swift
open private(set) var type: Event.EventType
```

### `subtype`

Returns the subtype of the event.

``` swift
open private(set) var subtype: Event.EventSubtype
```

### `buttonMask`

``` swift
open private(set) var buttonMask: Event.ButtonMask
```

### `modifierFlags`

``` swift
open private(set) var modifierFlags: KeyModifierFlags
```

## Methods

### `touches(for:)`

Returns the touch objects from the event that belong to the specified
given view.

``` swift
open func touches(for view: View) -> Set<Touch>? 
```

### `touches(for:)`

Returns the touch objects from the event that belong to the specified
window.

``` swift
open func touches(for window: Window) -> Set<Touch>? 
```

### `coalescedTouches(for:)`

Returns all of the touches associated with the specified main touch.

``` swift
open func coalescedTouches(for touch: Touch) -> [Touch]? 
```

### `predictedTouches(for:)`

Returns an array of touches that are predicted to occur for the specified
touch.

``` swift
open func predictedTouches(for touch: Touch) -> [Touch]? 
```

### `touches(for:)`

Returns the touch objects that are being delivered to the specified
gesture recognizer.

``` swift
open func touches(for gesture: GestureRecognizer) -> Set<Touch>? 
```
