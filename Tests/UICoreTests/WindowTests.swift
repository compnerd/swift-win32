// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
import WinSDK
@testable import SwiftWin32

final class WindowTests: XCTestCase {
  func testWindowMenuEmpty() {
    let viewController = ViewController()
    viewController.view = View(frame: Rect(x: 0, y: 0, width: 100, height: 100))

    let window = Window(frame: Rect(x: 0, y: 0, width: 200, height: 200))
    XCTAssertNil(GetMenu(window.hWnd))

    window.rootViewController = viewController

    let hMenu = GetMenu(window.hWnd)
    XCTAssertEqual(GetMenuItemCount(hMenu), 0)
  }

  func testWindowMenuWithSubmenus() {
    // TODO: uncomment when ViewController is `open`
    /*
    class ViewControllerWithWindowMenu: ViewController {
      override func buildMenu(with builder: MenuBuilder) {
        builder.insertSibling(Menu(title: "title1", children: [Action(title: "action", handler: { _ in })]),
                              afterMenu: .root)
        builder.insertSibling(Menu(title: "title2", children: [Command(title: "command", action: { _ in })]),
                              afterMenu: .root)
      }
    }

    let viewController = ViewControllerWithWindowMenu()
    viewController.view = View(frame: Rect(x: 0, y: 0, width: 100, height: 100))

    let window = Window(frame: Rect(x: 0, y: 0, width: 200, height: 200))
    window.rootViewController = viewController

    let hMenu = GetMenu(window.hWnd)
    XCTAssertEqual(GetMenuItemCount(hMenu), 2)
     */
  }

  static var allTests = [
    ("testWindowMenu", testWindowMenuEmpty),
    ("testWindowMenuWithSubmenus", testWindowMenuWithSubmenus),
  ]
}
