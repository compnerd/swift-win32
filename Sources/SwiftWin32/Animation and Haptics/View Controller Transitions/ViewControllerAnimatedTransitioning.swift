// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import struct Foundation.TimeInterval

/// A set of methods for implementing the animations for a custom view controller
/// transition.
public protocol ViewControllerAnimatedTransitioning {
  // MARK - Performing a Transition

  /// Tells your animator object to perform the transition animations.
  func animateTransition(using transitionContext: ViewControllerContextTransitioning)

  /// Tells your animator object that the transition animations have finished.
  func animationEnded(_ transitionCompleted: Bool)

  // MARK - Reporting Transition Duration

  /// Asks your animator object for the duration (in seconds) of the transition
  /// animation.
  func transitionDuration(using transitionContext: ViewControllerContextTransitioning?)
      -> TimeInterval

  // MARK - Returning an Interruptible Animator

  /// Returns the interruptible animator to use during the transition.
  func interruptibleAnimator(using transitionContext: ViewControllerContextTransitioning)
      -> ViewImplicitlyAnimating
}

extension ViewControllerAnimatedTransitioning {
  public func animationEnded(_ transitionCompleted: Bool) {
  }
}

extension ViewControllerAnimatedTransitioning {
  func interruptibleAnimator(using transitionContext: ViewControllerContextTransitioning)
      -> ViewImplicitlyAnimating {
    fatalError("\(#function) not yet implemented")
  }
}
