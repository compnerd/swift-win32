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

extension HFONT__: HandleValue {
  typealias HandleType = HFONT
  internal static func release(_ hFont: HandleType?) {
    if let hFont = hFont {
      DeleteObject(hFont)
    }
  }
}

internal typealias FontHandle = ManagedHandle<HFONT__>

private func PointToLogical(_ points: Float) -> Int32 {
  return -MulDiv(Int32(points), GetDeviceCaps(GetDC(nil), LOGPIXELSY), 72)
}

private func LogicalToPoint(_ logical: Int32) -> Float {
  return Float(MulDiv(-logical, 72, GetDeviceCaps(GetDC(nil), LOGPIXELSY)))
}

public class Font {
  internal var hFont: FontHandle

  internal init(_ hFont: FontHandle) {
    self.hFont = hFont
  }

  private init(owning hFont: HFONT) {
    self.hFont = FontHandle(owning: hFont)
  }

  private static func systemFont(ofSize fontSize: Float, weight: Font.Weight,
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
                                    fontName.LPCWSTR))
  }

  public var fontName: String {
    var lfFont: LOGFONTW = LOGFONTW()

    if GetObjectW(self.hFont.value, Int32(MemoryLayout<LOGFONTW>.size),
                  &lfFont) == 0 {
      log.error("GetObjectW: \(GetLastError())")
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

  /// Getting the Available Font Names
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
      EnumFontsW(hDC, family.LPCWSTR, pfnEnumerateFonts,
                 LPARAM(Int(bitPattern: $0)))
    }
    return Array<String>(arrFonts)
  }

  /// Getting System Font Information
  public static var labelFontSize: Float { 17.0 }
  public static var buttonFontSize: Float { 18.0 }
  public static var smallSystemFontSize: Float { 12.0 }
  public static var systemFontSize: Float { 14.0 }

  /// Creating System Fonts
  public static func systemFont(ofSize fontSize: Float) -> Font {
    return systemFont(ofSize: fontSize, weight: .regular, italic: false)
  }

  public static func systemFont(ofSize fontSize: Float, weight: Font.Weight)
      -> Font {
    return systemFont(ofSize: fontSize, weight: weight, italic: false)
  }

  public static func boldSystemFont(ofSize fontSize: Float) -> Font {
    return systemFont(ofSize: fontSize, weight: .bold, italic: false)
  }

  public static func italicSystemFont(ofSize fontSize: Float) -> Font {
    return systemFont(ofSize: fontSize, weight: .regular, italic: true)
  }

  public static func monospacedSystemFont(ofSize fontSize: Float,
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

  public static func monospacedDigitSystemFont(ofSize fontSize: Float,
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

  /// Creating Fonts
  public static func preferredFont(forTextStyle style: Font.TextStyle) -> Font {
    switch style {
    case .body:
      return systemFont(ofSize: 17)
    case .callout:
      return systemFont(ofSize: 16)
    case .caption1:
      return systemFont(ofSize: 12)
    case .caption2:
      return systemFont(ofSize: 11)
    case .footnote:
      return systemFont(ofSize: 13)
    case .headline:
      return systemFont(ofSize: 17, weight: .semibold)
    case .subheadline:
      return systemFont(ofSize: 15)
    case .largeTitle:
      return systemFont(ofSize: 34)
    case .title1:
      return systemFont(ofSize: 28)
    case .title2:
      return systemFont(ofSize: 22)
    case .title3:
      return systemFont(ofSize: 20)
    default:
      log.warning("unknown text style: \(style) - assuming 12pt system font")
      return systemFont(ofSize: 12)
    }
  }

  public init?(name: String, size: Float) {
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
                                                name.LPCWSTR))
  }
}

public extension Font {
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
