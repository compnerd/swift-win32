/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// The protocol that an interaction implements to access the view that owns it.
public protocol Interaction: class {
  // MARK - Getting the View

  /// The view that owns the interaction.
  /* weak */ var view: View? { get }

  // MARK - Tracking the Movements

  /// Tells the interaction that a view added or removed it from the view's
  /// interaction array.
  func didMove(to view: View?)

  /// Tells the interaction that a view will add or remove it from the view's
  /// interaction array.
  func willMove(to view: View?)
}
