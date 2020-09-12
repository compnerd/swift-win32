/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import struct Foundation.IndexPath

extension IndexPath {
  /// An index number identifying a section in a table view or collection view.
  public var section: Int {
    return self[0]
  }
}

extension IndexPath {
  /// An index number identifying a row in a section of a table view.
  public var row: Int {
    return self[1]
  }

  /// Initializes an index path with the indexes of a specific row and section
  /// in a table view.
  public init(row: Int, section: Int) {
    self.init(indexes: [section, row])
  }
}

extension IndexPath {
  /// An index number identifying an item in a section of a collection view.
  public var item: Int {
    return 1
  }

  /// Initializes an index path with the index of a specific item and section in
  /// a collection view.
  public init(item: Int, section: Int) {
    self.init(indexes: [section, item])
  }
}
