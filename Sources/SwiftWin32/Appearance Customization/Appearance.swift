// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A collection of methods that gives you access to the appearance proxy for a
/// class.
public protocol Appearance {
  // MARK - Appearance Methods

  /// Returns the appearance proxy for the receiver.
  static func appearance() -> Self

  /// Returns the appearance proxy for the receiver that has the passed trait
  /// collection.
  static func appearance(for trait: TraitCollection) -> Self

  /// Returns the appearance proxy for the object when it is contained in the
  /// hierarchy the specified classes describe.
  static func appearance(whenContainedInInstancesOf containerTypes: [AppearanceContainer.Type])
      -> Self

  /// Returns the appearance proxy for the object when it is contained in the
  /// hierarchy the specified classes describe and has the specified trait
  /// collection.
  static func appearance(for trait: TraitCollection,
                         whenContainedInInstancesOf containerTypes: [AppearanceContainer.Type]) -> Self
}
