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

public class Application: _TriviallyConstructible {
  public static var shared: Application = Application()

  public var delegate: ApplicationDelegate?
  public internal(set) var state: Application.State

  public required init() {
    self.state = .active
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
