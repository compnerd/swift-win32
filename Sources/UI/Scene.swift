/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK
import class Foundation.NSNotification

extension Scene {
  public class ConnectionOptions {
  }
}

public class Scene: Responder {
  /// Creating a Scene Object

  public init(session: SceneSession, connectionOptions: Scene.ConnectionOptions) {
  }

  /// Managing the Life Cycle of a Scene

  /// The object you use to recieve life-cycle events associated with the scene.
  public var delegate: SceneDelegate?
}

extension Scene {
  public class var didDisconnectNotification: NSNotification.Name {
    return NSNotification.Name(rawValue: "UISceneDidDisconnectNotification")
  }
}

extension Scene: Hashable {
  public static func == (lhs: Scene, rhs: Scene) -> Bool {
    // TODO(compnerd) figure out the proper equality check for Scene
    return lhs === rhs
  }

  public func hash(into hasher: inout Hasher) {
    // TODO(compnerd) figure out the proper hashing for Scene
  }
}
