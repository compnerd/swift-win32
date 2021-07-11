// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import class Foundation.NSAttributedString

/// An abstract superclass for items that you can add to a bar that appears at
/// the bottom of the screen.
open class BarItem {
  // MARK - Initializing a Bar Item

  /// Initializes the bar item to its default state.
  public init() {
  }

  // MARK - Getting and Setting Properties

  /// The title displayed on the item.
  ///
  /// You should set this property before adding the item to a bar. The default
  /// value is `nil`.
  open var title: String?

  /// The image used to represent the item.
  ///
  /// This image can be used to create other images to represent this item on
  /// the bar — for example, a selected and unselected image may be derived from
  /// this image. You should set this property before adding the item to a bar.
  /// The default value is `nil`.
  open var image: Image?

  /// The image to use to represent the item in landscape orientation.
  ///
  /// This image can be used to create other images to represent this item on
  /// the bar — for example, a selected and unselected image may be derived from
  /// this image. You should set this property before adding the item to a bar.
  /// The default value is `nil`.
  open var landscapeImage: Image?

  /// The image to display for assistive interfaces.
  ///
  /// Use this property to specify a high-resolution version of the item's
  /// image. When displaying an assistive interface, the framework displays this
  /// image instead of the standard image. The default value of this property is
  /// `nil`.
  ///
  /// If you do not specify an image for this property, the framework scales the
  /// image that you specified in the image property.
  open var largeContentSizeImage: Image?

  /// The image inset or outset for each edge.
  ///
  /// The default value is `zero`.
  open var imageInsets: EdgeInsets = .zero

  /// The image inset or outset for each edge of the image in landscape
  /// orientation.
  ///
  /// The default value is `zero`.
  open var landscapeImageInsets: EdgeInsets = .zero

  /// The insets to apply to the bar item's large image when displaying the
  /// image in an assistive UI.
  ///
  /// The default value of this property is `zero`.
  open var largeContentSizeImageInsets: EdgeInsets = .zero

  /// A boolean value indicating whether the item is enabled.
  ///
  /// If `false`, the item is drawn partially dimmed to indicate it is disabled.
  /// The default value is `true`.
  open var isEnabled: Bool = true

  /// The receiver’s tag, an application-supplied integer that you can use to
  /// identify bar item objects in your application.
  ///
  /// The default value is `0`.
  open var tag: Int = 0

  // MARK - Customizing Appearance

  /// Sets the title’s text attributes for a given control state.
  open func setTitleTextAttributes(_ attributes: [NSAttributedString.Key:Any]?,
                                   for state: Control.State) {
    fatalError("\(#function) not yet implemnted")
  }

  /// Returns the title’s text attributes for a given control state.
  ///
  /// The dictionary may contain key-value pairs for text attributes for the
  /// font, text color, text shadow color, and text shadow offset using the keys
  /// listed in NSString Additions Reference.
  open func titleTextAttributes(for state: Control.State)
      -> [NSAttributedString.Key:Any]? {
    fatalError("\(#function) not yet implemnted")
  }
}
