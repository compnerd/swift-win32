// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

import struct Foundation.Date
import struct Foundation.TimeInterval

// 100 nanosecond ticks
@_transparent
internal var WindowsTick: Double { 10_000_000 }

// NT to Unix Epoch (seconds)
@_transparent
internal var NTToUnixEpochBias: Double { 11_644_473_600 }

extension FILETIME {
  @inline(__always)
  internal init(_ systemTime: SYSTEMTIME) {
    self = FILETIME()
    withUnsafePointer(to: systemTime) {
      guard SystemTimeToFileTime($0, &self) else {
        fatalError("SystemTimeToFileTime: \(Error(win32: GetLastError()))")
      }
    }
  }

  @inline(__always)
  internal init(timeIntervalSince1970 interval: TimeInterval) {
    let value = UInt64((interval + NTToUnixEpochBias) * WindowsTick)
    self = FILETIME(dwLowDateTime: DWORD((value >> 0) & 0xffffffff),
                    dwHighDateTime: DWORD((value >> 32) & 0xffffffff))
  }

  @inline(__always)
  internal var timeIntervalSince1970: TimeInterval {
    var ulTime: ULARGE_INTEGER = ULARGE_INTEGER()
    ulTime.LowPart = self.dwLowDateTime
    ulTime.HighPart = self.dwHighDateTime
    return Double(ulTime.QuadPart) / WindowsTick - NTToUnixEpochBias
  }
}

extension SYSTEMTIME {
  @inline(__always)
  internal init(_ fileTime: FILETIME) {
    self = SYSTEMTIME()
    withUnsafePointer(to: fileTime) {
      guard FileTimeToSystemTime($0, &self) else {
        fatalError("FileTimeToSystemTime: \(Error(win32: GetLastError()))")
      }
    }
  }
}
