/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK
import class Foundation.NSUUID

extension Menu {
  /// Constants for identifying an application's standard menus.
  public struct Identifier: Equatable, Hashable, RawRepresentable {
    public typealias RawValue = String

    public let rawValue: RawValue

    public init(rawValue: String) {
      self.rawValue = rawValue
    }
  }
}

extension Menu.Identifier {
  // MARK - Root Menu

  /// The root menu.
  public static var root: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.root")
  }

  // MARK - Top-Level Menus

  /// The standard application menu.
  public static var application: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.application")
  }

  /// The standard File menu.
  public static var file: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.file")
  }

  /// The standard Edit menu.
  public static var edit: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.edit")
  }

  /// The standard View menu.
  public static var view: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.view")
  }

  /// The standard Window menu.
  public static var window: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.window")
  }

  /// The standard Help menu.
  public static var help: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.help")
  }

  // MARK - Application Menu Commands

  /// The About menu.
  public static var about: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.about")
  }

  /// The Preferences menu.
  public static var preferences: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.preferences")
  }

  /// The Services menu.
  public static var services: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.services")
  }

  /// The Hide menu.
  public static var hide: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.hide")
  }

  /// The Quit menu.
  public static var quit: Menu.Identifier{
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.quit")
  }

  // MARK - File Menus

  /// The New Scene menu.
  public static var newScene: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.new-scene")
  }

  /// The Close menu.
  public static var close: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.close")
  }

  /// The Print menu.
  public static var print: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.print")
  }

  // MARK - Edit Menus

  /// The Undo/Redo menu.
  public static var undoRedo: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.undo-redo")
  }

  /// The standard Edit menu.
  public static var standardEdit: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.standard-edit")
  }

  /// The Find menu.
  public static var find: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.find")
  }

  /// The Replace menu.
  public static var replace: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.replace")
  }

  /// The Share menu.
  public static var share: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.share")
  }

  /// The Text Style menu.
  public static var textStyle: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.text-style")
  }

  /// The Spelling menu.
  public static var spelling: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.spelling")
  }

  /// The Spelling Panel menu.
  public static var spellingPanel: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.spelling-panel")
  }

  /// The Spelling Options menu.
  public static var spellingOptions: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.spelling-options")
  }

  /// The Subsitutions menu.
  public static var subsitutions: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.subsitutions")
  }

  /// The Subsitutions Panel menu.
  public static var subsitutionsPanel: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.subsitutions-panel")
  }

  /// The Transformations menu.
  public static var transformations: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.transoformations")
  }

  /// The Speech menu.
  public static var speech: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.speech")
  }

  /// The Lookup menu.
  public static var lookup: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.lookup")
  }

  /// The Learn menu.
  public static var learn: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.learn")
  }

  /// The Format menu.
  public static var format: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.format")
  }

  /// The Font menu.
  public static var font: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.font")
  }

  /// The Text Size menu.
  public static var textSize: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.text-size")
  }

  /// The Text Color menu.
  public static var textColor: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.text-color")
  }

  /// The Text Style Pasteboard menu.
  public static var textStylePasteboard: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.text-style-pasteboard")
  }

  /// The Text menu.
  public static var text: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.text")
  }

  /// The Writing Direction menu.
  public static var writingDirection: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.writing-direction")
  }

  /// The Alignment menu.
  public static var alignment: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.alignment")
  }

  // MARK - View Menus

  /// The Toolbar menu group.
  public static var toolbar: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.toolbar")
  }

  /// The Fullscreen menu.
  public static var fullscreen: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.fullscreen")
  }

  // MARK - Window Menus

  /// The Bring All to Front menu.
  public static var bringAllToFront: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.bring-all-to-front")
  }

  /// The Minimize and Zoom menu.
  public static var minimizeAndZoom: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.minimize-and-zoom")
  }
}

extension Menu.Identifier {
  fileprivate static var generated: Menu.Identifier {
    Menu.Identifier(rawValue: "org.compnerd.swift-win32.menu.generated.\(NSUUID())")
  }
}


extension Menu {
  // MARK - Options for configuring a menu's appearance.
  public struct Options: OptionSet {
    public typealias RawValue = UInt

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension Menu.Options {
  /// An option indicating the menu displays inline with its parent menu instead
  /// of displaying as a submenu.
  public static var displayInline: Menu.Options {
    return Menu.Options(rawValue: 1 << 0)
  }

  /// An Option indicating the menu's appearance represents a destructive
  /// action.
  public static var destructive: Menu.Options {
    return Menu.Options(rawValue: 1 << 1)
  }
}

/// A container for grouping related menu elements in an application menu or
/// contextual menu.
public class Menu: MenuElement {
  // MARK - Creating a Menu Object

  /// Creates a new menu with the specified values.
  public init(title: String = "", image: Image? = nil,
              identifier: Menu.Identifier? = nil, options: Menu.Options = [],
              children: [MenuElement] = []) {
    self.children = children
    self.identifier = identifier ?? .generated
    self.options = options
    super.init(title: title, image: image)
  }

  // MARK - Accessing the Child Elements

  /// The contents of the menu.
  public let children: [MenuElement]

  /// Creates a new menu with the same configuration as the current menu, but
  /// with a new set of child elements.
  public func replacingChildren(_ newChildren: [MenuElement]) -> Menu {
    fatalError("\(#function) not yet implemented")
  }

  // MARK - Getting the Menu Details

  /// The unique identifier for the current menu.
  public let identifier: Menu.Identifier

  /// The configuration options for the current menu.
  public let options: Menu.Options
}

internal struct Win32Menu {
  internal let hMenu: MenuHandle

  private let items: [Win32MenuElement]

  internal init(_ hMenu: MenuHandle, items: [MenuElement]) {
    self.hMenu = hMenu
    self.items = items.map { Win32MenuElement($0) }
    for (index, child) in self.items.enumerated() {
      InsertMenuItemW(hMenu.value, UINT(index), true, &child.info)
    }
  }
}
