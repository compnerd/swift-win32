/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

public protocol SceneDelegate: _TriviallyConstructible {
  // MARK - Connecting and Disconnecting the Scene

  /// Tells the delegate about the addition of a scene to the application.
  func scene(_ scene: Scene, willConnectTo: SceneSession,
             options: Scene.ConnectionOptions)

  /// Tells the delegate that a scene was removed from the application.
  func sceneDidDisconnect(_ scene: Scene)

  // MARK - Transitioning to the Foreground

  /// Tells the delegate that the scene is about to begin running in the
  /// foreground and become visible to the user.
  func sceneWillEnterForeground(_ scene: Scene)

  /// Tells the delegate that the scene became active and is now responding to
  /// user events.
  func sceneDidBecomeActive(_ scene: Scene)

  // MARK - Transitioning to the Background

  /// Tells the delegate that the scene is about to resign the active state and
  /// stop responding to user events.
  func sceneWillResignActive(_ scene: Scene)

  /// Tells the delegate that the scene is running in the background and is no
  /// longer onscreen.
  func sceneDidEnterBackground(_ scene: Scene)
}

extension SceneDelegate {
  public func scene(_ scene: Scene, willConnectTo: SceneSession,
                    options: Scene.ConnectionOptions) {
  }

  public func sceneDidDisconnect(_ scene: Scene) {
  }
}

extension SceneDelegate {
  public func sceneWillEnterForeground(_ scene: Scene) {
  }

  public func sceneDidBecomeActive(_ scene: Scene) {
  }
}

extension SceneDelegate {
  public func sceneWillResignActive(_ scene: Scene) {
  }

  public func sceneDidEnterBackground(_ scene: Scene) {
  }
}
