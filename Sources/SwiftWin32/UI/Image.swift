/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK
import SwiftCOM

private let WICImagingFactory: SwiftCOM.IWICImagingFactory? =
    try? IWICImagingFactory.CreateInstance(class: CLSID_WICImagingFactory)
// FIXME(compnerd) we are currently leaking the WICImagingFactory
// defer { WICImagingFactory?.Release() }

/// An object that manages image data in your app.
public class Image {
  private var WICBitmapDecoder: SwiftCOM.IWICBitmapDecoder?
  private var WICBitmapFrame: SwiftCOM.IWICBitmapFrameDecode?
  private var WICFormatConverter: SwiftCOM.IWICFormatConverter?

  internal var bitmap: SwiftCOM.IWICBitmapSource? { WICFormatConverter }

  // MARK - Creating and Initializing Image Objects

  /// Initializes and returns the image object with the contents of the
  /// specified file.
  public init?(contentsOfFile path: String) {
    guard let WICImagingFactory = WICImagingFactory else { return nil }

    do {
      self.WICBitmapDecoder =
          try WICImagingFactory.CreateDecoderFromFilename(path, nil, GENERIC_READ,
                                                          WICDecodeMetadataCacheOnDemand)

      // TODO(compnerd) figure out how to handle multi-frame images
      let frames = try self.WICBitmapDecoder?.GetFrameCount()

      self.WICBitmapFrame = try self.WICBitmapDecoder?.GetFrame(frames! - 1)

      self.WICFormatConverter = try WICImagingFactory.CreateFormatConverter()
      try self.WICFormatConverter?.Initialize(WICBitmapFrame!,
                                              GUID_WICPixelFormat32bppBGRA,
                                              WICBitmapDitherTypeNone, nil, 0.0,
                                              WICBitmapPaletteTypeCustom)
    } catch {
      log.error("\(#function): \(error)")
      return nil
    }
  }

  deinit {
    _ = try? self.WICFormatConverter?.Release()
    _ = try? self.WICBitmapFrame?.Release()
    _ = try? self.WICBitmapDecoder?.Release()
  }

  // MARK - Getting the Image Size and Scale

  /// The scale factor of the image.
  public var scale: Float {
    1.0
  }

  /// The logical dimensions, in points, for the image.
  public var size: Size {
    guard let ImageSize: (UINT, UINT) = try? self.WICBitmapFrame?.GetSize() else {
      return .zero
    }
    return Size(width: Double(ImageSize.0), height: Double(ImageSize.1))
  }
}
