// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if WITH_SWIFT_LOG
import Logging

internal let log: Logger = Logger(label: "org.compnerd.swift-win32")
#else
import WinSDK

internal struct log {
  static func trace(_ message: String) {
    OutputDebugStringW("TRACE: \(message)\r\n".wide)
  }

  static func debug(_ message: String) {
    OutputDebugStringW("DEBUG: \(message)\r\n".wide)
  }

  static func info(_ message: String) {
    OutputDebugStringW("INFO: \(message)\r\n".wide)
  }

  static func notice(_ message: String) {
    OutputDebugStringW("NOTICE: \(message)\r\n".wide)
  }

  static func error(_ message: String) {
    OutputDebugStringW("ERROR: \(message)\r\n".wide)
  }

  static func warning(_ message: String) {
    OutputDebugStringW("WARNING: \(message)\r\n".wide)
  }

  static func critical(_ message: String) {
    OutputDebugStringW("CRITICAL: \(message)\r\n".wide)
  }
}
#endif
