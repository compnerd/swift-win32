/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import struct Foundation.IndexPath

/// A context object that provides information relevant to a specific focus
/// update from one view to another.
public class TableViewFocusUpdateContext: FocusUpdateContext {
  // MARK - Locating Focusable Items in a Table View

  /// Returns the index path of the cell containing the context's previously
  /// focused view.
  public internal(set) var previouslyFocusedIndexPath: IndexPath?

  /// Returns the index path of the cell containing the context's next focused
  /// view.
  public internal(set) var nextFocusedIndexPath: IndexPath?
}
