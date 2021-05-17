// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import SwiftWin32

@main
final class HelloWorld: ApplicationDelegate {
  var window: Window!
}

extension HelloWorld: SceneDelegate {
  func scene(_ scene: Scene, willConnectTo session: SceneSession,
             options: Scene.ConnectionOptions) {
    guard let windowScene = scene as? WindowScene else { return }

    self.window = Window(windowScene: windowScene)

    // The rootViewController allows to set a title and add controls
    self.window.rootViewController = ViewController()

    // Add a title
    self.window.rootViewController?.title = "swift-win32 Hello World"

    // Add a hello world label
    let label = Label(frame: Rect(x: 50.0, y: 100.0, width: 300.0, height: 30.0))
    label.text = "Hello World"
    label.addTarget(self, action: HelloWorld.onLabelPress(_:_:),
                              for: .primaryActionTriggered)
    self.window.addSubview(label)

    // Show the window
    self.window.makeKeyAndVisible()
  }

  private func onLabelPress(_ sender: Label, _: Control.Event) {
    print("hello world");
  }
}
