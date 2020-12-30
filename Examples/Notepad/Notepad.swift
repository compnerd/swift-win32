/**
 * Copyright © 2020 Puyan Lotfi <puyan AT puyan DOT org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import SwiftWin32

@main
final class Notepad: ApplicationDelegate {
  var window: Window?
  lazy var textview: TextView =
    TextView(frame: Rect(x: 10.0, y: 10.0, width: 750.0, height: 750.0))
}

extension Notepad: SceneDelegate {
  func scene(
    _ scene: Scene, willConnectTo session: SceneSession,
    options: Scene.ConnectionOptions
  ) {
    guard let windowScene = scene as? WindowScene else { return }

    self.window = Window(windowScene: windowScene)
    self.window?.makeKeyAndVisible()
    self.window?.addSubview(self.textview)

    self.textview.text = """
      He piled upon the whale’s white hump the sum of all the general rage and
      hate felt by his whole race from Adam down; and then, as if his chest had 
      been a mortar, he burst his hot heart’s shell upon it.
      """

    self.window?.makeKeyAndVisible()
  }
}
