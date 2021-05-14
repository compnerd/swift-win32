// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A part of the application's user interface.
public protocol Scene {
  // MARK - Creating a Scene

  /// The type of scene representing the body of this scene.
  associatedtype Body: Scene

  /// The content and behaviour of the scene.
  @SceneBuilder
  var body: Self.Body { get }
}
