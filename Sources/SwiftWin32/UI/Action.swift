/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

extension Action {
  /// A type that represents an action identifier.
  public struct Identifier: Equatable, Hashable, RawRepresentable {
    public typealias RawValue = String

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension Action.Identifier {
  public init(_ rawValue: String) {
    self.rawValue = rawValue
  }
}

/// A menu element that performs its action in a closure.
public class Action: MenuElement {
  // MARK - Creating an Action

  /// Creates an action.
  public /*convenience*/ init(title: String = "", image: Image? = nil,
                              identifier: Action.Identifier? = nil,
                              discoverabilityTitle: String? = nil,
                              attributes: MenuElement.Attributes = [],
                              state: MenuElement.State = .off,
                              handler: @escaping ActionHandler) {
    self.identifier = identifier ?? Action.Identifier("")
    self.discoverabilityTitle = discoverabilityTitle
    self.attributes = attributes
    self.state = state

    super.init(title: title, image: image)
  }

  /// A type that defines the closure for an action handler.
  public typealias ActionHandler = (Action) -> Void

  // MARK - Getting Information About the Action

  /// The action's title.
  public override var title: String {
    get { super.title }
    set { super.title = newValue }
  }

  /// The action's image.
  public override var image: Image? {
    get { super.image }
    set { super.image = newValue }
  }

  /// The unique identifier for the action.
  public private(set) var identifier: Action.Identifier

  /// An elaborated title that explains the purpose of the action.
  public var discoverabilityTitle: String?

  /// The attributes indicating the style of the action.
  public var attributes: MenuElement.Attributes

  /// The state of the action.
  public var state: MenuElement.State

  /// The object responsible for the action handler.
  public var sender: Any?
}
