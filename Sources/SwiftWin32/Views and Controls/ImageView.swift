/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK
import SwiftCOM

extension BitmapHandle {
  fileprivate convenience init?(from pBitmap: SwiftCOM.IWICBitmapSource?,
                                hWnd: HWND? = nil) {
    guard let pBitmap = pBitmap,
          let size: (UINT, UINT) = try? pBitmap.GetSize() else {
      return nil
    }

    var bmiBitmap: BITMAPINFO = BITMAPINFO()
    bmiBitmap.bmiHeader.biSize = DWORD(MemoryLayout<BITMAPINFOHEADER>.size)
    bmiBitmap.bmiHeader.biWidth = LONG(size.0)
    bmiBitmap.bmiHeader.biHeight = -LONG(size.1)
    bmiBitmap.bmiHeader.biPlanes = 1
    bmiBitmap.bmiHeader.biBitCount = 32
    bmiBitmap.bmiHeader.biCompression = DWORD(BI_RGB)

    let hDC: DeviceContextHandle = DeviceContextHandle(owning: GetDC(hWnd))

    var pvImageBits: UnsafeMutableRawPointer?
    guard let DIB = CreateDIBSection(hDC.value, &bmiBitmap, UINT(DIB_RGB_COLORS),
                                     &pvImageBits, nil, 0) else { return nil }
    self.init(owning: DIB)

    let nStride: Int = (((Int(size.0) * 32) + 31) & ~31) >> 3
    let nImage: Int = nStride * Int(size.1)

    let pBuffer: UnsafeMutablePointer<BYTE>? =
        pvImageBits?.bindMemory(to: BYTE.self, capacity: nImage)
    let pbBuffer: UnsafeMutableBufferPointer<BYTE> =
        UnsafeMutableBufferPointer<BYTE>(start: pBuffer, count: nImage)

    try? pBitmap.CopyPixels(nil, UINT(nStride), pbBuffer)
  }
}

/// An object that displays a single image or a sequence of animated images in
/// your interface.
public class ImageView: View {
  private static let `class`: WindowClass = WindowClass(named: WC_STATIC)
  private static let style: WindowStyle =
      (base: WS_POPUP | DWORD(SS_BITMAP), extended: 0)

  private var hBitmap: BitmapHandle?

  // MARK - Creating an Image View

  /// Returns an image view initialized with the specified image.
  public init(image: Image?) {
    self.image = image

    super.init(frame: Rect(origin: .zero, size: self.image?.size ?? .zero),
               class: ImageView.class, style: ImageView.style)

    self.hBitmap = BitmapHandle(from: self.image?.bitmap, hWnd: self.hWnd)
    _ = SendMessageW(self.hWnd, UINT(STM_SETIMAGE), WPARAM(IMAGE_BITMAP),
                     unsafeBitCast(self.hBitmap?.value, to: LPARAM.self))
  }

  /// Returns an image view initialized with the specified regular and
  /// highlighted images.
  public init(image: Image?, highlightedImage: Image?) {
    self.image = image
    self.highlightedImage = highlightedImage

    super.init(frame: Rect(origin: .zero, size: self.image?.size ?? .zero),
               class: ImageView.class, style: ImageView.style)

    self.hBitmap = BitmapHandle(from: self.image?.bitmap, hWnd: self.hWnd)
    _ = SendMessageW(self.hWnd, UINT(STM_SETIMAGE), WPARAM(IMAGE_BITMAP),
                     unsafeBitCast(self.hBitmap?.value, to: LPARAM.self))
  }

  // MARK - Accessing the Displayed Images

  /// The image displayed in the image view.
  public var image: Image?

  /// The highlighted image displayed in the image view.
  public var highlightedImage: Image?

  // ContentSizeCategoryImageAdjusting
  public var adjustsImageSizeForAccessibilityContentSizeCategory = false
}

extension ImageView: ContentSizeCategoryImageAdjusting {
}
