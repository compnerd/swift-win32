// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import struct Foundation.TimeInterval

/// The keys you use to identify the view controllers involved in a transition.
public struct TransitionContextViewControllerKey: Equatable, Hashable, RawRepresentable {
  public typealias RawValue = String

  public let rawValue: RawValue

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
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

/// Modal presentation styles available when presenting view controllers.
public enum ModalPresentationStyle: Int {
  /// The default presentation style chosen by the system.
  case automatic

  /// A presentation style that indicates no adaptations should be made.
  case none

  /// A presentation style in which the presented view covers the screen.
  case fullScreen

  /// A presentation style that partially covers the underlying content.
  case pageSheet

  /// A presentation style that displays the content centered in the screen.
  case formSheet

  /// A presentation style where the content is displayed over another view
  /// controller's content.
  case currentContext

  /// A custom view presentation style that is managed by a custom presentation
  /// controller and one or more custom animator objects.
  case custom

  /// A view presentation style in which the presented view covers the screen.
  case overFullScreen

  /// A presentation style where the content is displayed over another view
  /// controller's content.
  case overCurrentContext

  /// A presentation style where the content is displayed in a popover view.
  case popover

  /// A presentation style that blurs the underlying content before displaying new
  /// content in a full-screen presentation.
  case blurOverFullScreen
}

/// A set of methods that provides information about an in-progress view
/// controller transition.
public protocol ViewControllerTransitionCoordinatorContext {
  // MARK - Getting the Views and the View Controllers

  /// Returns the view controllers involved in the transition.
  func viewController(forKey key: TransitionContextViewControllerKey)
    -> ViewController?

  /// Returns the specified view involved in the transition.
  func view(forKey key: TransitionContextViewKey) -> View?

  /// Returns the view in which the transition takes place.
  var containerView: View { get }

  // MARK - Getting the Behaviour Attributes

  /// Returns the presentation style being used for the transition.
  var presentationStyle: ModalPresentationStyle { get }

  /// Returns the noninteractive duration of a transition.
  var transitionDuration: TimeInterval { get }

  /// Returns the completion curve associated with the transition.
  var completionCurve: AnimationCurve { get }

  /// Returns the starting velocity to use for any final animations.
  var completionVelocity: Double { get }

  /// Returns the percentage of completion for an interactive transition when it
  /// moves to its noninteractive phase.
  var percentComplete: Double { get }

  // MARK - Getting the Transition State

  /// A Boolean value indicating whether the transition started as an
  /// interactive transition.
  var initiallyInteractive: Bool { get }

  /// A Boolean value indicating whether the transition is currently interactive.
  var isInteractive: Bool { get }

  /// A Boolean value indicating whether the transition is explicitly animated.
  var isAnimated: Bool { get }

  /// A Boolean value indicating whether an interactive transition was cancelled.
  var isCancelled: Bool { get }

  /// A Boolean value indicating whether the transition animations can be
  /// interrupted.
  var isInterruptible: Bool { get }

  // MARK - Getting the Rotation Factor

  /// Returns a transform indicating the amount of rotation being applied during
  /// the transition.
  var targetTransform: AffineTransform { get }
}
