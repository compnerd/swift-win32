/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// A collection of attributes that describes a font.
public class FontDescriptor {
  /// Constants that classify certain stylistic qualities of the font.
  public typealias Class = Int

  /// Creating a Font Descriptor

  /// Returns a font descriptor that contains the specified text style and the
  /// user's selected content size category.
  public static func preferredFontDescriptor(withTextStyle style: Font.TextStyle)
      -> FontDescriptor {
    return preferredFontDescriptor(withTextStyle: style,
                                   compatibleWith: TraitCollection.current)
  }

  /// Returns a font descriptor that contains the text style and the content
  /// size category the provided trait collection specifies.
  public static func preferredFontDescriptor(withTextStyle style: Font.TextStyle,
                                             compatibleWith traitCollection: TraitCollection?)
      -> FontDescriptor {
    fatalError("\(#function) not yet implemented")
  }

  /// Returns a font descriptor with the specified values for name and matrix
  /// dictionary attributes.
  public init(name fontName: String, matrix: AffineTransform) {
    self.fontAttributes = [.name: fontName, .matrix: matrix]
  }

  /// Returns a font descriptor with the specified values for the name and size
  /// dictionary attributes.
  public init(name fontName: String, size: Double) {
    self.fontAttributes = [.name: fontName, .size: size]
  }

  /// Returns a new font descriptor that is the same as the existing descriptor,
  /// but with the specified attributes taking precedence over the existing
  /// ones.
  public func addingAttributes(_ attributes: [FontDescriptor.AttributeName:Any] = [:])
      -> FontDescriptor {
    let descriptor: FontDescriptor = self
    descriptor.fontAttributes.merge(attributes,
                                    uniquingKeysWith: { (_, new) in new })
    return descriptor
  }

  /// Returns a new font descriptor that is the same as the existing descriptor,
  /// but with the specified design.
  public func withDesign(_ design: FontDescriptor.SystemDesign)
      -> FontDescriptor? {
    fatalError("\(#function) not yet implemented")
  }

  /// Returns a new font descriptor that is the same as the existing descriptor,
  /// but with the specified family.
  public func withFamily(_ newFamily: String) -> FontDescriptor {
    let descriptor: FontDescriptor = self
    _ = descriptor.fontAttributes.removeValue(forKey: .name)
    descriptor.fontAttributes[.family] = newFamily
    return descriptor
  }

  /// Returns a new font descriptor that is the same as the existing descriptor,
  /// but with the specified font face.
  public func withFace(_ newFace: String) -> FontDescriptor {
    let descriptor: FontDescriptor = self
    descriptor.fontAttributes[.face] = newFace
    return descriptor
  }

  /// Returns a new font descriptor that is the same as the existing descriptor,
  /// but with the specified matrix.
  public func withMatrix(_ matrix: AffineTransform) -> FontDescriptor {
    let descriptor: FontDescriptor = self
    descriptor.fontAttributes[.matrix] = matrix
    return descriptor
  }

  /// Returns a new font descriptor that is the same as the existing descriptor,
  /// but with the specified size.
  public func withSize(_ newPointSize: Double) -> FontDescriptor {
    let descriptor: FontDescriptor = self
    descriptor.fontAttributes[.size] = newPointSize
    return descriptor
  }

  /// Returns a new font descriptor that is the same as the existing descriptor,
  /// but with the specified symbolic traits.
  public func withSymbolicTraits(_ symbolicTraits: FontDescriptor.SymbolicTraits)
      -> FontDescriptor? {
    let descriptor: FontDescriptor = self
    descriptor.fontAttributes[.symbolic] = symbolicTraits
    return descriptor
  }

  /// Initializing a Font Descriptor

  /// Creates a font descriptor with the specified attributes.
  public init(fontAttributes attributes: [FontDescriptor.AttributeName:Any] = [:]) {
    self.fontAttributes = attributes
  }

  /// Finding Fonts

  /// Returns all the fonts available in the system with the specified
  /// attributes.
  public func matchingFontDescriptors(withMandatoryKeys mandatoryKeys: Set<FontDescriptor.AttributeName>?)
      -> [FontDescriptor] {
    fatalError("\(#function) not yet implemented")
  }

  /// Querying a Font Descriptor

  /// The font descriptor's dictionary of attributes.
  public private(set) var fontAttributes: [FontDescriptor.AttributeName:Any] = [:]

  /// The current transform matrix of the font decriptor.
  public var matrix: AffineTransform {
    guard let transform = self.object(forKey: .matrix) as? AffineTransform else {
      log.warning("FontDescriptor missing attribute: .matrix")
      return .identity
    }
    return transform
  }

  /// The point size of the font descriptor.
  public var pointSize: Double {
    guard let size = self.object(forKey: .size) as? Double else {
      log.warning("FontDescriptor missing attribute: .size")
      return 0.0
    }
    return size
  }

  /// The PostScript name of the font descriptor.
  public var postscriptName: String {
    guard let name = self.object(forKey: .name) as? String else {
      log.error("FontDescriptor missing attribute: .name")
      return ""
    }
    return name
  }

  /// The traits of the font descriptor.
  public var symbolicTraits: FontDescriptor.SymbolicTraits {
    guard let traits = self.object(forKey: .symbolic) as? FontDescriptor.SymbolicTraits else {
      log.warning("FontDescriptor missing attribute: .symbolic")
      return FontDescriptor.SymbolicTraits(rawValue: 0)
    }
    return traits
  }

  public func object(forKey attribute: FontDescriptor.AttributeName) -> Any? {
    return self.fontAttributes[attribute]
  }
}

extension FontDescriptor {
  /// Constants that describe the system-defined typeface designs.
  public struct SystemDesign: Hashable, Equatable, RawRepresentable {
    public typealias RawValue = String

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension FontDescriptor.SystemDesign {
  public static let `default`: FontDescriptor.SystemDesign =
        FontDescriptor.SystemDesign(rawValue: "default")
  public static let monospaced: FontDescriptor.SystemDesign =
        FontDescriptor.SystemDesign(rawValue: "monospaced")
  public static let rounded: FontDescriptor.SystemDesign =
        FontDescriptor.SystemDesign(rawValue: "rounded")
  public static let serif: FontDescriptor.SystemDesign =
        FontDescriptor.SystemDesign(rawValue: "serif")
}

extension FontDescriptor {
  /// Constants that describe the stylistic aspects of a font.
  public struct SymbolicTraits: OptionSet {
    public typealias RawValue = UInt32

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension FontDescriptor.SymbolicTraits {
  public static let traitItalic: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 1 << 0)
  public static let traitBold: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 1 << 1)
  public static let traitExpanded: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 1 << 5)
  public static let traitCondensed: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 1 << 6)
  public static let traitMonoSpace: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 1 << 10)
  public static let traitVertical: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 1 << 11)
  public static let traitUIOptimized: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 1 << 12)
  public static let traitTightLeading: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 1 << 15)
  public static let traitLooseLeading: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 1 << 16)

  public static let classMask: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 15 << 28)
  public static let classOldStyleSerifs: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 1 << 28)
  public static let classTransitionalSerifs: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 2 << 28)
  public static let classModernSerifs: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 3 << 28)
  public static let classClarendonSerifs: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 4 << 28)
  public static let classSlabSerifs: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 5 << 28)
  public static let classFreeformSerifs: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 7 << 28)
  public static let classSansSerif: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 8 << 28)
  public static let classOrnamentals: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 9 << 28)
  public static let classScripts: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 10 << 28)
  public static let classSymbolic: FontDescriptor.SymbolicTraits =
      FontDescriptor.SymbolicTraits(rawValue: 12 << 28)
}

extension FontDescriptor {
  /// Constants that describe font attributes.
  public struct AttributeName: Equatable, Hashable, RawRepresentable {
    public typealias RawValue = String

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension FontDescriptor.AttributeName {
  public static let cascadeList: FontDescriptor.AttributeName =
      FontDescriptor.AttributeName(rawValue: "NSCTFontCascadeListAttribute")
  public static let characterSet: FontDescriptor.AttributeName =
      FontDescriptor.AttributeName(rawValue: "NSCTFontCharacterSetAttribute")
  public static let face: FontDescriptor.AttributeName =
      FontDescriptor.AttributeName(rawValue: "NSCTFontFaceAttribute")
  public static let family: FontDescriptor.AttributeName =
      FontDescriptor.AttributeName(rawValue: "NSCTFontFamilyAttribute")
  public static let featureSettings: FontDescriptor.AttributeName =
      FontDescriptor.AttributeName(rawValue: "NSCTFontFeatureSettingsAttribute")
  public static let fixedAdvance: FontDescriptor.AttributeName =
      FontDescriptor.AttributeName(rawValue: "NSCTFontFixedAdvanceAttribute")
  public static let matrix: FontDescriptor.AttributeName =
      FontDescriptor.AttributeName(rawValue: "NSCTFontMatrixAttribute")
  public static let name: FontDescriptor.AttributeName =
      FontDescriptor.AttributeName(rawValue: "NSCTFontNameAttribute")
  public static let size: FontDescriptor.AttributeName =
      FontDescriptor.AttributeName(rawValue: "NSCTFontSizeAttribute")
  public static let symbolic: FontDescriptor.AttributeName =
      FontDescriptor.AttributeName(rawValue: "NSCTFontSymbolicAttribute")
  public static let textStyle: FontDescriptor.AttributeName =
      FontDescriptor.AttributeName(rawValue: "NSCTFontTextStyleAttribute")
  public static let traits: FontDescriptor.AttributeName =
      FontDescriptor.AttributeName(rawValue: "NSCTFontTraitsAttribute")
  public static let visibleName: FontDescriptor.AttributeName =
      FontDescriptor.AttributeName(rawValue: "NSCTFontVisibleNameAttribute")
}

extension FontDescriptor {
  /// Keys for retrieving feature settings.
  public struct FeatureKey: Equatable, Hashable, RawRepresentable {
    public typealias RawValue = String

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension FontDescriptor.FeatureKey {
  public init(_ rawValue: RawValue) {
    self.rawValue = rawValue
  }
}

extension FontDescriptor.FeatureKey {
  public static let featureIdentifier: FontDescriptor.FeatureKey =
      FontDescriptor.FeatureKey(rawValue: "CTFeatureTypeIdentifier")
  public static let typeIdentifier: FontDescriptor.FeatureKey =
      FontDescriptor.FeatureKey(rawValue: "CTFeatureSelectorIdentifier")
}

extension FontDescriptor {
  // Keys for retrieving the font descriptor's trait information.
  public struct TraitKey: Equatable, Hashable, RawRepresentable {
    public typealias RawValue = String

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension FontDescriptor.TraitKey {
  public static let slant: FontDescriptor.TraitKey =
      FontDescriptor.TraitKey(rawValue: "NSCTFontSlantTrait")
  public static let symbolic: FontDescriptor.TraitKey =
      FontDescriptor.TraitKey(rawValue: "NSCTFontSymbolicTrait")
  public static let weight: FontDescriptor.TraitKey =
      FontDescriptor.TraitKey(rawValue: "NSCTFontWeightTrait")
  public static let width: FontDescriptor.TraitKey =
      FontDescriptor.TraitKey(rawValue: "NSCTFontWidthTrait")
}
