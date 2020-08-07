/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
