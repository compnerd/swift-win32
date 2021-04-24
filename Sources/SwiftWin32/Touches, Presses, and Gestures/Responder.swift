// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

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
}
