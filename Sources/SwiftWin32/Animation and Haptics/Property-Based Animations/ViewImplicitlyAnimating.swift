// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// An interface for modifying an animation while it is running.
public protocol ViewImplicitlyAnimating: ViewAnimating {
  // MARK - Modifying Animations

  /// Adds the specified animation block to the animator.
  func addAnimations(_ animation: @escaping () -> Void)

  /// Adds the specified animation block to the animator with a delay.
  func addAnimations(_ animation: @escaping () -> Void, delayFactor: Double)

  /// Adds the specified completion block to the animator.
  func addCompletion(_ completion: @escaping (ViewAnimatingPosition) -> Void)

  /// Adjusts the final timing and duration of a paused animation.
  func continueAnimation(withTimingParameters paramters: TimingCurveProvider?,
                         durationFactor: Double)
}

extension ViewImplicitlyAnimating {
  public func addAnimations(_ animation: @escaping () -> Void) {
    self.addAnimations(animation, delayFactor: 0.0)
  }

  public func addAnimations(_ animation: @escaping () -> Void,
                            delayFactor: Double) {
  }

  public func addCompletion(_ completion: @escaping (ViewAnimatingPosition) -> Void) {
  }

  public func continueAnimation(withTimingParameters paramters: TimingCurveProvider?,
                                durationFactor: Double) {
  }
}
