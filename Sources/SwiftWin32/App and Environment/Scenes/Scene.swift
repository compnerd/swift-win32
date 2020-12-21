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

  /// Creates a scene object using the specified session and connection
  /// information.
  public required init(session: SceneSession,
                       connectionOptions: Scene.ConnectionOptions) {
    self.session = session
  }

  /// Managing the Life Cycle of a Scene

  /// The object you use to recieve life-cycle events associated with the scene.
  public var delegate: SceneDelegate?

  /// Getting the Scene's Session

  /// The session associated with the scene.
  public let session: SceneSession
}

extension Scene {
  /// A notification indicating that a scene was added to the application.
  public class var willConnectNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UISceneWillConnectNotification")
  }

  /// A notification indicating that a scene was removed from the application.
  public class var didDisconnectNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UISceneDidDisconnectNotification")
  }

  /// A notification indicating that a scene is about to begin running in the
  /// foreground and become visible to the user.
  public class var willEnterForegroundNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UISceneWillEnterForegroundNotification")
  }

  /// A notification indicating that the scene is now onscreen and reponding to
  /// user events.
  public class var didActivateNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UISceneDidActivateNotification")
  }

  /// A notification indicating that the scene is about to resign the active
  /// state and stop responding to user events.
  public class var willDeactivateNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UISceneWillDeactivateNotification")
  }

  /// A notification indicating that the scene is running in the background and
  /// is no longer onscreen.
  public class var didEnterBackgroundNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UISceneDidEnterBackgroundNotification")
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
