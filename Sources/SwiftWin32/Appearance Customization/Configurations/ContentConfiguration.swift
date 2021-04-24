// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// The requirements for an object that provides the configuration for a content
/// view.
public protocol ContentConfiguration {
  // MARK - Creating a Content Configuration

  /// Creates a new instance of the content view using this configuration.
  func makeContentView() -> View & ContentView

  // MARK - Updating a Content Configuration

  /// Generates a configuration for the specified state by applying the
  /// configuration's default values for that state to any properties that you
  /// haven't customized.
  func updated(for state: ConfigurationState) -> Self
}
