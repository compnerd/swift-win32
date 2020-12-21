/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

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
  public static var windowApplication: SceneSession.Role {
    SceneSession.Role(rawValue: "UIWindowSceneSessionRoleApplication")
  }

  /// The scene displays interactive content on the device's main screen.
  public static var windowExternalDisplay: SceneSession.Role {
    SceneSession.Role(rawValue: "UIWindowSceneSessionRoleExternalDisplay")
  }
}

public class SceneSession {
  /// Getting the Scene Information

  /// The scene associated with the current session.
  public internal(set) weak var scene: Scene?

  /// The role played by the scene's content.
  public let role: SceneSession.Role

  /// Getting the Scene Configuration Details

  /// The configuration data for creating the secene.
  // This is mutable as the configuration is only finalized after the deleate
  // has formed the final configuration.
  public internal(set) var configuration: SceneConfiguration

  /// Identifying the Scene

  /// A unique identifier that persists for the lifetime of the session
  public let persistentIdentifier: String

  internal init(identifier: String, role: SceneSession.Role,
                configuration name: String? = nil) {
    self.persistentIdentifier = identifier
    self.role = role
    self.configuration = SceneConfiguration(name: name, sessionRole: role)
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
