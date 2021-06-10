// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import class Foundation.NSNotification

/// The orientation of the application's user interface
public enum InterfaceOrientation: Int {
  /// The orientation of the device is unknown.
  case unknown

  /// The device is in portrait mode, with the device upright.
  case portrait

  /// The device is in portrait mode, with the device upside down.
  case portraitUpsideDown

  /// The device is in landscape mode, with the device upright.
  case landscapeLeft

  /// The device is in landscape mode, with the device upright.
  case landscapeRight
}

extension InterfaceOrientation {
  public var isLandscape: Bool {
    switch self {
    case .landscapeLeft, .landscapeRight:
      return true
    default: return false
    }
  }

  public var isPortrait: Bool {
    switch self {
    case .portrait, .portraitUpsideDown:
      return true
    default: return false
    }
  }
}

/// These constants are mask bits for specifying a view controller's supported
/// interface orientations.
public struct InterfaceOrientationMask: OptionSet {
  public typealias RawValue = UInt

  public let rawValue: RawValue

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }
}

extension InterfaceOrientationMask {
  /// The view controller supports a portrait interface orientation.
  public static var portrait: InterfaceOrientationMask {
    InterfaceOrientationMask(rawValue: 1 << InterfaceOrientation.portrait.rawValue)
  }

  /// The view controller supports a landscape-left interface orientation.
  public static var landscapeLeft: InterfaceOrientationMask {
    InterfaceOrientationMask(rawValue: 1 << InterfaceOrientation.landscapeLeft.rawValue)
  }

  /// The view controller supports a landscape-right interface orientation.
  public static var landscapeRight: InterfaceOrientationMask {
    InterfaceOrientationMask(rawValue: 1 << InterfaceOrientation.landscapeRight.rawValue)
  }

  /// The view controller supports an upside-down portrait interface
  /// orientation.
  public static var portraitUpsideDown: InterfaceOrientationMask {
    InterfaceOrientationMask(rawValue: 1 << InterfaceOrientation.portraitUpsideDown.rawValue)
  }

  /// The view controller supports both landscape-left and landscape-right
  /// interface orientation.
  public static var landscape: InterfaceOrientationMask {
    InterfaceOrientationMask(rawValue: self.landscapeLeft.rawValue | self.landscapeRight.rawValue)
  }

  /// The view controller supports all interface orientations.
  public static var all: InterfaceOrientationMask {
    InterfaceOrientationMask(rawValue: self.portrait.rawValue | self.landscapeLeft.rawValue | self.landscapeRight.rawValue | self.portraitUpsideDown.rawValue)
  }

  /// The view controller supports all but the upside-down portrait interface
  /// orientation.
  public static var allButUpsideDown: InterfaceOrientationMask {
    InterfaceOrientationMask(rawValue: self.portrait.rawValue | self.landscapeLeft.rawValue | self.landscapeRight.rawValue)
  }
}

/// A set of methods used to manage shared behaviours for the application.
public protocol ApplicationDelegate: AnyObject, _TriviallyConstructible {
  // MARK - Initializing the App

  /// Informs the delegate that the application launch process has begun.
  func application(_ application: Application,
                   willFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?)
      -> Bool

  /// Informs the delegate that the application launch process has ended and
  /// the application is almost ready to run.
  func application(_ application: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?)
      -> Bool

  // MARK - Responding to App Life-Cycle Events

  /// Informs the delegate that the application has become active.
  func applicationDidBecomeActive(_ application: Application)

  /// Informs the delgate that the application is about to become inactive.
  func applicationWillResignActive(_ application: Application)

  /// Informs the delegate that the application is now in the background.
  func applicationDidEnterBackground(_ application: Application)

  /// Informs the delegate that the application is about to enter the foreground.
  func applicationWillEnterForeground(_ application: Application)

  /// Informs the delegate that the application is about to terminate.
  func applicationWillTerminate(_ application: Application)

  // MARK - Responding to Environment Changes

  /// Tells the delegate that protected files are available now.
  func applicationProtectedDataDidBecomeAavailable(_ application: Application)

  /// Tells the delegate that the protected files are about to become
  /// unavailable.
  func applicationProtectedDataWillBecomeUnavailable(_ application: Application)

  /// Tells the delegate when the app receives a memory warning from the system.
  func applicationDidRecieveMemoryWarning(_ application: Application)

  /// Tells the delegate when there is a significant change in the time.
  func applicationSignificantTimeChange(_ application: Application)

  // MARK - Configuring and Discarding Scenes

  /// Returns the configuration data to use when creating a new scene.
  func application(_ application: Application,
                   configurationForConnecting connectingSceneSession: SceneSession,
                   options: Scene.ConnectionOptions) -> SceneConfiguration

  /// Informs the delegate that the user closed one or more of the application's
  /// scenes.
  func application(_ application: Application,
                   didDiscardSceneSessions sceneSessions: Set<SceneSession>)
}

extension ApplicationDelegate {
  public func application(_ application: Application,
                          willFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?)
      -> Bool {
    return true
  }

  public func application(_ application: Application,
                          didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?)
      -> Bool {
    return true
  }

  /// A notification that posts immediately after the app finishes launching.
  public static var didFinishLaunchingNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationDidFinishLaunchingNotification")
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

  /// A notification that posts when the app becomes active.
  public static var didBecomeActiveNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationDidBecomeActiveNotification")
  }

  /// A notification that posts when the app is no longer active and loses
  /// focus.
  public static var willResignActiveNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification")
  }

  /// A notification that posts when the app enters the background.
  public static var didEnterBackgroundNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationDidEnterBackgroundNotification")
  }

  /// A notification that posts shortly before an app leaves the background
  /// state on its way to becoming the active app.
  public static var willEnterForegroundNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationWillEnterForegroundNotification")
  }

  /// A notification that posts when the app is about to terminate.
  public static var willTerminateNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationWillTerminateNotification")
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

  /// A notification that posts when the protected files become available for
  /// your code to access.
  public static var protectedDataDidBecomeAvailableNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationProtectedDataDidBecomeAvailableNotification")
  }

  /// A notification that posts shortly before protected files are locked down
  /// and become inaccessible.
  public static var protectedDataWillBecomeUnavailableNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationProtectedDataWillBecomeUnavailableNotification")
  }

  /// A notification that posts when the app receives a warning from the
  /// operating system about low memory availability.
  public static var didReceiveMemoryWarningNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationDidReceiveMemoryWarningNotification")
  }

  /// A notification that posts when there is a significant change in time, for
  /// example, change to a new day (midnight), carrier time update, and change
  /// to or from daylight savings time.
  public static var significantTimeChangeNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIApplicationSignificantTimeChangeNotification")
  }
}

extension ApplicationDelegate {
  public func application(_ application: Application,
                          configurationForConnecting connectingSceneSession: SceneSession,
                          options: Scene.ConnectionOptions) -> SceneConfiguration {
    return connectingSceneSession.configuration
  }

  public func application(_ application: Application,
                          didDiscardSceneSessions sceneSessions: Set<SceneSession>) {
    sceneSessions.forEach {
      if let scene = $0.scene {
        scene.delegate?.sceneDidDisconnect(scene)
      }
    }
  }
}
