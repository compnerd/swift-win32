---
layout: default
title: Touch.Phase
parent: SwiftWin32
---
# Touch.Phase

The phase of a touch event.

``` swift
public enum Phase: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `began`

A touch for a given event has pressed down on the screen.

``` swift
case began
```

### `moved`

A touch for a given event has moved over the screen.

``` swift
case moved
```

### `stationary`

A touch for a given event is presseddown on the screen, but hasn't moved
since the previous event.

``` swift
case stationary
```

### `ended`

A touch for a given event has lifted from the screen.

``` swift
case ended
```

### `cancelled`

The system cancelled tracking for a touch, for example, when the user
moves the device against their face.

``` swift
case cancelled
```

### `regionEntered`

A touch for a given event has entered a window on the screen.

``` swift
case regionEntered
```

### `regionMoved`

A touch for the given event is within a window on the screen, but has not
yet pressed down.

``` swift
case regionMoved
```

### `regionExited`

A touch for given event has left a window on the screen.

``` swift
case regionExited
```
