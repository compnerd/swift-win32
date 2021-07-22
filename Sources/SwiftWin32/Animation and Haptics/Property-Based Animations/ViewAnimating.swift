// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import struct Foundation.TimeInterval

/// Constants indicating positions within the animation.
public enum ViewAnimatingPosition: Int {
  /// The end point of the animation. Use this constant when you want the final
  /// values for any animatable properties — that is, you want to refer to the
  /// values you specified in your animation blocks.
  case end

  /// The beginning of the animation. Use this constant when you want the
  /// starting values for any animatable properties—that is, the values of the
  /// properties before you applied any animations.
  case start

  /// The current position. Use this constant when you want the most recent
  /// value set by an animator object.
  case current
}

/// Constants indicating the current state of the animation.
public enum ViewAnimatingState: Int {
  /// The animations have not yet started executing. This is the initial state
  /// of the animator object.
  case inactive

  /// The animator object is active and animations are either running or paused.
  /// An animator moves to this state after the first call to `startAnimation()`
  /// or `pauseAnimation()`. It stays in the active state until the animations
  /// finish naturally or until you call the `stopAnimation(_:)` method.
  case active

  /// The animation is stopped. Putting an animation into this state ends the
  /// animation and leaves any animatable properties at their current values,
  /// instead of updating them to their intended final values. An animation
  /// cannot be started while in this state.
  case stopped
}

/// An interface for implementing custom animator objects.
public protocol ViewAnimating {
  // MARK - Starting and Stopping the Animations

  /// Starts the animation from its current position.
  func startAnimation()

  /// Starts the animation after the specified delay.
  func startAnimation(afterDelay delay: TimeInterval)

  /// Pauses a running animation at its current position.
  func pauseAnimation()

  /// Stops the animations at their current positions.
  func stopAnimation(_ withoutFinishing: Bool)

  /// Finishes the animations and returns the animator to the inactive state.
  func finishAnimation(at finalPositiong: ViewAnimatingPosition)

  // MARK - Getting the Animator's State

  /// The completion percentage of the animation.
  var fractionComplete: Double { get set }

  /// A boolean value indicating whether the animation is running in the reverse
  /// direction.
  var isReversed: Bool { get set }

  /// The current state of the animation.
  var state: ViewAnimatingState { get }

  /// A boolean value indicating whether the animation is currently running.
  var isRunning: Bool { get }
}
