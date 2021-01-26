/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import SwiftWin32

/// A type that represents the structure and behaviour of an application.
public protocol Application {
  // MARK - Implementing an Application

  /// The type of scene representing the content of the application.
  associatedtype Body: Scene

  /// The content and behaviour of the application.
  @SceneBuilder
  var body: Self.Body { get }

  // MARK - Running an Application

  /// Creates an instance of the application using the body as the content.
  init()
}

extension Application {
  /// Initializes and runs the application.
  public static func main() {
    ApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil)
  }
}
