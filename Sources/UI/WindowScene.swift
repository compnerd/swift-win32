/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

public class WindowScene: Scene {
  /// Getting the Interface Attributes
  public private(set) var sizeRestrictions: SceneSizeRestrictions?

  public required init(session: SceneSession,
                       connectionOptions: Scene.ConnectionOptions) {
    // TODO(compnerd) we really should base this on the device properties.
    // Windows Phone should have set the sizeRestrictions to nil.  Similarly,
    // Surface Neo and Surface Duo Devices will not permit the window resizing.
    self.sizeRestrictions = SceneSizeRestrictions()
    super.init(session: session, connectionOptions: connectionOptions)
  }
}
