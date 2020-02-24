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

public class Font {
  internal var hFont: HFONT?

  internal init(hFont: HFONT?) {
    self.hFont = hFont
  }

  public var fontName: String {
    var lfFont: LOGFONTW = LOGFONTW()
    if GetObjectW(self.hFont, Int32(MemoryLayout<LOGFONTW>.size), &lfFont) == 0 {
      print("GetObjectW: \(GetLastError())")
      return ""
    }
    return withUnsafePointer(to: &lfFont.lfFaceName) {
      return $0.withMemoryRebound(to: UInt16.self,
                                  capacity: MemoryLayout.size(ofValue: $0) / MemoryLayout<WCHAR>.size) {
        return String(decodingCString: $0, as: UTF16.self)
      }
    }
  }


  public init?(name: String, size: Float) {
    let szFontSizeEM = -MulDiv(Int32(size), GetDeviceCaps(GetDC(nil), LOGPIXELSY), 72)
    self.hFont = CreateFontW(szFontSizeEM, /*cWidth=*/0,
                             /*cEscapement=*/0, /*cOrientation=*/0,
                             Font.Weight.regular.rawValue,
                             /*bItalic=*/DWORD(0),
                             /*bUnderline=*/DWORD(0),
                             /*bStrikeOut=*/DWORD(0),
                             DWORD(DEFAULT_CHARSET),
                             DWORD(OUT_DEFAULT_PRECIS),
                             DWORD(CLIP_DEFAULT_PRECIS),
                             DWORD(DEFAULT_QUALITY),
                             DWORD((FF_DONTCARE << 2) | DEFAULT_PITCH),
                             name.LPCWSTR)
  }

  deinit {
    // FIXME(compnerd) we need to ensure that the object is destroyed only when
    // the last class reference is removed
    // DeleteObject(hFont)
  }
}

public extension Font {
  public struct Weight: Hashable, Equatable, RawRepresentable {
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
