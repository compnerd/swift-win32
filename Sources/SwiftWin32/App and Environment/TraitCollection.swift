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
  public static let unspecified: ContentSizeCategory =
      ContentSizeCategory(rawValue: "_UICTContentSizeCategoryUnspecified")
  public static let extraSmall: ContentSizeCategory =
      ContentSizeCategory(rawValue: "UICTContentSizeCategoryXS")
  public static let small: ContentSizeCategory =
      ContentSizeCategory(rawValue: "UICTContentSizeCategoryS")
  public static let medium: ContentSizeCategory =
      ContentSizeCategory(rawValue: "UICTContentSizeCategoryM")
  public static let large: ContentSizeCategory =
      ContentSizeCategory(rawValue: "UICTContentSizeCategoryL")
  public static let extraLarge: ContentSizeCategory =
      ContentSizeCategory(rawValue: "UICTContentSizeCategoryXL")
  public static let extraExtraLarge: ContentSizeCategory =
      ContentSizeCategory(rawValue: "UICTContentSizeCategoryXXL")
  public static let extraExtraExtraLarge: ContentSizeCategory =
      ContentSizeCategory(rawValue: "UICTContentSizeCategoryXXXL")
  public static let accessibilityMedium: ContentSizeCategory =
      ContentSizeCategory(rawValue: "UICTContentSizeCategoryAccessibilityM")
  public static let accessibilityLarge: ContentSizeCategory =
      ContentSizeCategory(rawValue: "UICTContentSizeCategoryAccessibilityL")
  public static let accessibilityExtraLarge: ContentSizeCategory =
      ContentSizeCategory(rawValue: "UICTContentSizeCategoryAccessibilityXL")
  public static let accessibilityExtraExtraLarge: ContentSizeCategory =
      ContentSizeCategory(rawValue: "UICTContentSizeCategoryAccessibilityXXL")
  public static let accessibilityExtraExtraExtraLarge: ContentSizeCategory =
      ContentSizeCategory(rawValue: "UICTContentSizeCategoryAccessibilityXXXL")
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

  // Retriving Size Class Traits
  public private(set) var horizontalSizeClass: UserInterfaceSizeClass =
      .unspecified
  public private(set) var verticalSizeClass: UserInterfaceSizeClass =
      .unspecified

  // Retriving Display-Related Traits
  public private(set) var displayScale: Double = 0.0
  public private(set) var displayGamut: DisplayGamut = .unspecified

  // Retriving Interface-Related Traits
  public private(set) var userInterfaceStyle: UserInterfaceStyle = .unspecified
  public private(set) var userInterfaceIdiom: UserInterfaceIdiom = .unspecified
  public private(set) var userInterfaceLevel: UserInterfaceLevel = .unspecified
  public private(set) var layoutDirection: TraitEnvironmentLayoutDirection =
      .unspecified
  public private(set) var accessibilityContrast: AccessibilityContrast =
      .unspecified
  public private(set) var legibilityWeight: LegibilityWeight = .unspecified
  public private(set) var activeAppearance: UserInterfaceActiveAppearance =
      .unspecified

  // Retriving the Force Touch Capability
  public private(set) var forceTouchCapability: ForceTouchCapability =
      .unspecified

  // Retriving Content Size Category Information
  public private(set) var preferredContentSizeCategory: ContentSizeCategory =
      .unspecified

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

  public init(userInterfaceStyle: UserInterfaceStyle) {
    self.userInterfaceStyle = userInterfaceStyle
  }

  public init(userInterfaceIdiom: UserInterfaceIdiom) {
    self.userInterfaceIdiom = userInterfaceIdiom
  }

  public init(horizontalSizeClass: UserInterfaceSizeClass) {
    self.horizontalSizeClass = horizontalSizeClass
  }

  public init(verticalSizeClass: UserInterfaceSizeClass) {
    self.verticalSizeClass = verticalSizeClass
  }

  public init(accessibilityContrast: AccessibilityContrast) {
    self.accessibilityContrast = accessibilityContrast
  }

  public init(userInterfaceLevel: UserInterfaceLevel) {
    self.userInterfaceLevel = userInterfaceLevel
  }

  public init(legibilityWeight: LegibilityWeight) {
    self.legibilityWeight = legibilityWeight
  }

  public init(activeAppearance: UserInterfaceActiveAppearance) {
    self.activeAppearance = activeAppearance
  }

  public init(forceTouchCapability: ForceTouchCapability) {
    self.forceTouchCapability = forceTouchCapability
  }

  public init(displayScale: Double) {
    self.displayScale = displayScale
  }

  public init(displayGamut: DisplayGamut) {
    self.displayGamut = displayGamut
  }

  public init(layoutDirection: TraitEnvironmentLayoutDirection) {
    self.layoutDirection = layoutDirection
  }

  public init(preferredContentSizeCategory: ContentSizeCategory) {
    self.preferredContentSizeCategory = preferredContentSizeCategory
  }
}
