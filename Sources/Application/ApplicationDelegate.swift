/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import class Foundation.NSNotification

public protocol ApplicationDelegate: class, _TriviallyConstructible {
  /// Initializing the App
  func application(_ application: Application,
                   willFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?)
      -> Bool

  func application(_ application: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?)
      -> Bool

  /// Responding to App Life-Cycle Events
  func applicationDidBecomeActive(_ application: Application)
  func applicationWillResignActive(_ application: Application)
  func applicationDidEnterBackground(_ application: Application)
  func applicationWillEnterForeground(_ application: Application)
  func applicationWillTerminate(_ application: Application)

  /// Responding to Environment Changes
  func applicationProtectedDataDidBecomeAavailable(_ application: Application)
  func applicationProtectedDataWillBecomeUnavailable(_ application: Application)
  func applicationDidRecieveMemoryWarning(_ application: Application)
  func applicationSignificantTimeChange(_ application: Application)
}

public extension ApplicationDelegate {
  func application(_ application: Application,
                   willFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?)
      -> Bool {
    return true
  }

  func application(_ application: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?)
      -> Bool {
    return true
  }
}

extension ApplicationDelegate {
  public func applicationDidBecomeActive(_: Application) {
  }

  public func applicationWillResignActive(_: Application) {
  }

  public func applicationDidEnterBackground(_: Application) {
  }

  public func applicationWillEnterForeground(_: Application) {
  }

  public func applicationWillTerminate(_: Application) {
  }
}

extension ApplicationDelegate {
  public func applicationProtectedDataDidBecomeAavailable(_ application: Application) {
  }

  public func applicationProtectedDataWillBecomeUnavailable(_ application: Application) {
  }

  public func applicationDidRecieveMemoryWarning(_ application: Application) {
  }

  public func applicationSignificantTimeChange(_ application: Application) {
  }
}

extension ApplicationDelegate {
  public static var didFinishLaunchingNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationDidFinishLaunchingNotificaton")
  }
}

extension ApplicationDelegate {
  public static var didBecomeActiveNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationDidBecomeActiveNotification")
  }
  public static var didEnterBackgroundNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationDidEnterBackgroundNotification")
  }
  public static var willEnterForegroundNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationWillEnterForegroundNotification")
  }
  public static var willResignActiveNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification")
  }
  public static var willTerminateNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationWillTerminateNotification")
  }
}

extension ApplicationDelegate {
  public static func main() {
    ApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil,
                    String(describing: String(reflecting: Self.self)))
  }
}
