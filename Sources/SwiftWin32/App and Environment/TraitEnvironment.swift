// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A set of methods that makes the interface environment available to your
/// application.
public protocol TraitEnvironment {
  // MARK - Accessing a Trait Collection

  /// The traits, such as the size class and scale factor, that describe the
  /// current environment of the object.
  var traitCollection: TraitCollection { get }

  // MARK - Responding to a Change in the Interface Environment

  /// Called when the interface environment changes.
  func traitCollectionDidChange(_ previousTraitCollection: TraitCollection?)
}
