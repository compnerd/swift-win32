// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if swift(>=5.7)
import CoreGraphics
#endif

extension PointerEffect {
  /// An effect that defines how to apply a tint to a view during a pointer
  /// interaction.
  public enum TintMode: Hashable {
    // MARK - Tint Modes

    /// The view has no tint applied.
    case none

    /// The view has a tint overlay.
    case overlay

    /// The view has a tint underlay.
    case underlay
  }
}

/// An effect that alters a view's appearance when a pointer enters the current
/// region.
public enum PointerEffect {
  // MARK - Accessing the Preview

  /// A preview of the view used during an interaction's animations.
  public var preview: TargetedPreview {
    switch self {
    case .automatic(let preview):
      return preview
    case .highlight(let preview):
      return preview
    case .hover(let preview, _, _, _):
      return preview
    case .lift(let preview):
      return preview
    }
  }

  // MARK - Creating a Default Effect

  /// A pointer content effect with the given preview's view.
  case automatic(TargetedPreview)

  // MARK - Creating a Specific Effect

  /// An effect where the pointer slides under the given view and morphs into
  /// the view's shape.
  case highlight(TargetedPreview)

  /// An effect where visual changes are applied to the view and the pointer
  /// retains its default shape.
  case hover(TargetedPreview,
             preferredTintMode: PointerEffect.TintMode = .overlay,
             prefersShadow: Bool = false,
             prefersScaledContent: Bool = true)

  /// An effect where the pointer slides under the given view and disappears as
  /// the view scales up and gains a shadow.
  case lift(TargetedPreview)
}

/// An object that defines the shape of custom pointers.
public enum PointerShape {
  // MARK - Specifying Pointer Shapes

  /// The pointer morphs into a horizontal beam using the specified length.
  case horizontalBeam(length: Double)

  /// The pointer morphs into a vertical beam using the specified length.
  case verticalBeam(length: Double)

  /// The pointer morphs into the given Bézier path.
  case path(BezierPath)

  /// The pointer morphs into a rounded rectangle using the provided corner
  /// radius.
  case roundedRect(Rect, radius: Double = PointerShape.defaultCornerRadius)

  // MARK - Accessing Corner Radius

  /// The default corner radius for a pointer using a rounded rectangle.
  public static var defaultCornerRadius: Double {
    8.0
  }
}

/// An object that defines the pointer shape and effect.
public class PointerStyle {
  // MARK - Creating a Pointer Style

  /// Applies the provided content effect and pointer shape to the current
  /// region.
  public convenience init(effect: PointerEffect, shape: PointerShape? = nil) {
    fatalError("\(#function) not yet implemented")
  }

  /// Morphs the pointer into the provided shape when hovering over the current
  /// region.
  public convenience init(shape: PointerShape, constrainedAxes: Axis = []) {
    fatalError("\(#function) not yet implemented")
  }

  /// Hides the pointer when it moves over the current region.
  public class func hidden() -> Self {
    fatalError("\(#function) not yet implemented")
  }
}
