// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// The keys you use to identify the view controllers involved in a transition.
public struct TransitionContextViewControllerKey: Equatable, Hashable, RawRepresentable {
  public typealias RawValue = String

  public let rawValue: RawValue

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }
}

extension TransitionContextViewControllerKey {
  /// A key that identifies the view controller that is visible at the beginning
  /// of the transition, or at the end of a canceled transition.
  public static var from: TransitionContextViewControllerKey {
    TransitionContextViewControllerKey(rawValue: "UITransitionContextFromViewController")
  }

  /// A key that identifies the view controller that is visible at the end of a
  /// completed transition.
  public static var to: TransitionContextViewControllerKey {
    TransitionContextViewControllerKey(rawValue: "UITransitionContextToViewController")
  }
}

/// The keys you use to identify the views involved in a transition.
public struct TransitionContextViewKey: Equatable, Hashable, RawRepresentable {
  public typealias RawValue = String

  public let rawValue: RawValue

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }
}

extension TransitionContextViewKey {
  /// A key that identifies the view shown at the beginning of the transition,
  /// or at the end of a canceled transition.
  public static var from: TransitionContextViewKey {
    TransitionContextViewKey(rawValue: "UITransitionContextFromView")
  }

  /// A key that identifies the view shown at the end of a completed transition.
  public static var to: TransitionContextViewKey {
    TransitionContextViewKey(rawValue: "UITransitionContextToView")
  }
}

/// A set of methods that provide contextual information for transition
/// animations between view controllers.
public protocol ViewControllerContextTransitioning {
  // MARK - Accessing the Transition Objects

  /// The view that acts as the superview for the views involved in the
  /// transition.
  var containerView: View { get }

  /// Returns a view controller involved in the transition.
  func viewController(forKey key: TransitionContextViewControllerKey)
      -> ViewController?

  /// Returns the specified view involved in the transition.
  func view(forKey key: TransitionContextViewKey) -> View?

  // MARK - Getting the Transition Frame Rectangles

  /// Returns the starting frame rectangle for the specified view controller's
  /// view.
  func initialFrame(for viewController: ViewController) -> Rect

  /// Returns the ending frame rectangle for the specified view controller's
  /// view.
  func finalFrame(for viewController: ViewController) -> Rect

  // MARK - Getting the Transition Behaviors

  /// A boolean value indicating whether the transition should be animated.
  var isAnimated: Bool { get }

  /// A boolean value indicating whether the transition is currently
  /// interactive.
  var isInteractive: Bool { get }

  /// Returns the presentation style for the view controller transition.
  var presentationStyle: ModalPresentationStyle { get }

  // MARK - Reporting the Transition Progress

  /// Notifies the system that the transition animation is done.
  func completeTransition(_ didComplete: Bool)

  /// Updates the completion percentage of the transition.
  func updateInteractiveTransition(_ percentComplete: Double)

  /// Tells the system to pause the animations.
  func pauseInteractiveTransition()

  /// Notifies the system that user interactions signaled the completion of the
  /// transition.
  func finishInteractiveTransition()

  /// Notifies the system that user interactions canceled the transition.
  func cancelInteractiveTransition()

  /// Returns a boolean value indicating whether the transition was canceled.
  var transitionWasCancelled: Bool { get }

  // MARK - Getting the Rotation Factor

  /// Returns a transform indicating the amount of rotation being applied during
  /// the transition.
  var targetTransform: AffineTransform { get }
}
