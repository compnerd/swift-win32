/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

public class SceneConfiguration {
  /// Creates a scene-configuration object with the specified role and
  /// application-specific name.
  public init(name: String?, sessionRole: SceneSession.Role) {
    self.name = name
    self.role = sessionRole
  }

  /// Getting the Configuration Attributes

  /// The application-specific name assigned to the scene configuration.
  public let name: String?

  /// The role assigned to the scene configuration.
  public let role: SceneSession.Role
}

extension SceneConfiguration: Hashable {
  public static func == (lhs: SceneConfiguration, rhs: SceneConfiguration)
      -> Bool {
    return lhs.name == rhs.name && lhs.role == rhs.role
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(self.name)
    hasher.combine(self.role)
  }
}
