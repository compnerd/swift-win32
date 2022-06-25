---
layout: default
title: Press
parent: SwiftWin32
---
# Press

An object that represents the presence or movement of a button press on the
screen for a particular event.

``` swift
open class Press 
```

## Inheritance

`Equatable`, `Hashable`

## Properties

### `force`

The force of the button press.

``` swift
open private(set) var force: Double
```

### `gestureRecognizers`

The gesture recognizers that are receiving the press.

``` swift
open private(set) var gestureRecognizers: [GestureRecognizer]?
```

### `responder`

A `Responder` object.

``` swift
open private(set) var responder: Responder?
```

### `window`

The window in which the press initially occurred.

``` swift
open private(set) var window: Window?
```

### `key`

<dl>
<dt><code>false</code></dt>
<dd>

``` swift
open private(set) var key: Key?
```

</dd>
</dl>

### `type`

The type of the specified press.

``` swift
open private(set) var type: Press.PressType
```

### `phase`

The current press phase of the object.

``` swift
open private(set) var phase: Press.Phase
```

### `timestamp`

The time when the press occurred or when it was last mutated.

``` swift
open private(set) var timestamp: TimeInterval
```

## Methods

### `hash(into:)`

``` swift
public func hash(into hasher: inout Hasher) 
```

## Operators

### `==`

``` swift
public static func ==(_ lhs: Press, _ rhs: Press) -> Bool 
```
