/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

extension TableViewCell {
  public enum CellStyle: Int {
  /// A simple style for a cell with a text label (black and left-aligned) and
  /// an optional view.
  case `default`
  /// A style for a cell with a label on the left side of the cell with a
  /// left-aligned and black text; on the right side is a label that has smaller
  /// blue text and is right aligned.
  case value1
  /// A style for a cell with a label on the left side of the cell with text
  /// that is right-aligned and blue on the right side of the cell is another
  /// label with smaller text that is left-aligned and black.
  case value2
  /// A style for a cell with a left-aligned label across the top and a
  /// left-aliggned label below it in smaller gray text.
  case subtitle
  }
}

/// The visual representation of a single row in a table view.
public class TableViewCell: View {
  private static let `class`: WindowClass =
      WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.TableViewCell",
                  style: UInt32(CS_HREDRAW | CS_VREDRAW),
                  hbrBackground: GetSysColorBrush(COLOR_3DFACE),
                  hCursor: LoadCursorW(nil, IDC_ARROW))
  private static let style: WindowStyle = (base: 0, extended: 0)

  /// Creating a Table View Cell

  /// Initializes a table cell with a style and a reuse identifier and returns it
  /// to the caller.
  public init(style: TableViewCell.CellStyle, reuseIdentifier: String?) {
    self.reuseIdentifier = reuseIdentifier
    super.init(frame: .zero, class: TableViewCell.class,
               style: TableViewCell.style)
  }

  /// Reusing Cells

  /// A string used to identify a cell that is reusable.
  public let reuseIdentifier: String?

  /// Prepares a reusable cell for reuse by the table view's delegate.
  public func prepareForReuse() {
  }
}
