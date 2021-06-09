// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import class Foundation.NSNotification

open class Responder {
  // MARK - Managing the Responder Chain

  /// Returns the next responder in the responder chain, or `nil` if there is no
  /// next responder.
  public var next: Responder? { nil }

  /// Indicates whether this object is the first responder.
  public var isFirstResponder: Bool { return self.next === self }

  /// Indiciates whether ths object can become the first responder.
  public var canBecomeFirstResponder: Bool { false }

  /// Indicates whether this object is willing to relinquish first-responder
  /// status.
  public var canResignFirstResponder: Bool { true }

  /// Results to make this object the first responder in its window.
  public func becomeFirstResponder() -> Bool {
    guard !self.isFirstResponder else { return true }
    guard self.canBecomeFirstResponder else { return false }
    return true
  }

  /// Notifies the object that it has been asked to relinquish its status as
  /// first responder in its window.
  public func resignFirstResponder() -> Bool {
    return true
  }

  // MARK - Responding to Touch Events

  /// Informs the responder that one or more new touches occurrd in a view or a
  /// window.
  public func touchesBegan(_ touches: Set<Touch>, with event: Event?) {
  }

  /// Informs the responder when one or more touches associated with an event
  /// changed.
  public func touchesMoved(_ touches: Set<Touch>, with event: Event?) {
  }

  /// Informs the responder when one or more fingers are raised from a view or a
  /// window.
  public func touchesEnded(_ touches: Set<Touch>, with event: Event?) {
  }

  /// Informs the responder when a system event (such as a system alert) cancels
  /// a touch sequence.
  public func touchesCancelled(_ touches: Set<Touch>, with event: Event?) {
  }

  /// Tells the responder that updated values were received for previously
  /// estimated properties or that an update is no longer expected.
  public func touchesEstimatedPropertiesUpdated(_ touches: Set<Touch>) {
  }

  // MARK - Constants

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
