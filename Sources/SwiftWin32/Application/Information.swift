/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

extension Application {
  internal struct SceneConfiguration {
    let name: String?
    let `class`: String?
    let delegate: String?
  }
}

extension Application.SceneConfiguration: Decodable {
  enum CodingKeys: String, CodingKey {
    case name = "SceneConfigurationName"
    case `class` = "SceneClassName"
    case delegate = "SceneDelegateClassName"
  }
}

extension Application {
  internal struct SceneManifest {
    // Enable Multiple Windows
    let supportsMultipleScenes: Bool?
    // Scene Configuration
    let configurations: [String:[Application.SceneConfiguration]]?
  }
}

extension Application.SceneManifest: Decodable {
  enum CodingKeys: String, CodingKey {
    case supportsMultipleScenes = "ApplicationSupportsMultipleScenes"
    case configurations = "SceneConfigurations"
  }
}

extension Application {
  internal struct Information {
    let scene: Application.SceneManifest?
  }
}

extension Application.Information: Decodable {
  enum CodingKeys: String, CodingKey {
    case scene = "ApplicationSceneManifest"
  }
}
