/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import SwiftWin32
import let WinSDK.CW_USEDEFAULT

@main
final class AppDelegate: ApplicationDelegate {
  var window: Window?

  func application(_ application: Application,
                   didFinishLaunchingWithOptions launchOptions: [Application.LaunchOptionsKey:Any]?) -> Bool {
    self.window =
        Window(frame: Rect(x: Double(CW_USEDEFAULT), y: Double(CW_USEDEFAULT),
               width: 640, height: 480))
    self.window?.makeKeyAndVisible()
    return true
  }
}
