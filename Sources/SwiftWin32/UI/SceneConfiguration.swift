/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import func Foundation.NSClassFromString

public class SceneConfiguration {
  /// Creating a Configuration Object

  /// Creates a scene-configuration object with the specified role and
  /// application-specific name.
  public init(name: String?, sessionRole: SceneSession.Role) {
    self.name = name
    self.role = sessionRole

    // Try to load the configuration from the Info.plist ...

    // ... which requires that we have an Info.plist
    guard let info = Application.shared.information else {
      return
    }

    // ... which requires that the Info.plist contains scene configuration
    guard let configurations =
        info.scene?.configurations?[sessionRole.rawValue] else {
      return
    }

    // ... taking the configuration which matches the name or the first entry
    guard let scene = name == nil
                        ? configurations.first
                        : configurations.filter({ $0.name == name }).first else {
      return
    }
    // ... overwriting the scene name to the current configuration's scene name
    self.name = scene.name

    // ... deserialising the scene class if one was provided
    if let sceneClass = scene.class {
      self.sceneClass = NSClassFromString(sceneClass)
    }

    // .. deserialising the delegate class if one was provided
    if let delegateClass = scene.delegate {
      self.delegateClass = NSClassFromString(delegateClass)
    }
  }

  /// Specifying the Scene Creation Details

  /// The class of the scene object you want to create.
  public var sceneClass: AnyClass?

  /// The class of the delegate object you want to create.
  public var delegateClass: AnyClass?

  /// Getting the Configuration Attributes

  /// The application-specific name assigned to the scene configuration.
  public private(set) var name: String?

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
