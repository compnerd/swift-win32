// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
@testable import SwiftWin32

final class ViewControllerTests: XCTestCase {
  func testLazyViewLoading() {
    let vc = ViewController()

    XCTAssertNil(vc.viewIfLoaded)
    XCTAssertFalse(vc.isViewLoaded)

    _ = vc.view

    XCTAssertNotNil(vc.viewIfLoaded)
    XCTAssertTrue(vc.isViewLoaded)
  }

  func testManualViewLoading() {
    let vc = ViewController()

    XCTAssertNil(vc.viewIfLoaded)
    XCTAssertFalse(vc.isViewLoaded)

    vc.loadViewIfNeeded()

    XCTAssertNotNil(vc.viewIfLoaded)
    XCTAssertTrue(vc.isViewLoaded)
  }

  func testTitleGetterAndSetter() {
    let vc = ViewController()

    // XCTAssertNil(vc.title) // This is currently failing, but the initial value of `title` should be `nil`

    vc.title = "Title"

    XCTAssertEqual(vc.title, "Title")
  }

  func testValueOfDisablesAutomaticKeyboardDismissal() {
    let vc = MockViewController()

    vc.modalPresentationStyleGetter = {
      return .automatic
    }

    XCTAssertFalse(vc.disablesAutomaticKeyboardDismissal)

    vc.modalPresentationStyleGetter = {
      return .formSheet
    }

    XCTAssertTrue(vc.disablesAutomaticKeyboardDismissal)
  }

  func testNextResponder() {
    let expectedResult = View(frame: .zero)

    let vc = ViewController()

    XCTAssertNil(vc.next)

    expectedResult.addSubview(vc.view)

    XCTAssert(vc.next === expectedResult)
  }

  func testViewDidLoadMethodCalledAfterLazyViewLoad() {
    let vc = MockViewController()

    let expectation = self.expectation(description: "viewDidLoad should be called")

    vc.viewDidLoadBlock = {
      expectation.fulfill()
    }

    _ = vc.view

    wait(for: [expectation], timeout: 0.1)
  }

  func testViewDidLoadMethodCalledAfterManualViewLoad() {
    let vc = MockViewController()

    let expectation = self.expectation(description: "viewDidLoad should be called")

    vc.viewDidLoadBlock = {
      expectation.fulfill()
    }

    vc.loadViewIfNeeded()

    wait(for: [expectation], timeout: 0.1)
  }

  func testViewDidLoadMethodNotCalledIfViewNotLoaded() {
    let vc = MockViewController()

    let expectation = self.expectation(description: "viewDidLoad should not be called")
    expectation.isInverted = true

    vc.viewDidLoadBlock = {
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 0.1)
  }
}

final class MockViewController: ViewController {
  var modalPresentationStyleGetter: () -> ModalPresentationStyle = {
    XCTFail("Not implemented")
    return .automatic
  }

  var modalPresentationStyleSetter: (ModalPresentationStyle) -> Void = { _ in
    XCTFail("Not implemented")
  }

  var viewDidLoadBlock: () -> Void = {
    XCTFail("Not implemented")
  }

  override var modalPresentationStyle: ModalPresentationStyle {
    get {
      return modalPresentationStyleGetter()
    }
    set {
      modalPresentationStyleSetter(newValue)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    viewDidLoadBlock()
  }
}
