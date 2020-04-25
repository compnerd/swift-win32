/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
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

import WinSDK

public enum UserInterfaceSizeClass: Int {
case unspecified
case compact
case regular
}

public enum DisplayGamut: Int {
case unspecified
case SRGB
case P3
}

public enum UserInterfaceStyle: Int {
case unspecified
case light
case dark
}

public enum UserInterfaceIdiom: Int {
case unspecified
case phone
case pad
case tv
case car
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
                   "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize".LPCWSTR,
                   "AppsUseLightTheme".LPCWSTR,
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

private func GetCurrentElevationLevel() -> UserInterfaceLevel {
  var token: HANDLE?
  if OpenProcessToken(GetCurrentProcess(), DWORD(TOKEN_QUERY), &token) {
    defer { CloseHandle(token) }

    var elevation: TOKEN_ELEVATION = TOKEN_ELEVATION()
    var szElevation: DWORD = DWORD(MemoryLayout<TOKEN_ELEVATION>.size)
    if GetTokenInformation(token, TokenElevation, &elevation,
                           DWORD(MemoryLayout<TOKEN_ELEVATION>.size),
                           &szElevation) {
      return elevation.TokenIsElevated == 0 ? .base : .elevated
    }
  }
  return .unspecified
}

private func GetCurrentAccessibilityContrast() -> AccessibilityContrast {
  var hcContrast: HIGHCONTRASTW = HIGHCONTRASTW()
  hcContrast.cbSize = UINT(MemoryLayout<HIGHCONTRASTW>.size)
  if !SystemParametersInfoW(UINT(SPI_GETHIGHCONTRAST), 0, &hcContrast, 0) {
    log.error("SystemParametersInfoW: \(GetLastError())")
    return .unspecified
  }
  return Int32(hcContrast.dwFlags) & HCF_HIGHCONTRASTON == HCF_HIGHCONTRASTON
      ? .high : .normal
}

private func GetCurrentLayoutDirection() -> TraitEnvironmentLayoutDirection {
  var dwDefaultLayout: DWORD = 0
  if !GetProcessDefaultLayout(&dwDefaultLayout) {
    log.error("GetProcessDefaultLayout: \(GetLastError())")
    return .unspecified
  }
  return dwDefaultLayout == LAYOUT_RTL ? .rightToLeft : .leftToRight
}

public class TraitCollection {
  public static var current: TraitCollection {
    return TraitCollection(traitsFrom: [
      TraitCollection(userInterfaceStyle: GetCurrentColorScheme()),
      TraitCollection(userInterfaceIdiom: GetCurrentDeviceFamily()),
      TraitCollection(userInterfaceLevel: GetCurrentElevationLevel()),
      TraitCollection(accessibilityContrast: GetCurrentAccessibilityContrast()),
      TraitCollection(layoutDirection: GetCurrentLayoutDirection()),
    ])
  }

  // Retriving Size Class Traits
  public private(set) var horizontalSizeClass: UserInterfaceSizeClass =
      .unspecified
  public private(set) var verticalSizeClass: UserInterfaceSizeClass =
      .unspecified

  // Retriving Display-Related Traits
  public private(set) var displayScale: Double = 1.0
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

  // Retriving the Force Touch Capability
  public private(set) var forceTouchCapability: ForceTouchCapability =
      .unspecified

  // Retriving Content Size Category Information
  public private(set) var preferredContentSizeCategory: ContentSizeCategory =
      .unspecified

  public init() {
  }

  public init(traitsFrom traits: [TraitCollection]) {
    _ = traits.map {
      if $0.horizontalSizeClass != .unspecified {
        self.horizontalSizeClass = $0.horizontalSizeClass
      }
      if $0.verticalSizeClass != .unspecified {
        self.verticalSizeClass = $0.verticalSizeClass
      }
      self.displayScale = $0.displayScale
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
