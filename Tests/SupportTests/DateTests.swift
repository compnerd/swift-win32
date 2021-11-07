// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
import WinSDK
import struct Foundation.Date
@testable import SwiftWin32

final class DateTests: XCTestCase {
  func testFileTimeConstruction() {
    XCTAssertEqual(FILETIME(timeIntervalSince1970: 0).timeIntervalSince1970, 0)
  }

  func testUnixEpoch() {
    let ftUnixEpoch: FILETIME = FILETIME(timeIntervalSince1970: 0)
    XCTAssertEqual(ftUnixEpoch.dwLowDateTime, 3577643008)
    XCTAssertEqual(ftUnixEpoch.dwHighDateTime, 27111902)

    let stUnixEpoch: SYSTEMTIME = SYSTEMTIME(ftUnixEpoch)
    XCTAssertEqual(stUnixEpoch.wYear, 1970)
    XCTAssertEqual(stUnixEpoch.wMonth, 1)
    XCTAssertEqual(stUnixEpoch.wDayOfWeek, 4)
    XCTAssertEqual(stUnixEpoch.wDay, 1)
    XCTAssertEqual(stUnixEpoch.wHour, 0)
    XCTAssertEqual(stUnixEpoch.wMinute, 0)
    XCTAssertEqual(stUnixEpoch.wSecond, 0)
    XCTAssertEqual(stUnixEpoch.wMilliseconds, 0)
  }

  func testSystemTimeConversion() {
    let stTimeStamp: SYSTEMTIME =
        SYSTEMTIME(wYear: 2020, wMonth: 11, wDayOfWeek: 0, wDay: 7,
                   wHour: 0, wMinute: 0, wSecond: 0, wMilliseconds: 0)
    XCTAssertEqual(FILETIME(stTimeStamp).timeIntervalSince1970,
                   1604707200)
  }

  func testFileTimeConversion() {
    let ftTimeStamp: FILETIME = FILETIME(timeIntervalSince1970: 1604707200)
    let stTimeStamp: SYSTEMTIME = SYSTEMTIME(ftTimeStamp)

    XCTAssertEqual(stTimeStamp.wYear, 2020)
    XCTAssertEqual(stTimeStamp.wMonth, 11)

    // We cannot check the day of week because it is ignored on the conversion
    // and we are going from UTC to local time zone to UTC, which changes the
    // day.
    /* XCTAssertEqual(stTimeStamp.wDayOfWeek, 0) */

    XCTAssertEqual(stTimeStamp.wDay, 7)
    XCTAssertEqual(stTimeStamp.wHour, 0)
    XCTAssertEqual(stTimeStamp.wMinute, 0)
    XCTAssertEqual(stTimeStamp.wSecond, 0)
    XCTAssertEqual(stTimeStamp.wMilliseconds, 0)
  }

  func testRoundTrip() {
    let ftSystemTimeInitial: SYSTEMTIME =
      SYSTEMTIME(wYear: 2020, wMonth: 11, wDayOfWeek: 6, wDay: 7,
                 wHour: 0, wMinute: 0, wSecond: 0, wMilliseconds: 0)
    let ftSystemTimeConverted: SYSTEMTIME =
        SYSTEMTIME(FILETIME(ftSystemTimeInitial))

    XCTAssertEqual(ftSystemTimeInitial.wYear, ftSystemTimeConverted.wYear)
    XCTAssertEqual(ftSystemTimeInitial.wMonth, ftSystemTimeConverted.wMonth)

    // We cannot check the day of week because it is ignored on the conversion
    // and we are going from UTC to local time zone to UTC, which changes the
    // day.
    /* XCTAssertEqual(ftSystemTimeInitial.wDayOfWeek, ftSystemTimeConverted.wDayOfWeek) */

    XCTAssertEqual(ftSystemTimeInitial.wDay, ftSystemTimeConverted.wDay)
    XCTAssertEqual(ftSystemTimeInitial.wHour, ftSystemTimeConverted.wHour)
    XCTAssertEqual(ftSystemTimeInitial.wMinute, ftSystemTimeConverted.wMinute)
    XCTAssertEqual(ftSystemTimeInitial.wSecond, ftSystemTimeConverted.wSecond)
    XCTAssertEqual(ftSystemTimeInitial.wMilliseconds, ftSystemTimeConverted.wMilliseconds)
  }

  static var allTests = [
    ("testFileTimeConstruction", testFileTimeConstruction),
    ("testUnixEpoch", testUnixEpoch),
    ("testSystemTimeConversion", testSystemTimeConversion),
    ("testFileTimeConversion", testFileTimeConversion),
    ("testRoundTrip", testRoundTrip),
  ]
}
