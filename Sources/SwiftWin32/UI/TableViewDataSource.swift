/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import struct Foundation.IndexPath

public protocol TableViewDataSource: class {
  /// Providng the Number of Rows and Sections

  /// Informs the data source to return the number of rows in a given section of
  /// a table view.
  func tableView(_ tableView: TableView, numberOfRowsInSection section: Int)
      -> Int

  /// Asks the data source to return the number of sections in the table view.
  func numberOfSections(in tableView: TableView) -> Int

  /// Providing Cells, Headers, and Footers

  /// Asks the data source for a cell to insert in a particular location of the
  /// table view.
  func tableView(_ tableView: TableView, cellForRowAt indexPath: IndexPath)
      -> TableViewCell

  /// Asks the data source for the title of the header of the specified section
  /// of the table view.
  func tableView(_ tableView: TableView, titleForHeaderInSection section: Int)
      -> String?

  /// Asks the data source for the title of the footer of the specified section
  /// of the table view.
  func tableView(_ tableView: TableView, titleForFooterInSection section: Int)
      -> String?
}

extension TableViewDataSource {
  public func numberOfSections(in tableView: TableView) -> Int {
    return 1
  }
}

extension TableViewDataSource {
  public func tableView(_ tableView: TableView,
                        titleForHeaderInSection section: Int) -> String? {
    return nil
  }

  public func tableView(_ tableView: TableView,
                        titleForFooterInSection section: Int) -> String? {
    return nil
  }
}
