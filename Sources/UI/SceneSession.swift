/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import struct Foundation.UUID

extension SceneSession {
  public struct Role: Equatable, Hashable, RawRepresentable {
    public typealias RawValue = String

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SceneSession.Role {
  /// The scene displays noninteractive windows on an externally connected
  /// screen.
  public static let windowApplication: SceneSession.Role =
      SceneSession.Role(rawValue: "UIWindowSSceneSessionRoleApplication")

  /// The scene displays interactive content on the device's main screen.
  public static let windowExternalDisplay: SceneSession.Role =
      SceneSession.Role(rawValue: "UIWindowSceneSessionRoleExternalDisplay")
}

public class SceneSession {
  /// Getting the Scene Information

  /// The scene associated with the current session.
  public let scene: Scene?

  /// The role played by the scene's content.
  public let role: SceneSession.Role

  /// Getting the Scene Configuration Details

  /// The configuration data for creating the secene.
  public var configuration: SceneConfiguration

  /// Identifying the Scene

  /// A unique identifier that persists for the lifetime of the session
  public let persistentIdentifier: String

  internal init(scene: Scene?, role: SceneSession.Role,
                configuration: SceneConfiguration) {
    self.scene = scene
    self.role = role
    self.configuration = configuration
    self.persistentIdentifier = UUID().uuidString
  }
}

extension SceneSession: Hashable {
  public static func == (lhs: SceneSession, rhs: SceneSession) -> Bool {
    return lhs.persistentIdentifier == rhs.persistentIdentifier
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(self.persistentIdentifier)
  }
}
