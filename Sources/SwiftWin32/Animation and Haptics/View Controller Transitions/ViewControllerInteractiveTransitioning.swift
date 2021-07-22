// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A set of methods that enable an object (such as a navigation controller) to
/// drive a view controller transition.
public protocol ViewControllerInteractiveTransitioning {
  // MARK - Starting an Interactive Transition

  /// Called when the system needs to set up the interactive portions of a view
  /// controller transition and start the animations.
  func startInteractiveTransition(_ transitionContext: ViewControllerContextTransitioning)

  /// A boolean value indicating whether the transition is interactive when it
  /// starts.
  ///
  /// The value of this property is `true` when the transition is interactive
  /// from the moment it starts. The property is `false` when the transition
  /// starts off as noninteractive. However, even a transition that starts off
  /// as noninteractive may become interactive later if it implements the
  /// `interruptibleAnimator(using:)` method of the
  /// `ViewControllerAnimatedTransitioning` protocol.
  var wantsInteractiveStart: Bool { get }

  // MARK - Providing a Transition's Completion Characteristics

  /// Called when the system needs the animation completion curve for an
  /// interactive view controller transition.
  var completionCurve: View.AnimationCurve { get }

  /// Called when the system needs the speed at which to complete an interactive
  /// transition, after the interactive portion is finished.
  var completionSpeed: Double { get }
}

extension ViewControllerInteractiveTransitioning {
  public var wantsInteractiveStart: Bool { true }
}

extension ViewControllerInteractiveTransitioning {
  public var completionCurve: View.AnimationCurve { .easeInOut }

  public var completionSpeed: Double { 1.0 }
}
