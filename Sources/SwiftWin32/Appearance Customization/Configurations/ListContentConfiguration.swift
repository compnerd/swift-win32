// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import class Foundation.NSAttributedString

extension ListContentConfiguration {
  /// Properties that affect the list content configuration's image.
  public struct ImageProperties {
    internal init() {
      // FIXME how do we intialize the value of `cornerRadius`?
      self.cornerRadius = 0.0
    }

    // MARK - Configuring Image Properties

    /// The symbol configuration to use.
    public var preferredSymbolConfiguration: Image.SymbolConfiguration?

    /// The tint color to apply to the image view.
    public var tintColor: Color?

    /// The color transformer for resolving the tint color.
    public var tintColorTransformer: ConfigurationColorTransformer?

    /// Generates the resolved tint color for the specified tint color, using
    /// the tint color and color transformer.
    public func resolvedTintColor(for tintColor: Color) -> Color {
      fatalError("\(#function) not yet implemented")
    }

    /// The preferred corner radius, using a continuous corner curve, for the
    /// image.
    public var cornerRadius: Double

    /// The maximum size for the image.
    public var maximumSize: Size = .zero

    /// The layout size that the system reserves for the image, and then centers
    /// the image within.
    public var reservedLayoutSize: Size = .zero

    /// The system standard layout dimension for reserved layout size.
    public static var standardDimension: Double {
      .greatestFiniteMagnitude
    }

    /// A boolean value that determines whether the image inverts its colors
    /// when the user turns on the Invert Colors accessibility setting.
    public var accessibilityIgnoresInvertColors: Bool = false
  }
}

// MARK - Comparing Image Properties

extension ListContentConfiguration.ImageProperties: Hashable {
  public static func ==(_ lhs: ListContentConfiguration.ImageProperties,
                        _ rhs: ListContentConfiguration.ImageProperties)
      -> Bool {
    fatalError("\(#function) not yet implemented")
  }

  public func hash(into hasher: inout Hasher) {
    fatalError("\(#function) not yet implemented")
  }
}

// MARK - Describing Image Properties

extension ListContentConfiguration.ImageProperties: CustomStringConvertible {
  public var description: String {
    fatalError("\(#function) not yet implemented")
  }
}

extension ListContentConfiguration.ImageProperties: CustomDebugStringConvertible {
  public var debugDescription: String {
    fatalError("\(#function) not yet implemented")
  }
}

extension ListContentConfiguration.ImageProperties: CustomReflectable {
  public var customMirror: Mirror {
    fatalError("\(#function) not yet implemented")
  }
}

extension ListContentConfiguration.TextProperties {
  /// Constants that specify the visual alignment of the text.
  public enum TextAlignment {
    // MARK - Text Alignment

    /// The text has centered alignment.
    case center

    /// The text has justified alignment.
    case justified

    /// The text uses the default alignment that the system associates with the
    /// current localization of the app.
    case natural
  }
}

// MARK - Comparing Text Alignment

extension ListContentConfiguration.TextProperties.TextAlignment: Hashable {
  public static func ==(_ lhs: ListContentConfiguration.TextProperties.TextAlignment,
                        _ rhs: ListContentConfiguration.TextProperties.TextAlignment)
      -> Bool {
    fatalError("\(#function) not yet implemented")
  }

  public func hash(into hasher: inout Hasher) {
    fatalError("\(#function) not yet implemented")
  }
}

extension ListContentConfiguration.TextProperties {
  public enum TextTransform {
    // MARK - Text Transforms

    /// The text doesn't have a transform.
    case none

    /// Displays the text with the first character capitalized.
    case capitalized

    /// Displays the text in all lowercase characters.
    case lowercase

    /// Displays the text in all uppercase characters.
    case uppercase
  }
}

// MARK - Comparing Text Transforms

extension ListContentConfiguration.TextProperties.TextTransform: Hashable {
  public static func ==(_ lhs: ListContentConfiguration.TextProperties.TextTransform,
                        _ rhs: ListContentConfiguration.TextProperties.TextTransform)
      -> Bool {
    fatalError("\(#function) not yet implemented")
  }

  public func hash(into hasher: inout Hasher) {
    fatalError("\(#function) not yet implemented")
  }
}

extension ListContentConfiguration {
  /// Properties that affect the list content configuration's text.
  public struct TextProperties {
    // MARK - Configuring Text Properties

    /// The font for the text.
    public var font: Font

    /// The color of the text.
    public var color: Color

    /// The color transformer for resolving the text color.
    public var colorTransformer: ConfigurationColorTransformer?

    /// Generates the resolved color for the specified color, using the text
    /// color and color transformer.
    public func resolvedColor() -> Color {
      fatalError("\(#function) not yet implemented")
    }

    /// The alignment for the text.
    public var alignment: TextProperties.TextAlignment

    /// The line break mode to use for the text.
    public var lineBreakMode: LineBreakMode

    /// The maximum number of lines for the text.
    public var numberOfLines: Int

    /// A boolean value that detemines whether the configuration automatically
    /// adjusts the font size of the text when necessary to fit in the available
    /// width.
    public var adjustsFontSizeToFitWidth: Bool

    /// The smallest multiplier for the font size that the configuration uses to
    /// make the text fit.
    public var minimumScaleFactor: Double

    /// A boolean value that detemines whether the configuration tightens the
    /// text before truncating.
    public var allowsDefaultTighteningForTruncation: Bool

    /// A boolean value that detemines whether the configuration automatically
    /// updates the font when the content size category changes.
    public var adjustsFontForContentSizeCategory: Bool

    /// The transform to apply to the text.
    public var transform: TextProperties.TextTransform
  }
}

/// A content configuration for a list-based content view.
public struct ListContentConfiguration {
  // MARK - Creating Default Configurations

  /// Creates the default configuration for a list cell.
  public static func cell() -> ListContentConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates the default configuration for a list cell with subtitle text.
  public static func subtitleCell() -> ListContentConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates the default configuration for a list cell with side-by-side value
  /// text.
  public static func valueCell() -> ListContentConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates the default configuration for a plain list header.
  public static func plainHeader() -> ListContentConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates the default configuration for a plain list footer.
  public static func plainFooter() -> ListContentConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates the default configuration for a grouped list header.
  public static func groupedHeader() -> ListContentConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates the default configuration for a grouped list footer.
  public static func groupedFooter() -> ListContentConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates the default configuration for a sidebar list cell.
  public static func sidebarCell() -> ListContentConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates the default configuration for a sidebar list cell with subtitle
  /// text.
  public static func sidebarSubtitleCell() -> ListContentConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates the default configuration for a sidebar list header.
  public static func sidebarHeader() -> ListContentConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates the default configuration for an accompanied sidebar list cell.
  public static func accompaniedSidebarCell() -> ListContentConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates the default configuration for an accompanied sidebar list cell
  /// with subtitle text.
  public static func accompaniedSidebarSubtitleCell()
      -> ListContentConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Customizing Content

  /// The image to display.
  public var image: Image?

  /// The primary text.
  public var text: String?

  /// An attributed variant of the primary text.
  public var attributedText: NSAttributedString?

  /// The secondary text.
  public var secondaryText: String?

  /// An attributed variant of the secondary text.
  public var secondaryAttributedText: NSAttributedString?

  // MARK - Customizing Appearance

  /// Properties for configuring the image.
  public var imageProperties: ListContentConfiguration.ImageProperties

  /// Properties for configuring the primary text.
  public var textProperties: ListContentConfiguration.TextProperties

  /// Properties for configuring the secondary text.
  public var secondaryTextProperties: ListContentConfiguration.TextProperties

  // MARK - Customizing Layout

  /// A boolean value that detemines whether the content view preserves the
  /// layout margins that it inherits from its superview on the horizontal or
  /// vertical axes.
  public var axesPreservingSuperviewLayoutMargins: Axis = .both

  /// The margins between the content and the edges of the content view.
  public var directionalLayoutMargins: DirectionalEdgeInsets

  /// A boolean value that detemines whether the configuration positions the
  /// text and secondary text side by side.
  public var prefersSideBySideTextAndSecondaryText: Bool

  /// The padding between the image and text.
  public var imageToTextPadding: Double

  /// The minimum horizontal padding between the text and secondary text.
  public var textToSecondaryTextHorizontalPadding: Double

  /// The vertical padding between the text and secondary text.
  public var textToSecondaryTextVerticalPadding: Double
}

extension ListContentConfiguration: ContentConfiguration {
  // MARK - Creating a Content View

  /// Creates a new instance of the content view using this configuration.
  public func makeContentView() -> View & ContentView {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Updating the Configuration

  /// Generates a configuration for the specified state by applying the
  /// configuration's default values for that state to any properties that you
  /// haven't customized.
  public func updated(for state: ConfigurationState) -> ListContentConfiguration {
    fatalError("\(#function) not yet implemented")
  }
}

// MARK - Comparing List Content Configurations

extension ListContentConfiguration: Hashable {
  public static func ==(_ lhs: ListContentConfiguration,
                        _ rhs: ListContentConfiguration) -> Bool {
    fatalError("\(#function) not yet implemented")
  }

  public func hash(into hasher: inout Hasher) {
    fatalError("\(#function) not yet implemented")
  }
}

// MARK - Describing a List Content Configuration

extension ListContentConfiguration: CustomStringConvertible {
  public var description: String {
    fatalError("\(#function) not yet implemented")
  }
}

extension ListContentConfiguration: CustomDebugStringConvertible {
  public var debugDescription: String {
    fatalError("\(#function) not yet implemented")
  }
}

extension ListContentConfiguration: CustomReflectable {
  public var customMirror: Mirror {
    fatalError("\(#function) not yet implemented")
  }
}
