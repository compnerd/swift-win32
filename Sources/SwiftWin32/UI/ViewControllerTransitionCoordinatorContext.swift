/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import struct Foundation.TimeInterval

public struct TransitionContextViewControllerKey: Equatable, Hashable, RawRepresentable {
  public typealias RawValue = String

  public let rawValue: RawValue

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }
}

public struct TransitionContextViewKey: Equatable, Hashable, RawRepresentable {
  public typealias RawValue = String

  public let rawValue: RawValue

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }
}

extension TransitionContextViewControllerKey {
  public static let from: TransitionContextViewControllerKey =
      TransitionContextViewControllerKey(rawValue: "UITransitionContextFromViewController")
  public static let to: TransitionContextViewControllerKey =
      TransitionContextViewControllerKey(rawValue: "UITransitionContextToViewController")
}

extension TransitionContextViewKey {
  public static let from: TransitionContextViewKey =
      TransitionContextViewKey(rawValue: "UITransitionContextFromView")
  public static let to: TransitionContextViewKey =
      TransitionContextViewKey(rawValue: "UITransitionContextToView")
}

public enum ModalPresentationStyle: Int {
case automatic
case none
case fullScreen
case pageSheet
case formSheet
case currentContext
case custom
case overFullScreen
case overCurrentContext
case popover
case blurOverFullScreen
}

public protocol ViewControllerTransitionCoordinatorContext {
  /// Getting the Views and the View Controllers
  var containerView: View { get }

  func viewController(forKey key: TransitionContextViewControllerKey)
      -> ViewController?
  func view(forKey key: TransitionContextViewKey) -> View?

  /// Getting the Behaviour Attributes
  var presentationStyle: ModalPresentationStyle { get }
  var transitionDuration: TimeInterval { get }
  var completionCurve: AnimationCurve { get }
  var completionVelocity: Double { get }
  var percentComplete: Double { get }

  /// Getting the Transition State
  var initiallyInteractive: Bool { get }
  var isInteractive: Bool { get }
  var isAnimated: Bool { get }
  var isCancelled: Bool { get }
  var isInterruptible: Bool { get }

  /// Getting the Rotation Factor
  var targetTransform: AffineTransform { get }
}
