/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

extension Application {
  /// Keys used to access values in the launch options dictionary passed to your
  /// application at initialization time.
  public struct LaunchOptionsKey: Equatable, Hashable, RawRepresentable {
    public typealias RawValue = String

    public var rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension Application.LaunchOptionsKey {
  /// A key indicating that the URL passed to your application contains custom
  /// annotation data from the source application.
  public static var annotation: Application.LaunchOptionsKey {
    Application.LaunchOptionsKey(rawValue: "Application.Annotation")
  }

  /// A key indicating that the application was relaunched to handle
  /// bluetooth-related events.
  public static var bluetootCentrals: Application.LaunchOptionsKey {
    Application.LaunchOptionsKey(rawValue: "Application.BluetoothCentrals")
  }

  /// A key indicating that the application should continue actions associated
  /// with it's bluetooth peripheral objects.
  public static var bluetoothPeripherals: Application.LaunchOptionsKey {
    Application.LaunchOptionsKey(rawValue: "Application.BluetoothPeripherals")
  }

  /// A key indicating that the application was launched to handle an incoming
  /// location event.
  public static var location: Application.LaunchOptionsKey {
    Application.LaunchOptionsKey(rawValue: "Application.Location")
  }

  /// A key indicating that a remove notification is available for the
  /// application to process.
  public static var remoteNotification: Application.LaunchOptionsKey {
    Application.LaunchOptionsKey(rawValue: "Application.RemoteNotification")
  }

  /// A key indicating that the application was launched in response to the user
  /// selecting a quick action.
  public static var shortcutItem: Application.LaunchOptionsKey {
    Application.LaunchOptionsKey(rawValue: "Application.ShortCutItem")
  }

  /// A key indicating that another application rrequested the launch of your
  /// application.
  public static let sourceApplication: Application.LaunchOptionsKey {
    Application.LaunchOptionsKey(rawValue: "Application.SourceApplication")
  }

  /// A key indicating that the application was launched so it could open the
  /// specified URL.
  public static let url: Application.LaunchOptionsKey {
    Application.LaunchOptionsKey(rawValue: "Application.URL")
  }

  /// A key indicating a dictionary associated with an activity that the user
  /// wants to continue.
  public static let userActivityDictionary: Application.LaunchOptionsKey {
    Application.LaunchOptionsKey(rawValue: "Application.UserActivityDictionary")
  }

  /// A key indicating the type of user activity that the user wants to
  /// continue.
  public static let userActivityType: Application.LaunchOptionsKey {
    Application.LaunchOptionsKey(rawValue: "Application.UserActivityType")
  }
}
