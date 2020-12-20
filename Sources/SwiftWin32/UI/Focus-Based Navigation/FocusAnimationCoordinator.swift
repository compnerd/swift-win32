/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import struct Foundation.TimeInterval

/// Information about focusing animations being performed by the system.
public protocol FocusAnimationContext {
  // MARK - Getting the Animation Attributes

  /// The duration (measured in seconds) of the focus animation.
  var duration: TimeInterval { get }
}

/// A coordinator of focus-related animations during a focus update.
public class FocusAnimationCoordinator {
  // MARK - Adding Animations to Focus Updates

  /// Runs the specified set of animations together with the system animations
  /// for adding focus to an item.
  public func addCoordinatedFocusingAnimations(_ animations: ((FocusAnimationContext) -> Void)?,
                                               completion: (() -> Void)? = nil) {
  }

  /// Runs the specified set of animations together with the system animations
  /// for removing focus from an item.
  public func addCoordinatedUnfocusingAnimations(_ animations: ((FocusAnimationContext) -> Void)?,
                                                 completion: (() -> Void)? = nil) {
  }

  /// Specifies the animations to coordinate with the active focus animation.
  public func addCoordinatedAnimations(_ animations: (() -> Void)?,
                                       completion: (() -> Void)? = nil) {
  }
}
