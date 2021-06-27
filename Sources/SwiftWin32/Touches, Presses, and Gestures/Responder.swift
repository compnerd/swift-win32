// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import class Foundation.NSNotification

open class Responder {
  // MARK - Managing the Responder Chain

  /// Returns the next responder in the responder chain, or `nil` if there is no
  /// next responder.
  open var next: Responder? { nil }

  /// Indicates whether this object is the first responder.
  open var isFirstResponder: Bool { return self.next === self }

  /// Indiciates whether ths object can become the first responder.
  open var canBecomeFirstResponder: Bool { false }

  /// Results to make this object the first responder in its window.
  open func becomeFirstResponder() -> Bool {
    guard !self.isFirstResponder else { return true }
    guard self.canBecomeFirstResponder else { return false }
    return true
  }

  /// Indicates whether this object is willing to relinquish first-responder
  /// status.
  open var canResignFirstResponder: Bool { true }

  /// Notifies the object that it has been asked to relinquish its status as
  /// first responder in its window.
  open func resignFirstResponder() -> Bool {
    return true
  }

  // MARK - Responding to Touch Events

  /// Informs the responder that one or more new touches occurrd in a view or a
  /// window.
  open func touchesBegan(_ touches: Set<Touch>, with event: Event?) {
  }

  /// Informs the responder when one or more touches associated with an event
  /// changed.
  open func touchesMoved(_ touches: Set<Touch>, with event: Event?) {
  }

  /// Informs the responder when one or more fingers are raised from a view or a
  /// window.
  open func touchesEnded(_ touches: Set<Touch>, with event: Event?) {
  }

  /// Informs the responder when a system event (such as a system alert) cancels
  /// a touch sequence.
  open func touchesCancelled(_ touches: Set<Touch>, with event: Event?) {
  }

  /// Tells the responder that updated values were received for previously
  /// estimated properties or that an update is no longer expected.
  open func touchesEstimatedPropertiesUpdated(_ touches: Set<Touch>) {
  }

  // MARK - Responding to Motion Events

  /// Tells the receiver that a motion event has begun.
  open func motionBegan(_ motion: Event.EventSubtype, with event: Event?) {
  }

  /// Tells the receiver that a motion event has ended.
  open func motionEnded(_ motion: Event.EventSubtype, with event: Event?) {
  }

  /// Tells the receiver that a motion event has been cancelled.
  open func motionCancelled(_ motion: Event.EventSubtype, with event: Event?) {
  }

  // MARK - Responding to Press Events

  /// NOTE: Generally, responders that handle press events should override all
  /// four of these methods.

  /// Tells this object when a physical button is first pressed.
  open func pressesBegan(_ presses: Set<Press>, with event: PressesEvent?) {
  }

  /// Tells this object when a value associated with a press has changed.
  open func pressesChanged(_ presses: Set<Press>, with event: PressesEvent?) {
  }

  /// Tells the object when a button is released.
  open func pressesEnded(_ presses: Set<Press>, with event: PressesEvent?) {
  }

  /// Tells this object when a system event (such as a low-memory warning) cancels a press event.
  open func pressesCancelled(_ presses: Set<Press>, with event: PressesEvent?) {
  }

  // MARK - Responding to Remote-Control Events

  /// Tells the object when a remote-control event is received.
  open func remoteControlReceived(with event: Event?) {
  }

  // MARK - Managing Input Views

  /// The custom input view to display when the receiver becomes the first
  /// responder.
  open private(set) var inputView: View?

  /// The custom input view controller to use when the receiver becomes the
  /// first responder.
  open private(set) var inputViewController: InputViewController?

  /// The custom input accessory view to display when the receiver becomes the
  /// first responder.
  open private(set) var inputAccessoryView: View?

  /// The custom input accessory view controller to display when the receiver
  /// becomes the first responder.
  open private(set) var inputAccessoryViewController: InputViewController?

  /// Updates the custom input and accessory views when the object is the first
  /// responder.
  open func reloadInputViews() {
  }

  // MARK - Building and Validating Commands

  /// Asks the receiving responder to add and remove items from a menu system.
  open func buildMenu(with builder: MenuBuilder) {
    self.next?.buildMenu(with: builder)
  }

  /// Asks the receiving responder to validate the command.
  public func validate(_ command: Command) {
    self.next?.validate(command)
  }

  /// Requests the receiving responder to enable or disable the specified
  /// command in the user interface.
  open func canPerformAction(_ action: (AnyObject) -> (_: Action, _: Any?) -> Void,
                             withSender sender: Any?) -> Bool {
    fatalError("\(#function) not yet implemented")
  }

  open func target(forAction action: (AnyObject) -> (_: Action, _: Any?) -> Void,
                   withSender sender: Any?) -> Any? {
    guard canPerformAction(action, withSender: sender) else { return nil }
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Responding to Keyboard Notifications

  /// A user info key to retrieve the animation curve that the system uses to
  /// animate the keyboard onto or off the screen.
  public class var keyboardAnimationCurveUserInfoKey: String {
    "UIResponderKeyboardAnimationCurveUserInfoKey"
  }

  /// A user info key to retrieve the duration of the keyboard animation in
  /// seconds.
  public class var keyboardAnimationDurationUserInfoKey: String {
    "UIResponderKeyboardAnimationDurationUserInfoKey"
  }

  /// A user info key to retrieve the keyboard’s frame at the beginning of its
  /// animation.
  public class var keyboardFrameBeginUserInfoKey: String {
    "UIResponderKeyboardFrameBeginUserInfoKey"
  }

  /// A user info key to retrieve the keyboard’s frame at the end of its
  /// animation.
  public class var keyboardFrameEndUserInfoKey: String {
    "UIResponderKeyboardFrameEndUserInfoKey"
  }

  /// A user info key to retrieve a boolean value that indicates whether the
  /// keyboard belongs to the current app.
  public class var keyboardIsLocalUserInfoKey: String {
    "UIResponderKeyboardIsLocalUserInfoKey"
  }

  /// Posted immediately after a change in the keyboard’s frame.
  public class var keyboardDidChangeFrameNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIResponderKeyboardDidChangeFrameNotification")
  }

  /// Posted immediately after the dismissal of the keyboard.
  public class var keyboardDidHideNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIResponderKeyboardDidHideNotification")
  }

  /// Posted immediately after the display of the keyboard.
  public class var keyboardDidShowNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIRespnderKeyboardDidShowNotification")
  }

  /// Posted immediately prior to a change in the keyboard’s frame.
  public class var keyboardWillChangeFrameNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIReponderKeyboardWillChnageFrameNotification")
  }

  /// Posted immediately prior to the dismissal of the keyboard.
  public class var keyboardWillHideNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIResponderKeyboardWillHideNotification")
  }

  /// Posted immediately prior to the display of the keyboard.
  public class var keyboardWillShowNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIResponderKeyboardWillShowNotification")
  }
}
