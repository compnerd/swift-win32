// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3

import XCTest
import WinSDK
import TestUtilities
@testable import SwiftWin32

final class StepperTests: XCTestCase {
  func testValueChangedNotification() {
    let stepper: Stepper = Stepper(frame: .zero)

    let expectation: XCTestExpectation =
        self.expectation(description: "value change notification dispatched")
    let observer: ControlEventObserver =
        ControlEventObserver(expectation: expectation)

    withExtendedLifetime(observer) {
      stepper.addTarget(observer, action: ControlEventObserver.observe,
                        for: .valueChanged)

      // TODO(compnerd) this is a workaround until UIAutomation is properly
      // wired up.  We bypass the Windows UI subsystem, sending the underlying
      // `WM_HSCROLL` directly to the proxy.
      if let hWnd = FindWindowW("Swift.Stepper.Proxy".wide, nil) {
        _ = SendMessageW(hWnd, DWORD(WM_HSCROLL), WPARAM(0),
                         LPARAM(UInt(bitPattern: stepper.hWnd)))
      }
    }

    // FIXME(compnerd) what is a good timeout value to use?
    waitForExpectations(timeout: 1)
  }

  func testValueChangedNotificationFailure() {
    let stepper: Stepper = Stepper(frame: .zero)

    let expectation: XCTestExpectation =
        self.expectation(description: "value change notification dispatched")
    expectation.isInverted = true

    let observer: ControlEventObserver =
        ControlEventObserver(expectation: expectation)

    withExtendedLifetime(observer) {
      stepper.addTarget(observer, action: ControlEventObserver.observe,
                        for: .valueChanged)

      // TODO(compnerd) this is a workaround until UIAutomation is properly
      // wired up.  We bypass the Windows UI subsystem, sending the underlying
      // `WM_HSCROLL` directly to the proxy.
      if let hWnd = FindWindowW("Swift.Stepper.Proxy".wide, nil) {
        _ = SendMessageW(hWnd, DWORD(WM_HSCROLL), WPARAM(0), LPARAM(0))
      }
    }

    // FIXME(compnerd) what is a good timeout value to use?
    waitForExpectations(timeout: 1)
  }
}
