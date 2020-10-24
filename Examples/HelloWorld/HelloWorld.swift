/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import SwiftWin32

@main
final class HelloWorld: ApplicationDelegate {
  var window: Window?
}

extension HelloWorld: SceneDelegate {
  func scene(_ scene: Scene, willConnectTo session: SceneSession,
             options: Scene.ConnectionOptions) {
    guard let windowScene = scene as? WindowScene else { return }

    self.window = Window(windowScene: windowScene)
    self.window?.makeKeyAndVisible()
  }
}
