/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>.
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

public class LayoutGuide {
  // MARK - Working with Layout Guides

  /// A string used to identify the layout guide.
  public var identifier: String = ""

  /// The layout guide's frame in its owning view's coordinate system.
  public private(set) var layoutFrame: Rect = .zero

  /// The view that owns the layout guide.
  public weak var owningView: View?

  // MARK - Creating Constraints Using Layout Anchors

  /// A layout anchor representing the bottom edge of the layout guide's frame.
  public var bottomAnchor: LayoutYAxisAnchor {
    LayoutYAxisAnchor(item: owningView!, attribute: .bottom)
  }

  /// A layout anchor representing the horizontal center of the layout guide's
  /// frame.
  public var centerXAnchor: LayoutXAxisAnchor {
    LayoutXAxisAnchor(item: owningView!, attribute: .centerX)
  }

  /// A layout anchor representing the vertical center of the layout guide's
  /// frame.
  public var centerYAnchor: LayoutYAxisAnchor {
    LayoutYAxisAnchor(item: owningView!, attribute: .centerY)
  }

  /// A layout anchor representing the height of the layout guide's frame.
  public var heightAnchor: LayoutDimension {
    LayoutDimension(item: owningView!, attribute: .height)
  }

  /// A layout anchor representing the leading edge of the layout guide's frame.
  public var leadingAnchor: LayoutXAxisAnchor {
    LayoutXAxisAnchor(item: owningView!, attribute: .leading)
  }

  /// A layout anchor representing the left edge of the layout guide's frame.
  public var leftAnchor: LayoutXAxisAnchor {
    LayoutXAxisAnchor(item: owningView!, attribute: .left)
  }

  /// A layout anchor representing the right edge of the layout guide's frame.
  public var rightAnchor: LayoutXAxisAnchor {
    LayoutXAxisAnchor(item: owningView!, attribute: .right)
  }

  /// A layout anchor representing the top edge of teh layout guide's frame.
  public var topAnchor: LayoutYAxisAnchor {
    LayoutYAxisAnchor(item: owningView!, attribute: .top)
  }

  /// A layout anchor representing the trailing edge of teh layout guide's
  /// frame.
  public var trailingAnchor: LayoutXAxisAnchor {
    LayoutXAxisAnchor(item: owningView!, attribute: .trailing)
  }

  /// A layout anchor representing the width of the layout guide's frame.
  public var widthAnchor: LayoutDimension {
    LayoutDimension(item: owningView!, attribute: .width)
  }
}
