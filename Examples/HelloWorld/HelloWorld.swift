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

    let window = Window(windowScene: windowScene)
    self.window = window

    // The rootViewController allows to set a title and add controls
    window.rootViewController = ViewController()

    // Add a title
    window.rootViewController?.title = "swift-win32 Hello World"

    // Add a hello world label
    let label = Label(frame: Rect(x: 50.0, y: 100.0, width: 300.0, height: 30.0))
    label.text = "Hello World"
    window.addSubview(label)

    // Show the window
    window.makeKeyAndVisible()
  }
}
