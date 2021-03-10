/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// Constants that specify what happens when a line is too long for its
/// container.
public enum LineBreakMode: Int {
  // MARK - Constants

  /// Wrapping occurs at word boundaries, unless the word doesn’t fit on a
  /// single line.
  case byWordWrapping

  /// Wrapping occurs before the first character that doesn’t fit.
  case byCharWrapping

  /// Lines don't extend past the edge of the text container.
  case byClipping

  /// The line displays so that the end fits in the container and an ellipsis
  /// glyph indicates the missing text at the beginning of the line.
  case byTruncatingHead

  /// The line displays so that the beginning fits in the container and an
  /// ellipsis glyph indicates the missing text at the end of the line.
  case byTruncatingTail

  /// The line displays so that the beginning and end fit in the container and
  /// an ellipsis glyph indicates the missing text in the middle.
  case byTruncatingMiddle
}
