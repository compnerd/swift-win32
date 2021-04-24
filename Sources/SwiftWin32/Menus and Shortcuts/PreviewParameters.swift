// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import class Foundation.NSValue

/// Additional parameters to use when animating a preview interface.
public class PreviewParameters {
  /// Creating Preview Parameters

  /// Creates a default set of preview parameters.
  public init() {
    // TODO(compnerd) initialize the default parameters
  }

  /// Creates a preview paramters object with information about the text you
  /// want to preview.
  public init(textLineRects: [NSValue]) {
    // TODO(compnerd) store the rects
  }

  /// Configuring the Preview Attributes

  /// The background color to display behind the preview.
  public var backgroundColor: Color!

  /// The portion of the view to show in the preview.
  public var visiblePath: BezierPath?

  public var shadowPath: BezierPath?
}
