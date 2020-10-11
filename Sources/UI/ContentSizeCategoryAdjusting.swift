/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// A collection of methods that gives controls an easy way to adopt automatic
/// adjustment to content category changes.
public protocol ContentSizeCategoryAdjusting {
  /// Adjusting the Size of Fonts

  /// A boolean that indicates whether the object automatically updates its font
  /// when the device's context size category changes.
  var adjustsFontForContentSizeCategory: Bool { get set }
}
