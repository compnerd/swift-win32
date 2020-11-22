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
  /// The default typeface for an app's user interface.
  public static var `default`: FontDescriptor.SystemDesign {
    FontDescriptor.SystemDesign(rawValue: "default")
  }

  /// The monospace variant of the default typeface.
  public static var monospaced: FontDescriptor.SystemDesign {
    FontDescriptor.SystemDesign(rawValue: "monospaced")
  }

  /// The rounded variant of the default typeface.
  public static var rounded: FontDescriptor.SystemDesign {
    FontDescriptor.SystemDesign(rawValue: "rounded")
  }

  /// The serif variant of the default typeface.
  public static var serif: FontDescriptor.SystemDesign {
    FontDescriptor.SystemDesign(rawValue: "serif")
  }
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
  /// The font's style is italic.
  public static var traitItalic: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 1 << 0)
  }

  /// The font's style is bold.
  public static var traitBold: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 1 << 1)
  }

  /// The font's characters have an expanded width.
  public static var traitExpanded: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 1 << 5)
  }

  /// The font's characters have a condensed width.
  public static var traitCondensed: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 1 << 6)
  }

  /// The font's characters all have the same width.
  public static var traitMonoSpace: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 1 << 10)
  }

  /// The font uses vertical glyph variants and metrics.
  public static var traitVertical: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 1 << 11)
  }

  /// The font synthesizes appropriate attributes for user interface rendering,
  /// such as in control titles, if necessary.
  public static var traitUIOptimized: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 1 << 12)
  }

  /// The font uses a leading value that's less than the default.
  public static var traitTightLeading: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 1 << 15)
  }

  /// The font uses a leading value that’s greater than the default.
  public static var traitLooseLeading: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 1 << 16)
  }


  /// The font family class mask that you use to access font descriptor values.
  public static var classMask: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 15 << 28)
  }

  /// The font's characters include serifs, and reflect the Latin printing style
  /// of the 15th to 17th centuries.
  public static var classOldStyleSerifs: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 1 << 28)
  }

  /// The font's characters include serifs, and reflect the Latin printing style
  /// of the 18th to 19th centuries.
  public static var classTransitionalSerifs: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 2 << 28)
  }

  /// The font's characters include serifs, and reflect the Latin printing style
  /// of the 20th century.
  public static var classModernSerifs: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 3 << 28)
  }

  /// The font's characters include variations of old style and transitional
  /// serifs.
  public static var classClarendonSerifs: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 4 << 28)
  }

  /// The font's characters use square transitions, without brackets, between
  /// strokes and serifs.
  public static var classSlabSerifs: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 5 << 28)
  }

  /// The font's characters include serifs, and don’t generally fit within other
  /// serif design classifications.
  public static var classFreeformSerifs: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 7 << 28)
  }

  /// The font's characters don’t have serifs.
  public static var classSansSerif: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 8 << 28)
  }

  /// The font's characters use highly decorated or stylized character shapes.
  public static var classOrnamentals: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 9 << 28)
  }

  /// The font's characters simulate handwriting.
  public static var classScripts: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 10 << 28)
  }

  /// The font's characters consist mainly of symbols rather than letters and
  /// numbers.
  public static var classSymbolic: FontDescriptor.SymbolicTraits {
    FontDescriptor.SymbolicTraits(rawValue: 12 << 28)
  }
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
  /// The cascading list attribute.
  public static var cascadeList: FontDescriptor.AttributeName {
    FontDescriptor.AttributeName(rawValue: "NSCTFontCascadeListAttribute")
  }

  /// The character set attribute.
  public static var characterSet: FontDescriptor.AttributeName {
    FontDescriptor.AttributeName(rawValue: "NSCTFontCharacterSetAttribute")
  }

  /// The font face attribute.
  public static var face: FontDescriptor.AttributeName {
    FontDescriptor.AttributeName(rawValue: "NSCTFontFaceAttribute")
  }

  /// The font family attribute.
  public static var family: FontDescriptor.AttributeName {
    FontDescriptor.AttributeName(rawValue: "NSCTFontFamilyAttribute")
  }

  /// The font feature settings attribute.
  public static var featureSettings: FontDescriptor.AttributeName {
    FontDescriptor.AttributeName(rawValue: "NSCTFontFeatureSettingsAttribute")
  }

  /// The glyph advancement attribute.
  public static var fixedAdvance: FontDescriptor.AttributeName {
    FontDescriptor.AttributeName(rawValue: "NSCTFontFixedAdvanceAttribute")
  }

  /// The font's transformation matrix attribute.
  public static var matrix: FontDescriptor.AttributeName {
    FontDescriptor.AttributeName(rawValue: "NSCTFontMatrixAttribute")
  }

  /// The font name attribute.
  public static var name: FontDescriptor.AttributeName {
    FontDescriptor.AttributeName(rawValue: "NSCTFontNameAttribute")
  }

  /// The font size attribute.
  public static var size: FontDescriptor.AttributeName {
    FontDescriptor.AttributeName(rawValue: "NSCTFontSizeAttribute")
  }

  /// The font's stylistic properties attribute.
  public static var symbolic: FontDescriptor.AttributeName {
    FontDescriptor.AttributeName(rawValue: "NSCTFontSymbolicAttribute")
  }

  /// The text style attribute.
  public static var textStyle: FontDescriptor.AttributeName {
    FontDescriptor.AttributeName(rawValue: "NSCTFontTextStyleAttribute")
  }

  /// The font traits dictionary attribute.
  public static var traits: FontDescriptor.AttributeName {
    FontDescriptor.AttributeName(rawValue: "NSCTFontTraitsAttribute")
  }

  /// The font's visible name attribute.
  public static var visibleName: FontDescriptor.AttributeName {
    FontDescriptor.AttributeName(rawValue: "NSCTFontVisibleNameAttribute")
  }
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
  /// A key for identifying a font feature type such as ligature or character
  /// shape.
  public static var featureIdentifier: FontDescriptor.FeatureKey {
    FontDescriptor.FeatureKey(rawValue: "CTFeatureTypeIdentifier")
  }

  /// A key for identifying the font feature selector.
  public static var typeIdentifier: FontDescriptor.FeatureKey {
    FontDescriptor.FeatureKey(rawValue: "CTFeatureSelectorIdentifier")
  }
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
  /// The relative slant angle of the font.
  public static var slant: FontDescriptor.TraitKey {
    FontDescriptor.TraitKey(rawValue: "NSCTFontSlantTrait")
  }

  /// The symbolic font traits.
  public static var symbolic: FontDescriptor.TraitKey {
    FontDescriptor.TraitKey(rawValue: "NSCTFontSymbolicTrait")
  }

  /// The normalized font weight.
  public static var weight: FontDescriptor.TraitKey {
    FontDescriptor.TraitKey(rawValue: "NSCTFontWeightTrait")
  }

  /// The inter-glyph spacing of the font.
  public static var width: FontDescriptor.TraitKey {
    FontDescriptor.TraitKey(rawValue: "NSCTFontWidthTrait")
  }
}
