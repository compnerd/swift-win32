// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A transformer that generates a modified output color from an input color.
public struct ConfigurationColorTransformer {
  // MARK - Creating a Color Transformer

  /// Creates a color transformer with the specified closure.
  public init(_ transform: @escaping (Color) -> Color) {
    self.transform = transform
  }

  /// Creates a color transformer that generates a grayscale version of the
  /// color.
  public static var grayscale: ConfigurationColorTransformer {
    fatalError("\(#function) not yet implemented")
  }

  /// A color transformer that returns the preferred system accent color.
  public static var preferredTint: ConfigurationColorTransformer {
    fatalError("\(#function) not yet implemented")
  }

  /// A color transformer that returns the color with a monochrome tint.
  public static var monochromeTint: ConfigurationColorTransformer {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Calling the Color Transformer

  /// The transform closure of the color transformer.
  public private(set) var transform: (Color) -> Color

  /// Calls the transform closure of the color transformer.
  public func callAsFunction(_ input: Color) -> Color {
    return self.transform(input)
  }
}
