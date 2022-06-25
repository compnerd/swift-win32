---
layout: default
title: GestureRecognizer
parent: SwiftWin32
---
# GestureRecognizer

``` swift
public class GestureRecognizer 
```

## Initializers

### `init(target:action:)`

Initializes an allocated gesture-recognizer object with a target and an
action selector.

``` swift
public init<Target: AnyObject>(target: Target,
                                 action: @escaping (Target) -> () -> Void) 
```

The valid signatures for `action` are:

  - `(Target) -> () -> Void` aka `()`

  - `(Target) -> (_: GestureRecognizer) -> Void` aka `(_: GestureRecognizer)`

Although the signature permits nullable types, the values may not be nil.

### `init(target:action:)`

``` swift
public init<Target: AnyObject>(target: Target,
                                 action: @escaping (Target) -> (_: GestureRecognizer) -> Void) 
```

### `init()`

``` swift
public /* convenience */ init() 
```

## Properties

### `delegate`

The delegate of the gesture recognizer.

``` swift
public weak var delegate: GestureRecognizerDelegate?
```

### `numberOfTouches`

Returns the number of touches involved in the gesture represented by the
receiver.

``` swift
public private(set) var numberOfTouches: Int = 0
```

### `state`

The current state of the gesture recognizer.

``` swift
public var state: GestureRecognizer.State = .possible
```

### `view`

The view the gesture recognizer is attached to.

``` swift
public internal(set) var view: View?
```

### `isEnabled`

A boolean property that indicates whether the gesture recognizer is
enabled.

``` swift
public var isEnabled: Bool = true
```

### `buttonMask`

A bit mask of the button (or buttons) in the gesture represented by the
receiver.

``` swift
public private(set) var buttonMask: Event.ButtonMask = []
```

### `modifierFlags`

Constants that indicate which modifier keys are pressed.

``` swift
public private(set) var modifierFlags: KeyModifierFlags = []
```

### `name`

The name associated with the gesture recognizer.

``` swift
public var name: String?
```

## Methods

### `addTarget(_:action:)`

Adds a target and an action to a gesture-recognizer object.

``` swift
public func addTarget<Target: AnyObject>(_ target: Target,
                                           action: @escaping (Target) -> () -> Void) 
```

The valid signatures for `action` are:

  - `(Target) -> () -> Void` aka `()`

  - `(Target) -> (_: GestureRecognizer) -> Void` aka `(_: GestureRecognizer)`

### `addTarget(_:action:)`

``` swift
public func addTarget<Target: AnyObject>(_ target: Target,
                                           action: @escaping (Target) -> (_: GestureRecognizer) -> Void) 
```

### `removeTarget(_:action:)`

Removes a target and an action from a gesture-recognizer object.

``` swift
public func removeTarget<Target: AnyObject>(_ target: Target,
                                              action: @escaping (Target) -> () -> Void) 
```

### `removeTarget(_:action:)`

``` swift
public func removeTarget<Target: AnyObject>(_ target: Target,
                                              action: @escaping (Target) -> (_: GestureRecognizer) -> Void) 
```

### `location(in:)`

Returns the point computed as the location in a given view of the gesture
represented by the receiver.

``` swift
public func location(in view: View?) -> Point 
```

### `location(ofTouch:in:)`

Returns the location of one of the gesture’s touches in the local
coordinate system of a given view.

``` swift
public func location(ofTouch touchIndex: Int, in view: View?) -> Point 
```

### `shouldReceive(_:)`

``` swift
public func shouldReceive(_ event: Event) -> Bool 
```
