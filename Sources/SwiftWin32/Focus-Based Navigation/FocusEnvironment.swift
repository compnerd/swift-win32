/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// An identifier for a focus-related sound.
public struct FocusSoundIdentifier: Equatable, Hashable, RawRepresentable {
  public typealias RawValue = String

  public let rawValue: RawValue

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }
}

extension FocusSoundIdentifier {
  public init(_ rawValue: String) {
    self.rawValue = rawValue
  }
}

extension FocusSoundIdentifier {
  /// The identifier for the default system sound to play during focus updates.
  public static var `default`: FocusSoundIdentifier {
    FocusSoundIdentifier(rawValue: "UIFocusSoundIdentifierDefault")
  }

  /// The identifier for disabling sound during a focus update.
  public static var none: FocusSoundIdentifier {
    FocusSoundIdentifier(rawValue: "UIFocusSoundIdentifierNone")
  }
}

/// A set of methods that define the focus behavior for a branch of the view
/// hierarchy.
public protocol FocusEnvironment: AnyObject {
  // MARK - Requesting Focus Update

  /// Submits a request to the focus engine for a focus update in this
  /// environment.
  func setNeedsFocusUpdate()

  /// Tells the focus engine to force a focus update immediately.
  func updateFocusIfNeeded()

  // MARK - Validating Focus Movements

  /// Returns a boolean value indicating whether the focus engine should allow
  /// the focus update described by the specified context to occur.
  func shouldUpdateFocus(in context: FocusUpdateContext) -> Bool

  // MARK - Responding to Focus Updates

  /// Called immediately after the system updates the focus to a new view.
  func didUpdateFocus(in context: FocusUpdateContext,
                      with coordinator: FocusAnimationCoordinator)

  // MARK - Controlling User Generated Focus Movements

  /// An array of focus environments, ordered by priority, to which this
  /// environment prefers focus to be directed during a focus update.
  var preferredFocusEnvironments: [FocusEnvironment] { get }

  // MARK - Getting the Sound to Play During Updates

  /// Asks the delegate for the identifier of the sound to play when the object
  /// gains focus.
  func soundIdentifierForFocusUpdate(in context: FocusUpdateContext)
      -> FocusSoundIdentifier?

  // MARK - Checking the Ancestry of the Environment

  /// Returns a boolean value indicating whether the focus environment contains
  /// the specified environment.
  func contains(_ environment: FocusEnvironment) -> Bool

  /// The parent focus environment for this environment.
  /* weak */ var parentFocusEnvironment: FocusEnvironment? { get }

  /// The container for the child focus items in this focus environment.
  var focusItemContainer: FocusItemContainer? { get }

  // MARK -

  var focusGroupIdentifier: String? { get }
}

extension FocusEnvironment {
  public func soundIdentifierForFocusUpdate(in context: FocusUpdateContext)
      -> FocusSoundIdentifier? {
    return nil
  }
}

extension FocusEnvironment {
  public var focusGroupIdentifier: String? { nil }
}
