/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// A key that defines a custom state for a view.
public struct ConfigurationStateCustomKey: Equatable, Hashable, RawRepresentable {
  public typealias RawValue = String

  public let rawValue: RawValue

  public init(rawValue: String) {
    self.rawValue = rawValue
  }
}

extension ConfigurationStateCustomKey {
  public init(_ rawValue: String) {
    self.rawValue = rawValue
  }
}

/// The requirements for an object that encapsulate a view's state.
public protocol ConfigurationState {
  // MARK - Managing Configuration States

  /// The traits that describe the current layout environment of the view, such
  /// as the user interface style and layout direction.
  var traitCollection: TraitCollection { get set }

  /// Accesses custom states by key.
  subscript(key: ConfigurationStateCustomKey) -> AnyHashable? { get set }

  // MARK - Creating a Configuration State Manually

  /// Creates a View configuration state with the specified trait collection.
  init(traitCollection: TraitCollection)
}
