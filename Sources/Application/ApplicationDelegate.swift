/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

import class Foundation.NSNotification

public protocol _TriviallyConstructible {
  init()
}

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
