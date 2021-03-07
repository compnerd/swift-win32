/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

public class FontMetrics {
  /// Creating a Font Metrics Object

  /// Creates a font metrics object for the specified text style.
  public init (forTextStyle style: Font.TextStyle) {
  }

  /// The default font metrics object for content.
  public static let `default`: FontMetrics = FontMetrics(forTextStyle: .body)

  /// Creating Scaled Fonts

  /// Returns a version of the specified font that adopts the current font
  /// metrics.
  public func scaledFont(for font: Font) -> Font {
    return scaledFont(for: font, compatibleWith: nil)
  }

  /// Returns a version of the specified font that adopts the current font
  /// metrics and suports the specified traitss.
  public func scaledFont(for font: Font,
                         compatibleWith traitCollection: TraitCollection?)
      -> Font {
    return scaledFont(for: font, maximumPointSize: Double.greatestFiniteMagnitude,
                      compatibleWith: traitCollection)
  }

  /// Returns a version of the specified font that adopts the current font
  /// metrics and is constrained to the specified maximum size.
  public func scaledFont(for font: Font, maximumPointSize: Double) -> Font {
    return scaledFont(for: font, maximumPointSize: maximumPointSize,
                      compatibleWith: nil)
  }

  /// Returns a version of the specified font that adopts the current font
  /// metrics and is constrained to the specified traits and size.
  public func scaledFont(for font: Font, maximumPointSize: Double,
                         compatibleWith traitCollection: TraitCollection?)
      -> Font {
    let _ = traitCollection ?? TraitCollection.current
    // TODO(compnerd) adjust the font size for the trait collection and cap the
    // size.
    fatalError("\(#function) not yet implemented")
  }
}
