/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import SwiftWin32
import Foundation

@main
final class CustomPrincipalClass: ApplicationDelegate {
  var window: Window!
}

extension CustomPrincipalClass: SceneDelegate {
  func scene(_ scene: Scene, willConnectTo session: SceneSession,
             options: Scene.ConnectionOptions) {

    guard let windowScene = scene as? WindowScene else { return }

    self.window = Window(windowScene: windowScene)

    self.window.rootViewController = ViewController()
    self.window.rootViewController?.title = "Custom NSPrincipalClass"

    if let application = Application.shared as? MyApplication {
      let label = Label(frame: Rect(x: 10.0, y: 100.0, width: 400.0, height: 70.0))
      label.text = application.message
      self.window.addSubview(label)
    }
    self.window.makeKeyAndVisible()
  }
}
