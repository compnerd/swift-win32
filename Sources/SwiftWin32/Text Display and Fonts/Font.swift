// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

// Values derived from the Apple Human Inteface Guidelines
// https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography
private typealias TypographyInfo = (weight: Font.Weight, size: Double, leading: Int)
private let typography: [ContentSizeCategory:[Font.TextStyle:TypographyInfo]] = [
  .extraSmall: [
    .largeTitle:    TypographyInfo(weight: .regular, size: 31, leading: 38),
    .title1:        TypographyInfo(weight: .regular, size: 25, leading: 31),
    .title2:        TypographyInfo(weight: .regular, size: 19, leading: 24),
    .title3:        TypographyInfo(weight: .regular, size: 17, leading: 22),
    .headline:      TypographyInfo(weight: .semibold, size: 14, leading: 19),
    .body:          TypographyInfo(weight: .regular, size: 14, leading: 19),
    .callout:       TypographyInfo(weight: .regular, size: 13, leading: 18),
    .subheadline:   TypographyInfo(weight: .regular, size: 12, leading: 16),
    .footnote:      TypographyInfo(weight: .regular, size: 12, leading: 16),
    .caption1:      TypographyInfo(weight: .regular, size: 11, leading: 13),
    .caption2:      TypographyInfo(weight: .regular, size: 11, leading: 13),
  ],
  .small: [
    .largeTitle:    TypographyInfo(weight: .regular, size: 32, leading: 39),
    .title1:        TypographyInfo(weight: .regular, size: 26, leading: 32),
    .title2:        TypographyInfo(weight: .regular, size: 20, leading: 25),
    .title3:        TypographyInfo(weight: .regular, size: 18, leading: 23),
    .headline:      TypographyInfo(weight: .semibold, size: 15, leading: 20),
    .body:          TypographyInfo(weight: .regular, size: 15, leading: 20),
    .callout:       TypographyInfo(weight: .regular, size: 14, leading: 19),
    .subheadline:   TypographyInfo(weight: .regular, size: 13, leading: 18),
    .footnote:      TypographyInfo(weight: .regular, size: 12, leading: 16),
    .caption1:      TypographyInfo(weight: .regular, size: 11, leading: 13),
    .caption2:      TypographyInfo(weight: .regular, size: 11, leading: 13),
  ],
  .medium: [
    .largeTitle:    TypographyInfo(weight: .regular, size: 33, leading: 40),
    .title1:        TypographyInfo(weight: .regular, size: 27, leading: 33),
    .title2:        TypographyInfo(weight: .regular, size: 21, leading: 26),
    .title3:        TypographyInfo(weight: .regular, size: 19, leading: 24),
    .headline:      TypographyInfo(weight: .semibold, size: 16, leading: 21),
    .body:          TypographyInfo(weight: .regular, size: 16, leading: 21),
    .callout:       TypographyInfo(weight: .regular, size: 15, leading: 20),
    .subheadline:   TypographyInfo(weight: .regular, size: 14, leading: 19),
    .footnote:      TypographyInfo(weight: .regular, size: 12, leading: 16),
    .caption1:      TypographyInfo(weight: .regular, size: 11, leading: 13),
    .caption2:      TypographyInfo(weight: .regular, size: 11, leading: 13),
  ],
  .large: [
    .largeTitle:    TypographyInfo(weight: .regular, size: 34, leading: 41),
    .title1:        TypographyInfo(weight: .regular, size: 28, leading: 34),
    .title2:        TypographyInfo(weight: .regular, size: 22, leading: 28),
    .title3:        TypographyInfo(weight: .regular, size: 20, leading: 25),
    .headline:      TypographyInfo(weight: .semibold, size: 17, leading: 22),
    .body:          TypographyInfo(weight: .regular, size: 17, leading: 22),
    .callout:       TypographyInfo(weight: .regular, size: 16, leading: 21),
    .subheadline:   TypographyInfo(weight: .regular, size: 15, leading: 20),
    .footnote:      TypographyInfo(weight: .regular, size: 13, leading: 18),
    .caption1:      TypographyInfo(weight: .regular, size: 12, leading: 16),
    .caption2:      TypographyInfo(weight: .regular, size: 11, leading: 13),
  ],
  .extraLarge: [
    .largeTitle:    TypographyInfo(weight: .regular, size: 36, leading: 43),
    .title1:        TypographyInfo(weight: .regular, size: 30, leading: 37),
    .title2:        TypographyInfo(weight: .regular, size: 24, leading: 30),
    .title3:        TypographyInfo(weight: .regular, size: 22, leading: 28),
    .headline:      TypographyInfo(weight: .semibold, size: 19, leading: 24),
    .body:          TypographyInfo(weight: .regular, size: 19, leading: 24),
    .callout:       TypographyInfo(weight: .regular, size: 18, leading: 23),
    .subheadline:   TypographyInfo(weight: .regular, size: 17, leading: 22),
    .footnote:      TypographyInfo(weight: .regular, size: 15, leading: 20),
    .caption1:      TypographyInfo(weight: .regular, size: 14, leading: 19),
    .caption2:      TypographyInfo(weight: .regular, size: 13, leading: 18),
  ],
  .extraExtraLarge: [
    .largeTitle:    TypographyInfo(weight: .regular, size: 38, leading: 46),
    .title1:        TypographyInfo(weight: .regular, size: 32, leading: 39),
    .title2:        TypographyInfo(weight: .regular, size: 26, leading: 32),
    .title3:        TypographyInfo(weight: .regular, size: 24, leading: 30),
    .headline:      TypographyInfo(weight: .semibold, size: 21, leading: 26),
    .body:          TypographyInfo(weight: .regular, size: 21, leading: 26),
    .callout:       TypographyInfo(weight: .regular, size: 20, leading: 25),
    .subheadline:   TypographyInfo(weight: .regular, size: 19, leading: 24),
    .footnote:      TypographyInfo(weight: .regular, size: 17, leading: 22),
    .caption1:      TypographyInfo(weight: .regular, size: 16, leading: 21),
    .caption2:      TypographyInfo(weight: .regular, size: 15, leading: 20),
  ],
  .extraExtraExtraLarge: [
    .largeTitle:    TypographyInfo(weight: .regular, size: 40, leading: 48),
    .title1:        TypographyInfo(weight: .regular, size: 34, leading: 41),
    .title2:        TypographyInfo(weight: .regular, size: 28, leading: 34),
    .title3:        TypographyInfo(weight: .regular, size: 26, leading: 32),
    .headline:      TypographyInfo(weight: .semibold, size: 23, leading: 29),
    .body:          TypographyInfo(weight: .regular, size: 23, leading: 29),
    .callout:       TypographyInfo(weight: .regular, size: 22, leading: 28),
    .subheadline:   TypographyInfo(weight: .regular, size: 21, leading: 28),
    .footnote:      TypographyInfo(weight: .regular, size: 19, leading: 24),
    .caption1:      TypographyInfo(weight: .regular, size: 18, leading: 23),
    .caption2:      TypographyInfo(weight: .regular, size: 17, leading: 22),
  ],
  .accessibilityMedium: [
    .largeTitle:    TypographyInfo(weight: .regular, size: 44, leading: 52),
    .title1:        TypographyInfo(weight: .regular, size: 38, leading: 46),
    .title2:        TypographyInfo(weight: .regular, size: 34, leading: 41),
    .title3:        TypographyInfo(weight: .regular, size: 31, leading: 38),
    .headline:      TypographyInfo(weight: .semibold, size: 28, leading: 34),
    .body:          TypographyInfo(weight: .regular, size: 28, leading: 34),
    .callout:       TypographyInfo(weight: .regular, size: 26, leading: 32),
    .subheadline:   TypographyInfo(weight: .regular, size: 25, leading: 31),
    .footnote:      TypographyInfo(weight: .regular, size: 23, leading: 29),
    .caption1:      TypographyInfo(weight: .regular, size: 22, leading: 28),
    .caption2:      TypographyInfo(weight: .regular, size: 20, leading: 25),
  ],
  .accessibilityLarge: [
    .largeTitle:    TypographyInfo(weight: .regular, size: 48, leading: 57),
    .title1:        TypographyInfo(weight: .regular, size: 43, leading: 51),
    .title2:        TypographyInfo(weight: .regular, size: 39, leading: 47),
    .title3:        TypographyInfo(weight: .regular, size: 37, leading: 44),
    .headline:      TypographyInfo(weight: .semibold, size: 33, leading: 40),
    .body:          TypographyInfo(weight: .regular, size: 33, leading: 40),
    .callout:       TypographyInfo(weight: .regular, size: 32, leading: 39),
    .subheadline:   TypographyInfo(weight: .regular, size: 30, leading: 37),
    .footnote:      TypographyInfo(weight: .regular, size: 27, leading: 33),
    .caption1:      TypographyInfo(weight: .regular, size: 26, leading: 32),
    .caption2:      TypographyInfo(weight: .regular, size: 24, leading: 30),
  ],
  .accessibilityExtraLarge: [
    .largeTitle:    TypographyInfo(weight: .regular, size: 52, leading: 61),
    .title1:        TypographyInfo(weight: .regular, size: 48, leading: 57),
    .title2:        TypographyInfo(weight: .regular, size: 44, leading: 52),
    .title3:        TypographyInfo(weight: .regular, size: 43, leading: 51),
    .headline:      TypographyInfo(weight: .semibold, size: 40, leading: 48),
    .body:          TypographyInfo(weight: .regular, size: 40, leading: 48),
    .callout:       TypographyInfo(weight: .regular, size: 38, leading: 46),
    .subheadline:   TypographyInfo(weight: .regular, size: 36, leading: 43),
    .footnote:      TypographyInfo(weight: .regular, size: 33, leading: 40),
    .caption1:      TypographyInfo(weight: .regular, size: 32, leading: 39),
    .caption2:      TypographyInfo(weight: .regular, size: 29, leading: 35),
  ],
  .accessibilityExtraExtraLarge: [
    .largeTitle:    TypographyInfo(weight: .regular, size: 56, leading: 66),
    .title1:        TypographyInfo(weight: .regular, size: 53, leading: 62),
    .title2:        TypographyInfo(weight: .regular, size: 50, leading: 59),
    .title3:        TypographyInfo(weight: .regular, size: 49, leading: 58),
    .headline:      TypographyInfo(weight: .semibold, size: 47, leading: 56),
    .body:          TypographyInfo(weight: .regular, size: 47, leading: 56),
    .callout:       TypographyInfo(weight: .regular, size: 44, leading: 52),
    .subheadline:   TypographyInfo(weight: .regular, size: 42, leading: 50),
    .footnote:      TypographyInfo(weight: .regular, size: 38, leading: 46),
    .caption1:      TypographyInfo(weight: .regular, size: 37, leading: 44),
    .caption2:      TypographyInfo(weight: .regular, size: 34, leading: 41),
  ],
  .accessibilityExtraExtraExtraLarge: [
    .largeTitle:    TypographyInfo(weight: .regular, size: 60, leading: 70),
    .title1:        TypographyInfo(weight: .regular, size: 58, leading: 68),
    .title2:        TypographyInfo(weight: .regular, size: 56, leading: 66),
    .title3:        TypographyInfo(weight: .regular, size: 55, leading: 65),
    .headline:      TypographyInfo(weight: .semibold, size: 53, leading: 62),
    .body:          TypographyInfo(weight: .regular, size: 53, leading: 62),
    .callout:       TypographyInfo(weight: .regular, size: 51, leading: 62),
    .subheadline:   TypographyInfo(weight: .regular, size: 49, leading: 58),
    .footnote:      TypographyInfo(weight: .regular, size: 44, leading: 52),
    .caption1:      TypographyInfo(weight: .regular, size: 43, leading: 51),
    .caption2:      TypographyInfo(weight: .regular, size: 40, leading: 47),
  ],
]

private func PointToLogical(_ points: Double) -> Int32 {
  return -MulDiv(Int32(points), GetDeviceCaps(GetDC(nil), LOGPIXELSY), 72)
}

private func LogicalToPoint(_ logical: Int32) -> Double {
  return Double(MulDiv(-logical, 72, GetDeviceCaps(GetDC(nil), LOGPIXELSY)))
}

/// Represents a font.
public class Font {
  internal var hFont: FontHandle

  // MARK - Creating Fonts

  /// Returns an instance of the system font for the specified text style with
  /// scaling for the user's selected content size category.
  public static func preferredFont(forTextStyle style: Font.TextStyle) -> Font {
    return Font.preferredFont(forTextStyle: style, compatibleWith: nil)
  }

  /// Returns an instance of the system font for the appropriate text style and
  /// traits.
  public static func preferredFont(forTextStyle style: Font.TextStyle,
                                   compatibleWith traits: TraitCollection?)
      -> Font {
    var size: ContentSizeCategory = traits?.preferredContentSizeCategory ?? .large
    if size == .unspecified { size = .large }

    guard let font = typography[size]?[style] else {
      log.error("\(#function) missing typography for \(style)@\(size)")
      return systemFont(ofSize: 12)
    }

    return systemFont(ofSize: font.size, weight: font.weight)
  }

  /// Creates an returns a font object for the specified font name and size.
  public init?(name: String, size: Double) {
    self.hFont = FontHandle(owning: CreateFontW(PointToLogical(size),
                                                /*cWidth=*/0,
                                                /*cEscapement=*/0,
                                                /*cOrientation=*/0,
                                                Font.Weight.regular.rawValue,
                                                /*bItalic=*/DWORD(0),
                                                /*bUnderline=*/DWORD(0),
                                                /*bStrikeOut=*/DWORD(0),
                                                DWORD(DEFAULT_CHARSET),
                                                DWORD(OUT_DEFAULT_PRECIS),
                                                DWORD(CLIP_DEFAULT_PRECIS),
                                                DWORD(DEFAULT_QUALITY),
                                                DWORD((FF_DONTCARE << 2) | DEFAULT_PITCH),
                                                name.wide))
  }

  // public init(descriptor: FontDescriptor, size pointSize: Double)

  // Returns a font object that is the ame as the font, but has the specified
  // size.
  public func withSize(_ fontSize: Double) -> Font {
    var lfFont: LOGFONTW = LOGFONTW()

    if GetObjectW(self.hFont.value, Int32(MemoryLayout<LOGFONTW>.size),
                  &lfFont) == 0 {
      log.error("GetObjectW: \(Error(win32: GetLastError()))")
      return self
    }
    lfFont.lfHeight = PointToLogical(fontSize)

    return Font(owning: CreateFontIndirectW(&lfFont))
  }

  // MARK - Creating System Fonts

  /// Returns the font object for standard interface items in the specified
  /// size.
  public static func systemFont(ofSize fontSize: Double) -> Font {
    return systemFont(ofSize: fontSize, weight: .regular, italic: false)
  }

  /// Returns the font object for standard interface items in the specifed size
  /// and weight.
  public static func systemFont(ofSize fontSize: Double, weight: Font.Weight)
      -> Font {
    return systemFont(ofSize: fontSize, weight: weight, italic: false)
  }

  /// Returns the font object for standard interface items in boldface type in
  /// the specified size.
  public static func boldSystemFont(ofSize fontSize: Double) -> Font {
    return systemFont(ofSize: fontSize, weight: .bold, italic: false)
  }

  /// Returns the font object for standard interface items in italic type in the
  /// specified size.
  public static func italicSystemFont(ofSize fontSize: Double) -> Font {
    return systemFont(ofSize: fontSize, weight: .regular, italic: true)
  }

  /// Returns the fixed-width font for standard interface text in the specified
  /// size.
  public static func monospacedSystemFont(ofSize fontSize: Double,
                                          weight: Font.Weight) -> Font {
    return Font(owning: CreateFontW(PointToLogical(fontSize),
                                    /*cWidth=*/0,
                                    /*cEscapement=*/0,
                                    /*cOrientation=*/0,
                                    weight.rawValue,
                                    /*bItalic=*/DWORD(0),
                                    /*bUnderline=*/DWORD(0),
                                    /*bStrikeOut=*/DWORD(0),
                                    DWORD(DEFAULT_CHARSET),
                                    DWORD(OUT_DEFAULT_PRECIS),
                                    DWORD(CLIP_DEFAULT_PRECIS),
                                    DWORD(DEFAULT_QUALITY),
                                    DWORD((FF_DONTCARE << 2) | FIXED_PITCH),
                                    nil))
  }

  /// Returns the standard system font with all digits of consistent width.
  public static func monospacedDigitSystemFont(ofSize fontSize: Double,
                                               weight: Font.Weight) -> Font {
    return Font(owning: CreateFontW(PointToLogical(fontSize),
                                    /*cWidth=*/0,
                                    /*cEscapement=*/0,
                                    /*cOrientation=*/0,
                                    weight.rawValue,
                                    /*bItalic=*/DWORD(0),
                                    /*bUnderline=*/DWORD(0),
                                    /*bStrikeOut=*/DWORD(0),
                                    DWORD(DEFAULT_CHARSET),
                                    DWORD(OUT_DEFAULT_PRECIS),
                                    DWORD(CLIP_DEFAULT_PRECIS),
                                    DWORD(DEFAULT_QUALITY),
                                    DWORD((FF_DONTCARE << 2) | FIXED_PITCH),
                                    nil))
  }

  // MARK - Getting the Available Font Names

  /// Returns an array of font family names available on the system.
  public static var familyNames: [String] {
    let hDC: HDC = GetDC(nil)

    var arrFamilies: Set<String> = []

    var lfFont: LOGFONTW = LOGFONTW()
    lfFont.lfCharSet = BYTE(DEFAULT_CHARSET)

    let pfnEnumerateFontFamilies: FONTENUMPROCW = { (lpelfe, lpnt, FontType, lParam) in
      // NOTE: '@' indicates a vertical-oriented flags; treat the enumeration
      // as if CF_NOVERTFONTS is specified.
      let bVerticalFont: Bool =
        UnicodeScalar(lpelfe?.pointee.lfFaceName.0 ?? 0) == UnicodeScalar("@")
      if bVerticalFont { return 1 }

      let parrFamilies: UnsafeMutablePointer<Set<String>> =
          UnsafeMutablePointer<Set<String>>(bitPattern: Int(lParam))!

      let family: String = withUnsafePointer(to: lpelfe?.pointee.lfFaceName) {
        let capacity: Int =
            MemoryLayout.size(ofValue: $0) / MemoryLayout<WCHAR>.size
        return $0.withMemoryRebound(to: UInt16.self, capacity: capacity) {
          String(decodingCString: $0, as: UTF16.self)
        }
      }

      parrFamilies.pointee.insert(family)
      return 1
    }

    _ = withUnsafeMutablePointer(to: &arrFamilies) {
      EnumFontFamiliesExW(hDC, &lfFont, pfnEnumerateFontFamilies,
                          LPARAM(Int(bitPattern: $0)), 0)
    }
    return Array<String>(arrFamilies)
  }

  /// Returns an array of font names available in a particular font family.
  public static func fontNames(forFontFamily family: String) -> [String] {
    let hDC: HDC = GetDC(nil)

    var arrFonts: Set<String> = []

    let pfnEnumerateFonts: FONTENUMPROCW = { (lplf, lptm, dwType, lpData) in
      let parrFonts: UnsafeMutablePointer<Set<String>> =
          UnsafeMutablePointer<Set<String>>(bitPattern: Int(lpData))!

      let font: String = withUnsafePointer(to: lplf?.pointee.lfFaceName) {
        let capacity: Int =
            MemoryLayout.size(ofValue: $0) / MemoryLayout<WCHAR>.size
        return $0.withMemoryRebound(to: UInt16.self, capacity: capacity) {
          String(decodingCString: $0, as: UTF16.self)
        }
      }

      parrFonts.pointee.insert(font)
      return 1
    }

    _ = withUnsafeMutablePointer(to: &arrFonts) {
      EnumFontsW(hDC, family.wide, pfnEnumerateFonts,
                 LPARAM(Int(bitPattern: $0)))
    }
    return Array<String>(arrFonts)
  }

  // MARK - Getting Font Name Attributes

  // public var familyName: String { }

  /// The font face name.
  public var fontName: String {
    var lfFont: LOGFONTW = LOGFONTW()

    if GetObjectW(self.hFont.value, Int32(MemoryLayout<LOGFONTW>.size),
                  &lfFont) == 0 {
      log.error("GetObjectW: \(Error(win32: GetLastError()))")
      return ""
    }

    return withUnsafePointer(to: &lfFont.lfFaceName) {
      let capacity: Int =
          MemoryLayout.size(ofValue: $0) / MemoryLayout<WCHAR>.size
      return $0.withMemoryRebound(to: UInt16.self, capacity: capacity) {
        return String(decodingCString: $0, as: UTF16.self)
      }
    }
  }

  // MARK - Getting Font Metrics

  /// The font's point size, or the effective vertical point size for a font
  /// with a non-standard matrix.
  public var pointSize: Double {
    var lfFont: LOGFONTW = LOGFONTW()

    if GetObjectW(self.hFont.value, Int32(MemoryLayout<LOGFONTW>.size),
                  &lfFont) == 0 {
      log.error("GetObjectW: \(Error(win32: GetLastError()))")
      return 0.0
    }

    return LogicalToPoint(lfFont.lfHeight)
  }

  /// The top y-coordinate, offset from the baseline, of the font's longest
  /// ascender.
  public var ascender: Double {
    let hDC: DeviceContextHandle =
        DeviceContextHandle(owning: CreateCompatibleDC(nil))
    let _ = SelectObject(hDC.value, self.hFont.value)

    var metrics: TEXTMETRICW = TEXTMETRICW()
    if !GetTextMetricsW(hDC.value, &metrics) {
      log.warning("GetTextMetricsW: \(Error(win32: GetLastError()))")
      return 0.0
    }
    return Double(metrics.tmAscent)
  }

  /// The bottom y-coordinate, offset from the baseline, of the font's longest
  /// descender.
  public var descender: Double {
    let hDC: DeviceContextHandle =
        DeviceContextHandle(owning: CreateCompatibleDC(nil))
    let _ = SelectObject(hDC.value, self.hFont.value)

    var metrics: TEXTMETRICW = TEXTMETRICW()
    if !GetTextMetricsW(hDC.value, &metrics) {
      log.warning("GetTextMetricsW: \(Error(win32: GetLastError()))")
      return 0.0
    }
    return Double(metrics.tmDescent)
  }

  /// The font's leading information.
  public var leading: Double {
    let hDC: DeviceContextHandle =
        DeviceContextHandle(owning: CreateCompatibleDC(nil))
    let _ = SelectObject(hDC.value, self.hFont.value)

    var metrics: TEXTMETRICW = TEXTMETRICW()
    if !GetTextMetricsW(hDC.value, &metrics) {
      log.warning("GetTextMetricsW: \(Error(win32: GetLastError()))")
      return 0.0
    }
    return Double(metrics.tmExternalLeading)
  }

  /// The font's cap height information.
  public var capHeight: Double {
    let hDC: DeviceContextHandle =
        DeviceContextHandle(owning: CreateCompatibleDC(nil))
    let _ = SelectObject(hDC.value, self.hFont.value)

    var size: SIZE = SIZE()
    if !GetTextExtentPoint32W(hDC.value, "u{0048}".wide, 1, &size) {
      log.warning("GetTextExtentPoint32W: \(Error(win32: GetLastError()))")
      return 0.0
    }
    return Double(size.cy)
  }

  /// The x-height of the font.
  public var xHeight: Double {
    let hDC: DeviceContextHandle =
        DeviceContextHandle(owning: CreateCompatibleDC(nil))
    let _ = SelectObject(hDC.value, self.hFont.value)

    var size: SIZE = SIZE()
    if !GetTextExtentPoint32W(hDC.value, "u{0078}".wide, 1, &size) {
      log.warning("GetTextExtentPoint32W: \(Error(win32: GetLastError()))")
      return 0.0
    }
    return Double(size.cy)
  }

  /// The height, in points, of text lines.
  // public var lineHeight: Double { }

  // MARK - Getting System Font Information

  /// The standard font size, in points, for labels.
  public static var labelFontSize: Double { 17.0 }

  /// The standard font size, in points, for buttons.
  public static var buttonFontSize: Double { 18.0 }

  /// The size, in points, of the standard small system font.
  public static var smallSystemFontSize: Double { 12.0 }

  /// The size, in points, of the standard system font.
  public static var systemFontSize: Double { 14.0 }

  /// Getting Font Descriptors
  // public var fontDescriptor: FontDescriptor { }

  internal init(_ hFont: FontHandle) {
    self.hFont = hFont
  }

  private init(owning hFont: HFONT) {
    self.hFont = FontHandle(owning: hFont)
  }

  private static func systemFont(ofSize fontSize: Double, weight: Font.Weight,
                                 italic bItalic: Bool) -> Font {
    // Windows XP+ default fault name
    var fontName: String = "Segoe UI"

    var metrics: NONCLIENTMETRICSW = NONCLIENTMETRICSW()
    metrics.cbSize = UINT(MemoryLayout<NONCLIENTMETRICSW>.size)
    if SystemParametersInfoW(UINT(SPI_GETNONCLIENTMETRICS),
                             metrics.cbSize, &metrics, 0) {
      fontName = withUnsafePointer(to: metrics.lfMessageFont.lfFaceName) {
        let capacity: Int =
            MemoryLayout.size(ofValue: $0) / MemoryLayout<WCHAR>.size
        return $0.withMemoryRebound(to: UInt16.self, capacity: capacity) {
          String(decodingCString: $0, as: UTF16.self)
        }
      }
    }

    return Font(owning: CreateFontW(PointToLogical(fontSize),
                                    /*cWidth=*/0,
                                    /*cEscapement=*/0,
                                    /*cOrientation=*/0,
                                    weight.rawValue,
                                    bItalic ? 1 : 0,
                                    /*bUnderline=*/DWORD(0),
                                    /*bStrikeOut=*/DWORD(0),
                                    DWORD(DEFAULT_CHARSET),
                                    DWORD(OUT_DEFAULT_PRECIS),
                                    DWORD(CLIP_DEFAULT_PRECIS),
                                    DWORD(DEFAULT_QUALITY),
                                    DWORD((FF_DONTCARE << 2) | DEFAULT_PITCH),
                                    fontName.wide))
  }
}

public extension Font {
  /// Constants that represent standard font weights.
  struct Weight: Hashable, Equatable, RawRepresentable {
    public let rawValue: Int32

    public init(rawValue: Int32) {
      self.rawValue = rawValue
    }
  }
}

public extension Font.Weight {
  static let ultraLight: Font.Weight = Font.Weight(rawValue: FW_ULTRALIGHT)
  static let thin: Font.Weight = Font.Weight(rawValue: FW_THIN)
  static let light: Font.Weight = Font.Weight(rawValue: FW_LIGHT)
  static let regular: Font.Weight = Font.Weight(rawValue: FW_REGULAR)
  static let medium: Font.Weight = Font.Weight(rawValue: FW_MEDIUM)
  static let semibold: Font.Weight = Font.Weight(rawValue: FW_SEMIBOLD)
  static let bold: Font.Weight = Font.Weight(rawValue: FW_BOLD)
  static let heavy: Font.Weight = Font.Weight(rawValue: FW_HEAVY)
  static let black: Font.Weight = Font.Weight(rawValue: FW_BLACK)
}

public extension Font {
  /// Constants that describe the preferred styles for fonts.
  struct TextStyle: Hashable, Equatable, RawRepresentable {
    public let rawValue: String

    public init(rawValue: String) {
      self.rawValue = rawValue
    }
  }
}

public extension Font.TextStyle {
  static let body: Font.TextStyle =
      Font.TextStyle(rawValue: "UICTFontTextStyleBody")
  static let callout: Font.TextStyle =
      Font.TextStyle(rawValue: "UICTFontTextStyleCallout")
  static let caption1: Font.TextStyle =
      Font.TextStyle(rawValue: "UICTFontTextStyleCaption1")
  static let caption2: Font.TextStyle =
      Font.TextStyle(rawValue: "UICTFontTextStyleCaption2")
  static let footnote: Font.TextStyle =
      Font.TextStyle(rawValue: "UICTFontTextStyleFootnote")
  static let headline: Font.TextStyle =
      Font.TextStyle(rawValue: "UICTFontTextStyleHeadline")
  static let subheadline: Font.TextStyle =
      Font.TextStyle(rawValue: "UICTFontTextStyleSubhead")
  static let largeTitle: Font.TextStyle =
      Font.TextStyle(rawValue: "UICTFontTextStyleTitle0")
  static let title1: Font.TextStyle =
      Font.TextStyle(rawValue: "UICTFontTextStyleTitle1")
  static let title2: Font.TextStyle =
      Font.TextStyle(rawValue: "UICTFontTextStyleTitle2")
  static let title3: Font.TextStyle =
      Font.TextStyle(rawValue: "UICTFontTextStyleTitle3")
}
