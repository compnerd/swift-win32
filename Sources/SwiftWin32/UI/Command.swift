/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// Constants that indicate which modifier keys are pressed.
public struct KeyModifierFlags: OptionSet {
  public typealias RawValue = Int

  public let rawValue: RawValue

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }
}

extension KeyModifierFlags {
  /// A modifier flag that indicates the user pressed the Caps Lock key.
  public static var alphaShift: KeyModifierFlags {
    KeyModifierFlags(rawValue: 1 << 16)
  }

  /// A modifier flag that indicates the user pressed the Shift key.
  public static var shift: KeyModifierFlags {
    KeyModifierFlags(rawValue: 1 << 17)
  }

  /// A modifier flag that indicates the user pressed the Control key.
  public static var control: KeyModifierFlags {
    KeyModifierFlags(rawValue: 1 << 18)
  }

  /// A modifier flag that indicates the user pressed the Option key.
  public static var alternate: KeyModifierFlags {
    KeyModifierFlags(rawValue: 1 << 19)
  }

  /// A modifier flag that indicates the user pressed the Command key.
  public static var command: KeyModifierFlags {
    KeyModifierFlags(rawValue: 1 << 20)
  }

  /// A modifier flag that indicates the user pressed a key located on the
  /// numeric keypad.
  public static var numericPad: KeyModifierFlags {
    KeyModifierFlags(rawValue: 1 << 21)
  }
}

/// An object representing an alternative action for a command.
public class CommandAlternate {
  // MARK - Creating a Command Alternative

  /// Creates a command alternative with the specified title, action, and
  /// modifier flags.
  public /*convenience*/ init(title: String,
                              action: @escaping (_: AnyObject?) -> Void,
                              modifierFlags: KeyModifierFlags) {
    self.title = title
    self.action = action
    self.modifierFlags = modifierFlags
  }

  /// The command alternative's title.
  public private(set) var title: String

  /// The command alternative's action-method selector.
  public private(set) var action: (_: AnyObject?) -> Void

  /// The bit mask of modifier keys that the user must press to invoke the
  /// action for the alternative command.
  public private(set) var modifierFlags: KeyModifierFlags
}

/// A menu element that performs its action in a selector.
public class Command: MenuElement {
  // MARK - Creating a Command

  /// Creates a command.
  public /*convenience*/ init(title: String = "", image: Image? = nil,
                              action: @escaping (_: AnyObject?) -> Void,
                              propertyList: Any? = nil,
                              alternates: [CommandAlternate] = [],
                              discoverabilityTitle: String? = nil,
                              attributes: MenuElement.Attributes = [],
                              state: MenuElement.State = .off) {
    self.action = action
    self.discoverabilityTitle = discoverabilityTitle
    self.attributes = attributes
    self.state = state

    self.alternates = alternates

    super.init(title: title, image: image)
  }

  // MARK - Getting Information About the Command

  /// The command's title.
  public override var title: String {
    get { super.title }
    set { super.title = newValue }
  }

  /// The command's image.
  public override var image: Image? {
    get { super.image }
    set { super.image = newValue }
  }

  /// The selector identifying the action method called after the user selects
  /// the command.
  public var action: (_: AnyObject?) -> Void

  /// An elaborated title that explains the purpose of the command.
  public var discoverabilityTitle: String?

  /// The attributes indicating the style of the command.
  public var attributes: MenuElement.Attributes

  /// The state of the command.
  public var state: MenuElement.State

  // MARK - Getting Command Alternatives

  /// An array of alternative actions to take for the command.
  public private(set) var alternates: [CommandAlternate]
}
