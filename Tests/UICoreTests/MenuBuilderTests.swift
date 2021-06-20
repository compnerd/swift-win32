// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
@testable import SwiftWin32

final class MenuBuilderTests: XCTestCase {
  func testConstruct() {
    let view: View = View(frame: .zero)

    let builder: MenuBuilder? = _MenuBuilder(for: view)
    XCTAssertNotNil(builder)
  }

  func testInsertSibling() {
    let view: View = View(frame: .zero)
    guard let builder = _MenuBuilder(for: view) else { return }

    builder.insertSibling(Menu(identifier: .application), beforeMenu: .root)
    XCTAssertNotNil(builder.menu(for: .application))

    builder.insertSibling(Menu(identifier: .edit), afterMenu: .root)
    XCTAssertNotNil(builder.menu(for: .edit))

    builder.insertSibling(Menu(identifier: .file), beforeMenu: .edit)
    XCTAssertNotNil(builder.menu(for: .file))

    builder.insertSibling(Menu(identifier: .services), beforeMenu: .quit)
    XCTAssertNotNil(builder.menu(for: .services))

    builder.insertSibling(Menu(identifier: .help), afterMenu: .quit)
    XCTAssertNotNil(builder.menu(for: .help))
  }

  func testInsertChild() {
    let view: View = View(frame: .zero)
    guard let builder = _MenuBuilder(for: view) else { return }

    builder.insertSibling(Menu(identifier: .window), beforeMenu: .view)
    let window = builder.menu(for: .window)
    XCTAssertNotNil(window)

    builder.insertChild(Menu(identifier: .bringAllToFront),
                        atStartOfMenu: .window)
    builder.insertChild(Menu(identifier: .minimizeAndZoom),
                        atEndOfMenu: .window)

    XCTAssertEqual(window?.children.count ?? 0, 2)
    XCTAssertEqual((window?.children[0] as? Menu)?.identifier, .bringAllToFront)
    XCTAssertEqual((window?.children[1] as? Menu)?.identifier, .minimizeAndZoom)

    builder.insertChild(Menu(identifier: .fullscreen),
                        atStartOfMenu: .preferences)
    builder.insertChild(Menu(identifier: .toolbar),
                        atEndOfMenu: .hide)
  }

  func testRemove() {
    let view: View = View(frame: .zero)
    guard let builder = _MenuBuilder(for: view) else { return }

    builder.insertSibling(Menu(identifier: .application), beforeMenu: .root)
    XCTAssertNotNil(builder.menu(for: .application))

    builder.remove(menu: .application)
    XCTAssertNil(builder.menu(for: .application))
  }

  func testReplace() {
    let view: View = View(frame: .zero)
    guard let builder = _MenuBuilder(for: view) else { return }

    builder.insertSibling(Menu(identifier: .application), beforeMenu: .root)
    XCTAssertNotNil(builder.menu(for: .application))

    builder.replace(menu: .application, with: Menu(identifier: .file))
    XCTAssertNil(builder.menu(for: .application))
    XCTAssertNotNil(builder.menu(for: .file))

    XCTAssertNil(builder.menu(for: .quit))
    builder.replace(menu: .quit, with: Menu(identifier: .about))
    XCTAssertNotNil(builder.menu(for: .file))
    XCTAssertNil(builder.menu(for: .about))
  }

  func testBuildMenu() {
    let view: View = View(frame: .zero)
    let builder = _MenuBuilder(for: view)
    XCTAssertNotNil((builder?.system as? _MenuBuilder)?.hMenu.value)
  }

  public static var allTests = [
    ("testConstruct", testConstruct),
    ("testInsertSibling", testInsertSibling),
    ("testInsertChild", testInsertChild),
    ("testRemove", testRemove),
    ("testReplace", testReplace),
    ("testBuildMenu", testBuildMenu),
  ]
}
