// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest

public class ControlEventObserver {
  private var expectation: XCTestExpectation

  public init(expectation: XCTestExpectation) {
    self.expectation = expectation
  }

  public func observe() {
    self.expectation.fulfill()
  }
}
