// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// Methods to determine when to adjust images for different content size
/// categories.
public protocol ContentSizeCategoryImageAdjusting {
  /// Preferring Accessibility-Specific Images

  /// A boolean that indicates whether the image size increases to support
  /// accessibility content size categories.
  var adjustsImageSizeForAccessibilityContentSizeCategory: Bool { get set }
}

