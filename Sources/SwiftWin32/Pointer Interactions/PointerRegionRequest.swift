// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if swift(>=5.7)
import CoreGraphics
#endif

/// An object to describe the pointer's location in the interaction's view.
public class PointerRegionRequest {
  // MARK - Inspecting the Region Request

  /// The location of the pointer in the interaction's view's coordinate space.
  public private(set) var location: Point

  /// Key modifier flags representing keyboard keys pressed by the user at the
  /// time of this request.
  public private(set) var modifiers: KeyModifierFlags

  internal init(location: Point, modifiers: KeyModifierFlags) {
    self.location = location
    self.modifiers = modifiers
  }
}
