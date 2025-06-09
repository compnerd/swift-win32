// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK
import SwiftCOM

#if swift(>=5.7)
import CoreGraphics
#endif

private let WICImagingFactory: SwiftCOM.IWICImagingFactory? =
    try? IWICImagingFactory.CreateInstance(class: CLSID_WICImagingFactory2)

extension Image {
  /// A configuration object that contains the traits that the system uses when
  /// selecting the current image variant.
  public class Configuration {
    // MARK - Modifying a Configuration Object

    /// Returns a configuration object that applies the specified configuration
    /// values on top of the current object's values.
    public func applying(_ otherConfiguration: Image.Configuration?) -> Self {
      fatalError("\(#function) not yet implemented")
    }

    /// Returns a new configuration object that merges the current traits with
    /// the traits from the specified trait collection.
    public func withTraitCollection(_ traitCollection: TraitCollection?) -> Self {
      fatalError("\(#function) not yet implemented")
    }

    // MARK - Getting the Configuration Traits

    /// The traits associated with the image configuration.
    public private(set) var traitCollection: TraitCollection?
  }
}

extension Image {
  /// Constants that indicate which weight variant of a symbol image to use.
  public enum SymbolWeight: Int {
    // MARK - Symbol Image Weights

    /// An unspecified symbol image weight.
    case unspecified

    /// An ultralight weight.
    case ultraLight

    /// A thin weight
    case thin

    /// A light weight.
    case light

    /// A regular weight.
    case regular

    /// A medium weight.
    case medium

    /// A semibold weight.
    case semibold

    /// A bold weight.
    case bold

    /// A heavy weight.
    case heavy

    /// An ultra-heavy weight.
    case black
  }
}

extension Image.SymbolWeight {
  // MARK - Getting the Font Weight

  /// The font weight for the specified symbol weight.
  public func fontWeight() -> Font.Weight {
    fatalError("\(#function) not yet implemented")
  }
}

extension Image {
  public enum SymbolScale: Int {
    // MARK - Symbol Image Scales

    /// The default scale variant that matches the system usage.
    case `default`

    /// An unspecified scale.
    case unspecified

    /// The small variant of the symbol image.
    case small

    /// The medium variant of the symbol image.
    case medium

    /// The large variant of the symbol image.
    case large
  }
}

extension Image {
  /// An object that contains the specific font, size, style, and weight
  /// attributes to apply to a symbol image.
  public class SymbolConfiguration: Image.Configuration {
    // MARK - Creating a Symbol Configuration Object

    /// Creates a configuration object with the specified point-size information.
    public convenience init(pointSize: Double) {
      self.init(pointSize: pointSize, weight: .regular)
    }

    /// Creates a configuration object with the specified point-size and weight
    /// information.
    public convenience init(pointSize: Double, weight: Image.SymbolWeight) {
      self.init(pointSize: pointSize, weight: .regular, scale: .default)
    }

    /// Creates a configuration object with the specified point-size, weight,
    /// and scale information.
    public convenience init(pointSize: Double, weight: Image.SymbolWeight,
                            scale: Image.SymbolScale) {
      fatalError("\(#function) not yet implemented")
    }

    /// Creates a configuration object with the specified scale information.
    public convenience init(scale: Image.SymbolScale) {
      fatalError("\(#function) not yet implemented")
    }

    /// Creates a configuration object with the specified font text style
    /// information.
    public convenience init(textStyle: Font.TextStyle) {
      self.init(textStyle: textStyle, scale: .default)
    }

    /// Creates a configuration object with the specified font text style and
    /// scale information.
    public convenience init(textStyle: Font.TextStyle,
                            scale: Image.SymbolScale) {
      fatalError("\(#function) not yet implemented")
    }

    /// Creates a configuration object with the specified weight information.
    public convenience init(weight: Image.SymbolWeight) {
      fatalError("\(#function) not yet implemented")
    }

    /// Creates a configuration object with the specified font information.
    public convenience init(font: Font) {
      self.init(font: font, scale: .default)
    }

    /// Creates a configuration object with the specified font and scale
    /// information.
    public convenience init(font: Font, scale: Image.SymbolScale) {
      fatalError("\(#function) not yet implemented")
    }

    // MARK - Getting an Unspecified Configuration

    /// A symbol configuration object that contains unspecified values for all
    /// attributes.
    public class var unspecified: Image.SymbolConfiguration {
      fatalError("\(#function) not yet implemented")
    }

    // MARK - Removing Configuration Attributes

    /// Returns a copy of the current symbol configuration object without
    /// point-size and weight information.
    public func configurationWithoutPointSizeAndWeight() -> Self {
      fatalError("\(#function) not yet implemented")
    }

    /// Returns a copy of the current symbol configuration object without scale
    /// information.
    public func configurationWithoutScale() -> Self {
      fatalError("\(#function) not yet implemented")
    }

    /// Returns a copy of the current symbol configuration object without font
    /// text style information.
    public func configurationWithoutTextStyle() -> Self {
      fatalError("\(#function) not yet implemented")
    }

    /// Returns a copy of the current symbol configuration object without weight
    /// information.
    public func configurationWithoutWeight() -> Self {
      fatalError("\(#function) not yet implemented")
    }

    // MARK - Comparing Symbol Image Configurations

    /// Returns a boolean value that indicates whether the configuration objects
    /// are equivalent.
    public func isEqual(to otherConfiguration: Image.SymbolConfiguration?)
        -> Bool {
      fatalError("\(#function) not yet implemented")
    }
  }
}

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
