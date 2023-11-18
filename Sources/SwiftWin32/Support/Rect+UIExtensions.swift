// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK
#if swift(>=5.7)
import CoreGraphics
#endif

extension Rect {
  internal init(from: RECT) {
    self.init(origin: Point(x: from.left, y: from.top),
              size: Size(width: from.right - from.left,
                         height: from.bottom - from.top))
  }
}

extension RECT {
  internal init(from: Rect) {
    self.init(left: LONG(from.origin.x),
              top: LONG(from.origin.y),
              right: LONG(from.origin.x + from.size.width),
              bottom: LONG(from.origin.y + from.size.height))
  }
}

extension Rect {
  internal var center: Point {
    Point(x: self.midX, y: self.midY)
  }
}

extension Rect {
  internal func scaled(for dpi: UINT, style: WindowStyle) -> Rect {
    let scale: Double = Double(dpi) / Double(USER_DEFAULT_SCREEN_DPI)

    var r: RECT =
        RECT(from: self.applying(AffineTransform(scaleX: scale, y: scale)))
    if !AdjustWindowRectExForDpi(&r, style.base, false, style.extended, dpi) {
      log.warning("AdjustWindowRectExForDpi: \(Error(win32: GetLastError()))")
    }

    return Rect(from: r)
  }
}
