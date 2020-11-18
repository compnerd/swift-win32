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

public class Image {
  private var WICBitmapDecoder: SwiftCOM.IWICBitmapDecoder?
  private var WICBitmapFrame: SwiftCOM.IWICBitmapFrameDecode?
  private var WICFormatConverter: SwiftCOM.IWICFormatConverter?

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
}
