/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// A configuration that describes a specific background appearance.
public struct BackgroundConfiguration {
  // MARK - Creating Cell Background Configurations

  /// Creates a default configuration for a plain list cell.
  public static func listPlainCell() -> BackgroundConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates a default configuration for a grouped list cell.
  public static func listGroupedCell() -> BackgroundConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates a default configuration for a sidebar list cell.
  public static func listSidebarCell() -> BackgroundConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates a default configuration for an accompanied sidebar list cell.
  public static func listAccompaniedSidebarCell() -> BackgroundConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Creating Header and Footer Background Configurations

  /// Creates a default configuration for a plain list header or footer.
  public static func listPlainHeaderFooter() -> BackgroundConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates a default configuration for a grouped list header or footer.
  public static func listGroupedHeaderFooter() -> BackgroundConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// Creates a default configuration for a sidebar list header.
  public static func listSidebarHeader() -> BackgroundConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Creating an Empty Background Configuration

  /// Creates an empty background configuration with a transparent background
  /// and no default styling.
  public static func clear() -> BackgroundConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Customizing the Background

  /// A custom view for the background.
  public var customView: View?

  /// The preferred corner radius, using a continuous corner curve, for the
  /// background and stroke.
  public var cornerRadius: Double = 0.0

  /// The insets (or outsets, if negative) for the background and stroke,
  /// relative to the edges of the containing view.
  public var backgroundInsets: DirectionalEdgeInsets = .zero

  /// The edges on which the configuration adds the containing view’s layout
  /// margins to the background insets.
  public var edgesAddingLayoutMarginsToBackgroundInsets: DirectionalRectEdge =
      .none

  /// The color of the background.
  ///
  /// If the value is `nil`, the background color is the view's tint color. Use
  /// `clear` for a transparent background with no color.
  public var backgroundColor: Color?

  /// The color transformer for resolving the background color.
  ///
  /// If the value is `nil`, the configuration uses `backgroundColor` without
  /// any transformations.
  public var backgroundColorTransformer: ConfigurationColorTransformer?

  /// Generates the resolved background color for the specified tint color,
  /// using the background color and color transformer.
  public func resolvedBackgroundColor(for tintColor: Color) -> Color {
    fatalError("\(#function) not yet implemented")
  }

  /// The visual effect that the configuration applies to the background.
  public var visualEffect: VisualEffect?

  /// The color of the stroke.
  ///
  /// If the value is `nil`, the stroke color is the view's tint color. Use
  /// `clear` for a transparent stroke with no color.
  public var strokeColor: Color?

  /// The color transformer for resolving the stroke color.
  ///
  /// If the value is `nil`, the configuration uses `strokeColor` without any
  /// transformations.
  public var strokeColorTransformer: ConfigurationColorTransformer?

  /// Generates the resolved stroke color for the specified tint color, using
  /// the stroke color and color transformer.
  public func resolvedStrokeColor(for tintColor: Color) -> Color {
    fatalError("\(#function) not yet implemented")
  }

  /// The width of the stroke.
  public var strokeWidth: Double = 0.0

  /// The outset (or inset, if negative) for the stroke.
  public var strokeOutset: Double = 0.0

  // MARK - Updating Background Configurations

  /// Generates a configuration for the specified state by applying the
  /// configuration's default values for that state to any properties that you
  /// haven't customized.
  public func updated(for state: ConfigurationState) -> BackgroundConfiguration {
    fatalError("\(#function) not yet implemented")
  }
}

// MARK - Comparing Background Configurations

extension BackgroundConfiguration: Hashable {
  public static func ==(_ lhs: BackgroundConfiguration,
                        _ rhs: BackgroundConfiguration) -> Bool {
    fatalError("\(#function) not yet implemented")
  }

  public func hash(into hasher: inout Hasher) {
    fatalError("\(#function) not yet implemented")
  }
}

// MARK - Describing a Background Configuration

extension BackgroundConfiguration: CustomStringConvertible {
  public var description: String {
    fatalError("\(#function) not yet implemented")
  }
}

extension BackgroundConfiguration: CustomDebugStringConvertible {
  public var debugDescription: String {
    fatalError("\(#function) not yet implemented")
  }
}

extension BackgroundConfiguration: CustomReflectable {
  public var customMirror: Mirror {
    fatalError("\(#function) not yet implemented")
  }
}
