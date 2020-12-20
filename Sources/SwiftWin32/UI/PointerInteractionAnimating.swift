/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// An interface for modifying an interaction animation in coordination with the
/// pointer effect animations.
public protocol PointerInteractionAnimating {
  // MARK - Managing Animations

  /// Adds the specified animation block to the animator.
  func addAnimations(_ animations: @escaping () -> Void)

  /// Adds the specified completion block to the animator.
  func addCompletion(_ completion: @escaping (Bool) -> Void)
}
