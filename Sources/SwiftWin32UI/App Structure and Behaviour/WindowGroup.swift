// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A scene that presents a group of identically structured windows.
public struct WindowGroup<Content: View>: Scene {
  public var body: some Scene {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Creating a Window Group

  /// Creates a window group.
  public init(@ViewBuilder content: () -> Content) {
  }
}
