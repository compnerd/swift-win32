// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

public class WindowScene: Scene {
  public required init(session: SceneSession,
                       connectionOptions: Scene.ConnectionOptions) {
    // TODO(compnerd) we really should base this on the device properties.
    // Windows Phone should have set the sizeRestrictions to nil.  Similarly,
    // Surface Neo and Surface Duo Devices will not permit the window resizing.
    self.sizeRestrictions = SceneSizeRestrictions()

    // FIXME(compnerd) how do you attach a different screen to the window scene?
    self.screen = Screen.main

    super.init(session: session, connectionOptions: connectionOptions)
  }

  /// Getting the Active Windows

  /// The windows associated with the scene.
  public internal(set) var windows: [Window] = []

  /// The screen that displays the content of the scene.
  public private(set) var screen: Screen

  /// Getting the Interface Attributes

  /// The minimum and maximum size of the application's windows.
  public private(set) var sizeRestrictions: SceneSizeRestrictions?
}
