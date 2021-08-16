// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import class Foundation.NSNotification

/// Constants that indicate the preferred size of your content.
public struct ContentSizeCategory: Equatable, Hashable, RawRepresentable {
  public typealias RawValue = String

  public var rawValue: RawValue

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }
}

extension ContentSizeCategory {
  // MARK - Font Sizes

  /// An unspecified font size.
  public static var unspecified: ContentSizeCategory {
    ContentSizeCategory(rawValue: "_UICTContentSizeCategoryUnspecified")
  }

  /// An extra-small font.
  public static var extraSmall: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryXS")
  }

  /// A small font.
  public static var small: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryS")
  }

  /// A medium-sized font.
  public static var medium: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryM")
  }

  /// A large font.
  public static var large: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryL")
  }

  /// An extra-large font.
  public static var extraLarge: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryXL")
  }

  /// A font that is larger than the extra-large font but smaller than the
  /// largest font size available.
  public static var extraExtraLarge: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryXXL")
  }

  /// The largest font size.
  public static var extraExtraExtraLarge: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryXXXL")
  }

  // MARK - Accessibility Sizes

  /// A medium font size that reflects the current accessibility settings.
  public static var accessibilityMedium: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryAccessibilityM")
  }

  /// A large font size that reflects the current accessibility settings.
  public static var accessibilityLarge: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryAccessibilityL")
  }

  /// An extra-large font size that reflects the current accessibility settings.
  public static var accessibilityExtraLarge: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryAccessibilityXL")
  }

  /// A font that is larger than the extra-large font but not the largest
  /// available, reflecting the current accessibility settings.
  public static var accessibilityExtraExtraLarge: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryAccessibilityXXL")
  }

  /// The largest font size that reflects the current accessibility settings.
  public static var accessibilityExtraExtraExtraLarge: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryAccessibilityXXXL")
  }

  // MARK - Font Size Change Notifications

  /// A notification that posts when the user changes the preferred content size
  /// setting.
  ///
  /// This notification is sent when the value in the
  /// `preferredContentSizeCategory` property changes. The `userInfo` dictionary
  /// of the notification contains the `newValueUserInfoKey` key, which reflects
  /// the new setting.
  public static var didChangeNotification: NSNotification.Name {
    NSNotification.Name(rawValue: "UIContentSizeCategoryDidChangeNotification")
  }

  /// A key that reflects the new preferred content size.
  ///
  /// This key's value is an `NSString` object that reflects the new value of
  /// the `preferredContentSizeCategory` property.
  public static var newValueUserInfoKey: String {
    "UIContentSizeCategoryNewValueUserInfoKey"
  }
}

/// The centralised point of control and coordination for running applications.
open class Application: Responder {
  internal var information: Information?

  // MARK - Getting the Application Instance

  /// Returns the singleton application instance.
  public static var shared: Application = Application()

  // MARK - Managing the Application's Behaviour

  /// The delegate of the application object.
  public var delegate: ApplicationDelegate?

  // MARK - Getting the Application State

  /// The applications current state or that of its most active scene.
  public internal(set) var state: Application.State

  // MARK - Getting Scene Information

  /// A boolean indicating whether the application may display multiple scenes.
  public var supportsMultipleScenes: Bool {
    information?.scene?.supportsMultipleScenes ?? false
  }

  /// The application's currently connected scenes.
  public internal(set) var connectedScenes: Set<Scene> = []

  /// The sessions whose scenes are either currently active or archived by the
  /// system.
  public internal(set) var openSessions: Set<SceneSession> = []

  // MARK - Getting Application Windows

  /// The application’s visible and hidden windows.
  public internal(set) var windows: [Window]

  /// The application's key window.
  public internal(set) var keyWindow: Window?

  override public required init() {
    self.state = .active
    self.windows = []
    super.init()
  }

  // MARK - Responder Chain Overrides

  override public var next: Responder? {
    // The next responder is the application delegate, but only if the
    // application delegate is an instance of `Responder` and is not a `View`,
    // `ViewController`, or the `Application` object itself.
    if let responder = self.delegate as? Responder,
       !(self.delegate is View), !(self.delegate is ViewController),
       !(self.delegate === self) {
      return responder
    }
    return nil
  }
}

extension Application {
  /// The running states of the application
  public enum State: Int {
    /// The application is running in the foreground and currently receiving
    /// events.
    case active

    /// The application is running in the foreground but is not receiving events.
    case inactive

    /// The application is running in the background.
    case background
  }
}
