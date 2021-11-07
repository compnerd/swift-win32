// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
import WinSDK
import Foundation
@testable import SwiftWin32

final class DatePickerTests: XCTestCase {
  func testDateAccessors() {
    var ftSystemTime: FILETIME = FILETIME()
    GetSystemTimeAsFileTime(&ftSystemTime)
    var ftLocalSystemTime: FILETIME = FILETIME()
    FileTimeToLocalFileTime(&ftSystemTime, &ftLocalSystemTime)

    let datepicker: DatePicker = DatePicker(frame: .zero)

    let time: Date =
        Date(timeIntervalSince1970: ftLocalSystemTime.timeIntervalSince1970)
    // FIXME(compnerd) can we use a tigher bounds?
    XCTAssertTrue(datepicker.date.distance(to: time) <= 1.0)

    datepicker.date = Date(timeIntervalSinceReferenceDate: 410220000)
    XCTAssertEqual(datepicker.date,
                   Date(timeIntervalSinceReferenceDate: 410220000))
  }

  static var allTests = [
    ("testDateAccessors", testDateAccessors),
  ]
}
