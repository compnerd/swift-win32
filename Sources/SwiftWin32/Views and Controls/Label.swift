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
  private static let `class`: WindowClass = WindowClass(named: WC_STATIC)
  private static let style: WindowStyle = (base: WS_TABSTOP | DWORD(SS_NOTIFY), extended: 0)

  public override var font: Font! {
    get { return super.font }
    set(value) { super.font = value }
  }

  @_Win32WindowText
  public var text: String?

  public init(frame: Rect) {
    super.init(frame: frame, class: Label.class, style: Label.style)
    _ = SetWindowSubclass(hWnd, SwiftLabelProc, UINT_PTR(1),
                         unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
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
