/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

public protocol SceneDelegate: _TriviallyConstructible {
  /// Connecting and Disconnecting the Scene

  /// Tells the delegate about the addition of a scene to the application.
  func scene(_ scene: Scene, willConnecTo: SceneSession,
             options: Scene.ConnectionOptions)

  /// Tells the delegate that a scene was removed from the application.
  func sceneDidDisconnect(_ scene: Scene)
}

extension SceneDelegate {
  public func scene(_ scene: Scene, willConnectTo: SceneSession,
                    options: Scene.ConnectionOptions) {
  }

  public func sceneDidDisconnect(_ scene: Scene) {
  }
}
