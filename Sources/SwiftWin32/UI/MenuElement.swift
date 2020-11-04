/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

extension MenuElement {
  /// Attributes that determine the style of the menu element.
  public struct Attributes: OptionSet {
    public typealias RawValue = Int

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension MenuElement.Attributes {
  /// An attribute indicating the destructive style.
  public static var destructive: MenuElement.Attributes {
    MenuElement.Attributes(rawValue: 1 << 1)
  }

  /// An attribute indicating the disabled style.
  public static var disabled: MenuElement.Attributes {
    MenuElement.Attributes(rawValue: 1 << 0)
  }

  /// An attribute indicating the hidden style.
  public static var hidden: MenuElement.Attributes {
    MenuElement.Attributes(rawValue: 1 << 2)
  }
}

extension MenuElement {
  /// Constants that indicate the state of an action-based or command-based
  /// menu element.
  public enum State: Int {
  /// A constant indicating the menu element is in the "off" state.
  case off

  /// A constant indicating the menu element is in the "on" state.
  case on

  /// A constant indicating the menu element is in the "mixed" state.
  case mixed
  }
}

/// An object representing a menu, action, or command.
public class MenuElement {
  /// Getting the Element Attributes

  /// The title of the menu element.
  public var title: String

  /// The image to display alongside the menu element's title.
  public var image: Image?

  /// Creating a Menu Element

  internal init(title: String, image: Image?) {
    self.title = title
    self.image = image
  }
}
