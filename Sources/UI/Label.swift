/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

public class Label: Control {
  private static let `class`: WindowClass = WindowClass(named: WC_STATIC)
  private static let style: WindowStyle = (base: DWORD(WS_TABSTOP), extended: 0)

  public override var font: Font! {
    get { return super.font }
    set(value) { super.font = value }
  }

  @_Win32WindowText
  public var text: String?

  public init(frame: Rect) {
    super.init(frame: frame, class: Label.class, style: Label.style)
  }

  // ContentSizeCategoryAdjusting
  public var adjustsFontForContentSizeCategory = false
}

extension Label: ContentSizeCategoryAdjusting {
}
