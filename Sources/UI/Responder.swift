/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

public class Responder {
  /// Managing the Responder Chain

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
}
