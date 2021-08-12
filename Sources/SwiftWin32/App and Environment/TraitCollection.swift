// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

/// Constants that indicate the size class of a view.
public enum UserInterfaceSizeClass: Int {
  /// Indicates the size class has not been specified.
  case unspecified

  /// Indicates a compact size class.
  case compact

  /// Indicates a regular size class.
  case regular
}

/// Constants that indicate the gamut of the current display.
public enum DisplayGamut: Int {
  /// An unspecified gamut value.
  case unspecified

  /// The sRGB display gamut.
  case SRGB

  /// The P3 display gamut.
  case P3
}

/// Constants that indicate the interface style for the application.
public enum UserInterfaceStyle: Int {
  /// An unspecified interface style.
  case unspecified

  /// The light interface style.
  case light

  /// The dark interface style.
  case dark
}

/// Constants that indicate whether the user interface has an active appearance.
public enum UserInterfaceActiveAppearance: Int {
  /// The interface has an unspecified appearance.
  case unspecified

  /// The interface has an active appearance.
  case active

  /// The interface has an inactive appearance.
  case inactive
}

public enum UserInterfaceIdiom: Int {
  case unspecified
  case phone
  case pad
  case tv
  case car
  case mac
}

public enum UserInterfaceLevel: Int {
  case unspecified
  case base
  case elevated
}

public enum TraitEnvironmentLayoutDirection: Int {
  case unspecified
  case leftToRight
  case rightToLeft
}

public enum AccessibilityContrast: Int {
  case unspecified
  case normal
  case high
}

public enum LegibilityWeight: Int {
  case unspecified
  case regular
  case bold
}

public enum ForceTouchCapability: Int {
  case unspecified
  case available
  case unavailable
}

public struct ContentSizeCategory: Equatable, Hashable, RawRepresentable {
  public typealias RawValue = String

  public var rawValue: RawValue

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }
}

extension ContentSizeCategory {
  public static var unspecified: ContentSizeCategory {
    ContentSizeCategory(rawValue: "_UICTContentSizeCategoryUnspecified")
  }

  public static var extraSmall: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryXS")
  }

  public static var small: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryS")
  }

  public static var medium: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryM")
  }

  public static var large: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryL")
  }

  public static var extraLarge: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryXL")
  }

  public static var extraExtraLarge: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryXXL")
  }

  public static var extraExtraExtraLarge: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryXXXL")
  }

  public static var accessibilityMedium: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryAccessibilityM")
  }

  public static var accessibilityLarge: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryAccessibilityL")
  }

  public static var accessibilityExtraLarge: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryAccessibilityXL")
  }

  public static var accessibilityExtraExtraLarge: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryAccessibilityXXL")
  }

  public static var accessibilityExtraExtraExtraLarge: ContentSizeCategory {
    ContentSizeCategory(rawValue: "UICTContentSizeCategoryAccessibilityXXXL")
  }
}

private func GetCurrentColorScheme() -> UserInterfaceStyle {
  var dwAppsUseLightTheme: DWORD = 1
  var cbAppsUseLightTheme: DWORD =
      DWORD(MemoryLayout.size(ofValue: dwAppsUseLightTheme))

  // TODO: query the `RequestedTheme` property of the `Application` from the
  // manifest

  let lStatus: LSTATUS =
      RegGetValueW(HKEY_CURRENT_USER,
                   "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize".wide,
                   "AppsUseLightTheme".wide,
                   DWORD(RRF_RT_REG_DWORD), nil,
                   &dwAppsUseLightTheme, &cbAppsUseLightTheme)
  guard lStatus == S_OK else {
    log.error("RegGetValueW: \(lStatus)")
    return .unspecified
  }
  return dwAppsUseLightTheme == 0 ? .dark : .light
}

private func GetCurrentDeviceFamily() -> UserInterfaceIdiom {
  return GetSystemMetrics(SM_TABLETPC) == 0 ? .unspecified : .pad
}

private func GetCurrentAccessibilityContrast() -> AccessibilityContrast {
  var hcContrast: HIGHCONTRASTW = HIGHCONTRASTW()
  hcContrast.cbSize = UINT(MemoryLayout<HIGHCONTRASTW>.size)
  if !SystemParametersInfoW(UINT(SPI_GETHIGHCONTRAST), 0, &hcContrast, 0) {
    log.error("SystemParametersInfoW: \(Error(win32: GetLastError()))")
    return .unspecified
  }
  return Int32(hcContrast.dwFlags) & HCF_HIGHCONTRASTON == HCF_HIGHCONTRASTON
      ? .high : .normal
}

private func GetCurrentLayoutDirection() -> TraitEnvironmentLayoutDirection {
  var dwDefaultLayout: DWORD = 0
  if !GetProcessDefaultLayout(&dwDefaultLayout) {
    log.error("GetProcessDefaultLayout: \(Error(win32: GetLastError()))")
    return .unspecified
  }
  return dwDefaultLayout == LAYOUT_RTL ? .rightToLeft : .leftToRight
}

private func GetCurrentDisplayScale() -> Double {
  let hMonitor: HMONITOR =
      MonitorFromWindow(GetDesktopWindow(), DWORD(MONITOR_DEFAULTTOPRIMARY))
  var dsfDeviceScaleFactor: DEVICE_SCALE_FACTOR = SCALE_100_PERCENT
  let hr: HRESULT = GetScaleFactorForMonitor(hMonitor, &dsfDeviceScaleFactor)
  guard hr == S_OK else {
    log.warning("GetScaleFactorFromMonitor: \(String(hr, radix: 16))")
    return 0.0
  }
  return dsfDeviceScaleFactor.factor
}

private func GetCurrentDisplayGamut() -> DisplayGamut {
  // TODO(compnerd) identify the actual display gamut in use for the primary
  // display.  sRGB is still far more common than DCI-P3, so assume that for
  // now.  Note that in reality, its more likely that the display is using
  // wsRGB, which is a Windows "optimized" sRGB color gamut.
  return .SRGB
}

public class TraitCollection {
  // MARK -  Creating a Trait Collection

  /// Creates a trait collection that consists of traits merged from a specified
  /// array of trait collections.
  ///
  /// This method takes an array of one or more trait collections and merges
  /// them to create a new trait collection. If the array contains more than one
  /// element, the highest-indexed element that contains a given trait is used
  /// for that trait. For example, the following code snippet creates a trait
  /// collection with a compact horizontal size class, because the second
  /// element in the array overrides the first for that trait:
  ///
  /// ```swift
  /// let collection1: TraitCollection = TraitCollection(horizontalSizeClass: .regular)
  /// let collection2: TraitCollection = TraitCollection(horizontalSizeClass: .compact)
  /// let collection3: TraitCollection = TraitCollection(traitsFrom: [collection1, collection2])
  /// ```
  public init(traitsFrom traits: [TraitCollection]) {
    _ = traits.map {
      if $0.horizontalSizeClass != .unspecified {
        self.horizontalSizeClass = $0.horizontalSizeClass
      }
      if $0.verticalSizeClass != .unspecified {
        self.verticalSizeClass = $0.verticalSizeClass
      }
      if $0.displayScale != 0.0 {
        self.displayScale = $0.displayScale
      }
      if $0.displayGamut != .unspecified {
        self.displayGamut = $0.displayGamut
      }
      if $0.userInterfaceStyle != .unspecified {
        self.userInterfaceStyle = $0.userInterfaceStyle
      }
      if $0.userInterfaceIdiom != .unspecified {
        self.userInterfaceIdiom = $0.userInterfaceIdiom
      }
      if $0.userInterfaceLevel != .unspecified {
        self.userInterfaceLevel = $0.userInterfaceLevel
      }
      if $0.layoutDirection != .unspecified {
        self.layoutDirection = $0.layoutDirection
      }
      if $0.accessibilityContrast != .unspecified {
        self.accessibilityContrast = $0.accessibilityContrast
      }
      if $0.legibilityWeight != .unspecified {
        self.legibilityWeight = $0.legibilityWeight
      }
      if $0.activeAppearance != .unspecified {
        self.activeAppearance = $0.activeAppearance
      }
      if $0.forceTouchCapability != .unspecified {
        self.forceTouchCapability = $0.forceTouchCapability
      }
      if $0.preferredContentSizeCategory != .unspecified {
        self.preferredContentSizeCategory = $0.preferredContentSizeCategory
      }
    }
  }

  /// Creates a trait collection that contains only a specified interface idiom.
  public init(userInterfaceIdiom: UserInterfaceIdiom) {
    self.userInterfaceIdiom = userInterfaceIdiom
  }

  /// Creates a trait collection that contains only a specified horizontal size
  /// class.
  public init(horizontalSizeClass: UserInterfaceSizeClass) {
    self.horizontalSizeClass = horizontalSizeClass
  }

  /// Creates a trait collection that contains only a specified vertical size
  /// class.
  public init(verticalSizeClass: UserInterfaceSizeClass) {
    self.verticalSizeClass = verticalSizeClass
  }

  /// Creates a trait collection that contains only the specified user interface
  /// style trait.
  public init(userInterfaceStyle: UserInterfaceStyle) {
    self.userInterfaceStyle = userInterfaceStyle
  }

  /// Creates a trait collection that contains only the specified accessibility
  /// contrast trait.
  public init(accessibilityContrast: AccessibilityContrast) {
    self.accessibilityContrast = accessibilityContrast
  }

  /// Creates a trait collection that contains only the specified user interface
  /// level trait.
  public init(userInterfaceLevel: UserInterfaceLevel) {
    self.userInterfaceLevel = userInterfaceLevel
  }

  /// Creates a trait collection that contains only the specified legibility
  /// weight trait.
  public init(legibilityWeight: LegibilityWeight) {
    self.legibilityWeight = legibilityWeight
  }

  /// Creates a trait collection that contains only a specified force touch
  /// capability trait.
  public init(forceTouchCapability: ForceTouchCapability) {
    self.forceTouchCapability = forceTouchCapability
  }

  /// Creates a trait collection that contains only a specified display scale.
  public init(displayScale: Double) {
    self.displayScale = displayScale
  }

  /// Creates a trait collection that contains only the specified display gamut
  /// trait.
  public init(displayGamut: DisplayGamut) {
    self.displayGamut = displayGamut
  }

  /// Creates a trait collection that contains only the specified layout
  /// direction trait.
  public init(layoutDirection: TraitEnvironmentLayoutDirection) {
    self.layoutDirection = layoutDirection
  }

  /// Creates a trait collection that contains only the specified content size
  /// category trait.
  public init(preferredContentSizeCategory: ContentSizeCategory) {
    self.preferredContentSizeCategory = preferredContentSizeCategory
  }

  /// Creates a trait collection that contains only the specified active
  /// appearance trait.
  public init(activeAppearance: UserInterfaceActiveAppearance) {
    self.activeAppearance = activeAppearance
  }

  // MARK - Getting the Current Traits

  // TODO(compnerd) The framework stores the value for this property as a
  // thread-local variable, so access to it is fast.

  /// The complete set of traits for the current environment.
  ///
  /// The framework updates the value of this property before calling several
  /// well-known methods of `View`, `ViewController`, and
  /// `PresentationController`. The trait collection contains a complete set of
  /// trait values describing the current environment, and does not include
  /// unspecified or unknown values.
  ///
  /// Changing the traits on a nonmain thread does not affect the current traits
  /// on your applications's main thread.
  public private(set) static var current: TraitCollection =
      TraitCollection(traitsFrom: [
        TraitCollection(accessibilityContrast: GetCurrentAccessibilityContrast()),
        TraitCollection(displayGamut: GetCurrentDisplayGamut()),
        TraitCollection(displayScale: GetCurrentDisplayScale()),
        TraitCollection(layoutDirection: GetCurrentLayoutDirection()),
        TraitCollection(preferredContentSizeCategory: .large),
        TraitCollection(userInterfaceIdiom: GetCurrentDeviceFamily()),
        TraitCollection(userInterfaceLevel: .base),
        TraitCollection(userInterfaceStyle: GetCurrentColorScheme()),

        TraitCollection(horizontalSizeClass: Device.current.isPortrait
                                                ? .compact
                                                : .regular),
        TraitCollection(verticalSizeClass: Device.current.isPortrait
                                              ? .regular
                                              : .compact),
      ])

  // MARK - Retriving Size Class Traits

  /// The horizontal size class of the trait collection.
  public private(set) var horizontalSizeClass: UserInterfaceSizeClass =
      .unspecified

  /// The vertical size class of the trait collection.
  public private(set) var verticalSizeClass: UserInterfaceSizeClass =
      .unspecified

  // MARK -Retriving Display-Related Traits

  /// The display scale of the trait collection.
  ///
  /// A value of 1.0 indicates a non-Retina display and a value of 2.0 indicates
  /// a Retina display. The default display scale for a trait collection is 0.0
  /// (indicating unspecified).
  public private(set) var displayScale: Double = 0.0

  /// The gamut of the current display.
  public private(set) var displayGamut: DisplayGamut = .unspecified

  // MARK - Retriving Interface-Related Traits

  /// The style associated with the user interface.
  ///
  /// Use this trait to determine whether your interface should be configured
  /// with a dark or light appearance. The default value of this trait is set to
  /// the corresponding appearance setting on the user's device.
  public private(set) var userInterfaceStyle: UserInterfaceStyle = .unspecified

  /// The user interface idiom of the trait collection.
  ///
  /// The default user interface idiom for a trait collection is
  /// `UserInterfaceIdiom.unspecified`.
  public private(set) var userInterfaceIdiom: UserInterfaceIdiom = .unspecified

  /// The elevation level of the interface.
  ///
  /// Levels create a visual separation between different parts of your UI.
  /// `Window` content typically appears at the `UserInterfaceLevel.base` level.
  /// When you want parts of your UI to stand out from the underlying
  /// background, assign the `UserInterfaceLevel.elevated` level to them. For
  /// example, the system assigns the `UserInterfaceLevel.elevated` level to
  /// alerts and popovers.
  public private(set) var userInterfaceLevel: UserInterfaceLevel = .unspecified

  /// The layout direction associated with the current environment.
  ///
  /// Use this trait to determine whether the underlying environment uses a
  /// left-to-right or right-to-left orientation.
  public private(set) var layoutDirection: TraitEnvironmentLayoutDirection =
      .unspecified

  /// The accessibility contrast associated with the current environment.
  ///
  /// Use this trait to determine whether the user requested a high contrast
  /// between foreground and background content. The user sets the contrast
  /// level in Accessibility Settings.
  public private(set) var accessibilityContrast: AccessibilityContrast =
      .unspecified

  /// The font weight to apply to text.
  ///
  /// The legibility weight reflects the value of the Bold Text display setting.
  public private(set) var legibilityWeight: LegibilityWeight = .unspecified

  /// A property that indicates whether the user interface has an active
  /// appearance.
  ///
  /// The active appearance varies according to window activation state.
  public private(set) var activeAppearance: UserInterfaceActiveAppearance =
      .unspecified

  // MARK - Retriving the Force Touch Capability

  /// The force touch capability value of the trait collection.
  ///
  /// Force Touch is available only on certain devices. On those devices,
  /// availability is determined by the user's associated accessibility setting
  /// in Settings. Check this property's value on app launch, and in your
  /// implementation of the `traitCollectionDidChange(_:)` method.
  ///
  /// If this property does not contain a value, the meaning is equivalent to
  /// the value `ForceTouchCapability.unknown`.
  public private(set) var forceTouchCapability: ForceTouchCapability =
      .unspecified

  // MARK - Retriving Content Size Category Information

  /// The font sizing option preferred by the user.
  ///
  /// With dynamic text sizing, users can ask that apps display text using fonts
  /// that are larger or smaller than the normal font size defined by the
  /// system. For example, a user with a visual impairment might request a
  /// larger default font size to make it easier to read text. Use the value of
  /// this property to request a `Font` object that matches the user's requested
  /// size.
  public private(set) var preferredContentSizeCategory: ContentSizeCategory =
      .unspecified

  // MARK - Comparing Trait Collections

  /// Queries whether a trait collection contains all of another trait
  /// collection's values.
  ///
  /// Use this method to compare two standalone trait collections, or to compare
  /// the interface environment's trait collection to a standalone trait
  /// collection.
  public func containsTraits(in trait: TraitCollection?) -> Bool {
    fatalError("\(#function) not yet implemented")
  }

  /// Queries whether changing between the specified and current trait
  /// collections would affect color values.
  ///
  /// Use this method to determine whether changing the traits of the current
  /// environment would also change the colors in your interface. For example,
  /// changing the `userInterfaceStyle` or `accessibilityContrast` property
  /// usually changes the colors of your interface.
  public func hasDifferentColorAppearance(comparedTo traitCollection: TraitCollection?)
      -> Bool {
    fatalError("\(#function) not yet implemented")
  }


  // MARK - Getting an Image Configuration Object

  /// An image configuration object compatible with this trait collection.
  ///
  /// The `Image.Configuration` object in this property contains the same traits
  /// as the current trait collection.
  public var imageConfiguration: Image.Configuration {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Performing Actions with the Current Traits

  /// Executes custom code using the traits of the current trait collection.
  ///
  /// Use this method when you want to execute code using a set of traits that
  /// differ from those in the current trait environment. For example, you might
  /// use this method to draw part of a view's content with a different set of
  /// traits. This method temporarily replaces the traits of the current
  /// environment with the ones found in the current `TraitCollection`. After
  /// the actions block finishes, the method restores the original traits to the
  /// environment.
  ///
  /// You can call this method from any thread of your application.
  public func performAsCurrent(_ actions: () -> Void) {
    fatalError("\(#function) not yet implemented")
  }
}
