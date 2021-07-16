---
layout: default
title: GestureRecognizerDelegate
parent: SwiftWin32
---
# GestureRecognizerDelegate

A set of methods implemented by the delegate of a gesture recognizer to
fine-tune an application’s gesture-recognition behavior.

``` swift
public protocol GestureRecognizerDelegate: AnyObject 
```

## Inheritance

`AnyObject`

## Default Implementations

### `gestureRecognizerShouldBegin(_:)`

``` swift
public func gestureRecognizerShouldBegin(_ gestureRecognizer: GestureRecognizer)
      -> Bool 
```

### `gestureRecognizer(_:shouldReceive:)`

``` swift
public func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                                shouldReceive touch: Touch) -> Bool 
```

### `gestureRecognizer(_:shouldReceive:)`

<dl>
<dt><code>NOT_YET_IMPLEMENTED</code></dt>
<dd>

``` swift
public func gestureRecognizer(_ gestureRecognizer: GestureRecognizer,
                                shouldReceive press: Press) -> Bool 
```

</dd>
</dl>

### `gestureRecognizer(_:shouldReceive:)`

``` swift
public func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                                shouldReceive event: Event) -> Bool 
```

### `gestureRecognizer(_:shouldRecognizeSimultaneouslyWith:)`

``` swift
public func gestureRecognizer(_ gestureRecognizer: GestureRecognizer,
                                shouldRecognizeSimultaneouslyWith otherGestureRecognizer: GestureRecognizer)
      -> Bool 
```

### `gestureRecognizer(_:shouldRequireFailureOf:)`

``` swift
public func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                                shouldRequireFailureOf otherGestureRecognizer: GestureRecognizer)
      -> Bool 
```

### `gestureRecognizer(_:shouldBeRequiredToFailBy:)`

``` swift
public func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                                shouldBeRequiredToFailBy otherGestureRecognizer: GestureRecognizer)
      -> Bool 
```

## Requirements

### gestureRecognizerShouldBegin(\_:​)

Asks the delegate if a gesture recognizer should begin interpreting
touches.

``` swift
func gestureRecognizerShouldBegin(_ gestureRecognizer: GestureRecognizer)
      -> Bool
```

### gestureRecognizer(\_:​shouldReceive:​)

Asks the delegate if a gesture recognizer should receive an object
representing a touch.

``` swift
func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                         shouldReceive touch: Touch) -> Bool
```

### gestureRecognizer(\_:​shouldReceive:​)

<dl>
<dt><code>NOT_YET_IMPLEMENTED</code></dt>
<dd>

``` swift
func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                         shouldReceive press: Press) -> Bool
```

</dd>
</dl>

### gestureRecognizer(\_:​shouldReceive:​)

Asks the delegate if a gesture recognizer should receive an object
representing a touch or press event.

``` swift
func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                         shouldReceive event: Event) -> Bool
```

### gestureRecognizer(\_:​shouldRecognizeSimultaneouslyWith:​)

Asks the delegate if two gesture recognizers should be allowed to
recognize gestures simultaneously.

``` swift
func gestureRecognizer(_ gestureRecognizer: GestureRecognizer,
                         shouldRecognizeSimultaneouslyWith otherGestureRecognizer: GestureRecognizer)
      -> Bool
```

### gestureRecognizer(\_:​shouldRequireFailureOf:​)

Asks the delegate if a gesture recognizer should require another gesture
recognizer to fail.

``` swift
func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                         shouldRequireFailureOf otherGestureRecognizer: GestureRecognizer)
      -> Bool
```

### gestureRecognizer(\_:​shouldBeRequiredToFailBy:​)

Asks the delegate if a gesture recognizer should be required to fail by
another gesture recognizer.

``` swift
func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, 
                         shouldBeRequiredToFailBy otherGestureRecognizer: GestureRecognizer)
      -> Bool
```
