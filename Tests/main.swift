// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>.
// SPDX-License-Identifier: BSD-3-Clause

import XCTest

@testable import AutoLayoutTests
@testable import CoreGraphicsTests
@testable import UICoreTests

XCTMain([
  testCase(AutoLayoutTests.allTests),
  testCase(CoreGraphicsTests.allTests),
  testCase(UICoreTests.allTests),
])
