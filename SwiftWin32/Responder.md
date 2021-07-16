---
layout: default
title: Responder
parent: SwiftWin32
---
# Responder

``` swift
open class Responder 
```

## Properties

### `next`

Returns the next responder in the responder chain, or `nil` if there is no
next responder.

``` swift
open var next: Responder? 
```

### `isFirstResponder`

Indicates whether this object is the first responder.

``` swift
open var isFirstResponder: Bool 
```

### `canBecomeFirstResponder`

Indiciates whether ths object can become the first responder.

``` swift
open var canBecomeFirstResponder: Bool 
```

### `canResignFirstResponder`

Indicates whether this object is willing to relinquish first-responder
status.

``` swift
open var canResignFirstResponder: Bool 
```

### `inputView`

The custom input view to display when the receiver becomes the first
responder.

``` swift
open private(set) var inputView: View?
```

### `inputViewController`

The custom input view controller to use when the receiver becomes the
first responder.

``` swift
open private(set) var inputViewController: InputViewController?
```

### `inputAccessoryView`

The custom input accessory view to display when the receiver becomes the
first responder.

``` swift
open private(set) var inputAccessoryView: View?
```

### `inputAccessoryViewController`

The custom input accessory view controller to display when the receiver
becomes the first responder.

``` swift
open private(set) var inputAccessoryViewController: InputViewController?
```

### `keyboardAnimationCurveUserInfoKey`

A user info key to retrieve the animation curve that the system uses to
animate the keyboard onto or off the screen.

``` swift
public class var keyboardAnimationCurveUserInfoKey: String 
```

### `keyboardAnimationDurationUserInfoKey`

A user info key to retrieve the duration of the keyboard animation in
seconds.

``` swift
public class var keyboardAnimationDurationUserInfoKey: String 
```

### `keyboardFrameBeginUserInfoKey`

A user info key to retrieve the keyboard’s frame at the beginning of its
animation.

``` swift
public class var keyboardFrameBeginUserInfoKey: String 
```

### `keyboardFrameEndUserInfoKey`

A user info key to retrieve the keyboard’s frame at the end of its
animation.

``` swift
public class var keyboardFrameEndUserInfoKey: String 
```

### `keyboardIsLocalUserInfoKey`

A user info key to retrieve a boolean value that indicates whether the
keyboard belongs to the current app.

``` swift
public class var keyboardIsLocalUserInfoKey: String 
```

### `keyboardDidChangeFrameNotification`

Posted immediately after a change in the keyboard’s frame.

``` swift
public class var keyboardDidChangeFrameNotification: NSNotification.Name 
```

### `keyboardDidHideNotification`

Posted immediately after the dismissal of the keyboard.

``` swift
public class var keyboardDidHideNotification: NSNotification.Name 
```

### `keyboardDidShowNotification`

Posted immediately after the display of the keyboard.

``` swift
public class var keyboardDidShowNotification: NSNotification.Name 
```

### `keyboardWillChangeFrameNotification`

Posted immediately prior to a change in the keyboard’s frame.

``` swift
public class var keyboardWillChangeFrameNotification: NSNotification.Name 
```

### `keyboardWillHideNotification`

Posted immediately prior to the dismissal of the keyboard.

``` swift
public class var keyboardWillHideNotification: NSNotification.Name 
```

### `keyboardWillShowNotification`

Posted immediately prior to the display of the keyboard.

``` swift
public class var keyboardWillShowNotification: NSNotification.Name 
```

## Methods

### `becomeFirstResponder()`

Results to make this object the first responder in its window.

``` swift
open func becomeFirstResponder() -> Bool 
```

### `resignFirstResponder()`

Notifies the object that it has been asked to relinquish its status as
first responder in its window.

``` swift
open func resignFirstResponder() -> Bool 
```

### `touchesBegan(_:with:)`

Informs the responder that one or more new touches occurrd in a view or a
window.

``` swift
open func touchesBegan(_ touches: Set<Touch>, with event: Event?) 
```

### `touchesMoved(_:with:)`

Informs the responder when one or more touches associated with an event
changed.

``` swift
open func touchesMoved(_ touches: Set<Touch>, with event: Event?) 
```

### `touchesEnded(_:with:)`

Informs the responder when one or more fingers are raised from a view or a
window.

``` swift
open func touchesEnded(_ touches: Set<Touch>, with event: Event?) 
```

### `touchesCancelled(_:with:)`

Informs the responder when a system event (such as a system alert) cancels
a touch sequence.

``` swift
open func touchesCancelled(_ touches: Set<Touch>, with event: Event?) 
```

### `touchesEstimatedPropertiesUpdated(_:)`

Tells the responder that updated values were received for previously
estimated properties or that an update is no longer expected.

``` swift
open func touchesEstimatedPropertiesUpdated(_ touches: Set<Touch>) 
```

### `motionBegan(_:with:)`

Tells the receiver that a motion event has begun.

``` swift
open func motionBegan(_ motion: Event.EventSubtype, with event: Event?) 
```

### `motionEnded(_:with:)`

Tells the receiver that a motion event has ended.

``` swift
open func motionEnded(_ motion: Event.EventSubtype, with event: Event?) 
```

### `motionCancelled(_:with:)`

Tells the receiver that a motion event has been cancelled.

``` swift
open func motionCancelled(_ motion: Event.EventSubtype, with event: Event?) 
```

### `pressesBegan(_:with:)`

NOTE:​ Generally, responders that handle press events should override all
four of these methods.
Tells this object when a physical button is first pressed.

``` swift
open func pressesBegan(_ presses: Set<Press>, with event: PressesEvent?) 
```

### `pressesChanged(_:with:)`

Tells this object when a value associated with a press has changed.

``` swift
open func pressesChanged(_ presses: Set<Press>, with event: PressesEvent?) 
```

### `pressesEnded(_:with:)`

Tells the object when a button is released.

``` swift
open func pressesEnded(_ presses: Set<Press>, with event: PressesEvent?) 
```

### `pressesCancelled(_:with:)`

Tells this object when a system event (such as a low-memory warning) cancels a press event.

``` swift
open func pressesCancelled(_ presses: Set<Press>, with event: PressesEvent?) 
```

### `remoteControlReceived(with:)`

Tells the object when a remote-control event is received.

``` swift
open func remoteControlReceived(with event: Event?) 
```

### `reloadInputViews()`

Updates the custom input and accessory views when the object is the first
responder.

``` swift
open func reloadInputViews() 
```

### `buildMenu(with:)`

Asks the receiving responder to add and remove items from a menu system.

``` swift
open func buildMenu(with builder: MenuBuilder) 
```

### `validate(_:)`

Asks the receiving responder to validate the command.

``` swift
public func validate(_ command: Command) 
```

### `canPerformAction(_:withSender:)`

Requests the receiving responder to enable or disable the specified
command in the user interface.

``` swift
open func canPerformAction(_ action: (AnyObject) -> (_: Action, _: Any?) -> Void,
                             withSender sender: Any?) -> Bool 
```

### `target(forAction:withSender:)`

``` swift
open func target(forAction action: (AnyObject) -> (_: Action, _: Any?) -> Void,
                   withSender sender: Any?) -> Any? 
```
