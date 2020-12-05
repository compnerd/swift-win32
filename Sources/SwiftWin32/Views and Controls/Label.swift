/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

private let SwiftLabelProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let label: Label? = unsafeBitCast(dwRefData, to: AnyObject.self) as? Label

  switch uMsg {
  case UINT(WM_LBUTTONUP):
    label?.sendActions(for: .primaryActionTriggered)
  default:
    break
  }

  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

public class Label: Control {
  private static let `class`: WindowClass =
      WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.Label")
  private static let style: WindowStyle = (base: WS_TABSTOP, extended: 0)

  private var staticHWnd: HWND!

  public var text: String? {
    get {
      let szLength: Int32 = GetWindowTextLengthW(self.staticHWnd)
      let buffer: [WCHAR] = Array<WCHAR>(unsafeUninitializedCapacity: Int(szLength) + 1) {
        $1 = Int(GetWindowTextW(self.staticHWnd, $0.baseAddress!, CInt($0.count)))
      }
      return String(decodingCString: buffer, as: UTF16.self)
    }
    set(value) { _ = SetWindowTextW(self.staticHWnd, value?.wide) }
  }

  public override var font: Font! {
    didSet {
      SendMessageW(self.staticHWnd, UINT(WM_SETFONT),
                   unsafeBitCast(self.font?.hFont.value, to: WPARAM.self),
                   LPARAM(1))
    }
  }

  public override var frame: Rect {
    didSet {
      let rect = GetRect(hWnd: self.hWnd)
      _ = SetWindowPos(self.staticHWnd, nil,
                       CInt(rect.origin.x), CInt(rect.origin.y),
                       CInt(rect.size.width), CInt(rect.size.height),
                       UINT(SWP_NOZORDER | SWP_FRAMECHANGED))
    }
  }

  public init(frame: Rect) {
    super.init(frame: frame, class: Label.class, style: Label.style)
    _ = SetWindowSubclass(hWnd, SwiftLabelProc, UINT_PTR(1),
                         unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))

    let rect = GetRect(hWnd: self.hWnd)
    self.staticHWnd = CreateWindowExW(0, WC_STATIC.wide, nil, 0,
                                      0, 0,
                                      Int32(rect.size.width),
                                      Int32(rect.size.height),
                                      nil, nil, GetModuleHandleW(nil), nil)!

    _ = SetWindowLongW(self.staticHWnd, WinSDK.GWL_STYLE, WS_CHILD)
    _ = SetParent(self.staticHWnd, self.hWnd)

    self.font = Font.systemFont(ofSize: Font.systemFontSize)
  }

  deinit {
    DestroyWindow(self.staticHWnd)
  }

  // ContentSizeCategoryAdjusting
  public var adjustsFontForContentSizeCategory = false

  // TraitEnvironment
  override public func traitCollectionDidChange(_ previousTraitCollection: TraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    guard self.adjustsFontForContentSizeCategory else { return }
    self.font = FontMetrics.default.scaledFont(for: self.font,
                                               compatibleWith: traitCollection)
  }
}

extension Label: ContentSizeCategoryAdjusting {
}
