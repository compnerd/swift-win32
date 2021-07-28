// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// A set of bar button items on the shortcuts bar.
open class BarButtonItemGroup {
  // MARK - Initializing a Bar Button Item Group

  /// Initializes and returns a bar button item group with the specified items.
  public init(barButtonItems: [BarButtonItem], representativeItem: BarButtonItem?) {
    self.barButtonItems = barButtonItems
    self.representativeItem = representativeItem
  }

  // MARK - Configuring the Group

  /// The bar button items to display on the shortcuts bar.
  ///
  /// You may include any number of bar button items in a group, but you should
  /// keep the total number of items relatively small because of space
  /// considerations. The items in a group are typically related to each other,
  /// but need not be. The array must contain at least one item.
  /// 
  /// Items can belong to only one group at a time. If you specify an item that
  /// is already in a group, the framework removes the item from its previous
  /// group before assigning it to the current group.
  open var barButtonItems: [BarButtonItem]

  /// The item to display for a group when space is constrained.
  ///
  /// When space is constrained on the shortcuts bar, the framework may display
  /// a group's representative item in place of its actual items. The
  /// representative item is a single bar button item that is unique from the
  /// other items in the group. Tapping the representative item calls its action
  /// method normally. If you omit that action method, the framework responds by
  /// automatically displaying the group’s items in a standard interface.
  /// 
  /// If you do not specify a representative item for a group, the framework
  /// tries to display the group's items in the shortcuts bar. If space is still
  /// constrained, the framework may modify the appearance of items in the group
  /// to make room for all of the items. For example, the framework may truncate
  /// the titles of textual bar button items. When space is severely
  /// constrained, the framework may not even display a group's representative
  /// item.
  open var representativeItem: BarButtonItem?

  // MARK - Determining the Group's Appearance

  /// A boolean value indicating whether the representative item is being
  /// displayed in place of the group's items.
  /// 
  /// The value of this property is `true` when the representative item is being
  /// displayed in the shortcuts bar. The value is false when the individual bar
  /// button items are being displayed in the shortcuts bar.
  open private(set) var isDisplayingRepresentativeItem: Bool = true
}
