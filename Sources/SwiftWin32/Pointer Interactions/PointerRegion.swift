// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

public class PointerRegion {
  // MARK - Configuring a Region

  /// The rectangle bounds of the region.
  public private(set) var rect: Rect

  // MARK - Initializers

  public /*convenience*/ init(rect: Rect, identifier: AnyHashable? = nil) {
    self.rect = rect
    self.identifier = identifier
  }

  // MARK - Instance Property

  public private(set) var identifier: AnyHashable?
}
