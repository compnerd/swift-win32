/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

public class Application: Responder {
  /// Getting the App Instance
  public static var shared: Application = Application()

  /// Managing the App's Behaviour
  public var delegate: ApplicationDelegate?

  /// Getting the Application State
  public internal(set) var state: Application.State

  /// Getting App Windows
  public internal(set) var keyWindow: Window?
  public internal(set) var windows: [Window]

  override public required init() {
    self.state = .active
    self.windows = []
    super.init()
  }

  // Responder Chain
  override public var next: Responder? {
    if let responder = self.delegate as? Responder,
       !(self.delegate is View), !(self.delegate is ViewController),
       !(self.delegate === self) {
      return responder
    }
    return nil
  }
}

extension Application {
  public struct LaunchOptionsKey: Equatable, Hashable, RawRepresentable {
    public typealias RawValue = String

    public var rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension Application.LaunchOptionsKey {
  public static let annotation: Application.LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.Annotation")
  public static let bluetootCentrals: Application.LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.BluetoothCentrals")
  public static let bluetoothPeripherals: Application.LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.BluetoothPeripherals")
  public static let cloudKitShareMetadata: Application.LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.CloudKitShareMetadata")
  @available(*, deprecated)
  public static let localNotification: Application.LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.LocalNotification")
  public static let location: Application.LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.Location")
  public static let newsstandDownloads: Application.LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.NewsStandDownloads")
  public static let remoteNotification: Application.LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.RemoteNotification")
  public static let shortcutItem: Application.LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.ShortCutItem")
  public static let sourceApplication: Application.LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.SourceApplication")
  public static let url: Application.LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.URL")
  public static let userActivityDictionary: Application.LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.UserActivityDictionary")
  public static let userActivityType: Application.LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.UserActivityType")
}

extension Application {
  /// The running states of the application
  public enum State: Int {
  /// The application is running in the foreground
  case active
  case inactive
  /// The application is running in the background
  case background
  }
}
