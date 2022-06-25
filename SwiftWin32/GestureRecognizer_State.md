---
layout: default
title: GestureRecognizer.State
parent: SwiftWin32
---
# GestureRecognizer.State

The current state a gesture recognizer is in.

``` swift
public enum State: Int 
```

## Inheritance

`Int`

## Enumeration Cases

### `possible`

The gesture recognizer has not yet recognized its gesture, but may be
evaluating touch events. This is the default state.

``` swift
case possible
```

### `began`

The gesture recognizer has received touch objects recognized as a
continuous gesture. It sends its action message (or messages) at the
next cycle of the run loop.

``` swift
case began
```

### `changed`

The gesture recognizer has received touches recognized as a change to a
continuous gesture. It sends its action message (or messages) at the
next cycle of the run loop.

``` swift
case changed
```

### `ended`

The gesture recognizer has received touches recognized as the end of a
continuous gesture. It sends its action message (or messages) at the
next cycle of the run loop and resets its state to
`GestureRecognizer.State.possible`.

``` swift
case ended
```

### `cancelled`

The gesture recognizer has received touches resulting in the
cancellation of a continuous gesture. It sends its action message (or
messages) at the next cycle of the run loop and resets its state to
`GestureRecognizer.State.possible`.

``` swift
case cancelled
```

### `failed`

The gesture recognizer has received a multi-touch sequence that it
cannot recognize as its gesture. No action message is sent and the
gesture recognizer is reset to `GestureRecognizer.State.possible`.

``` swift
case failed
```

## Properties

### `recognized`

The gesture recognizer has received a multi-touch sequence that it
recognizes as its gesture. It sends its action message (or messages) at
the next cycle of the run loop and resets its state to
`GestureRecognizer.State.possible`.

``` swift
public static var recognized: GestureRecognizer.State 
```
