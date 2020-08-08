/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

#if WITH_SWIFT_LOG
import Logging

internal let log: Logger = Logger(label: "org.compnerd.swift-win32")
#else
import WinSDK

internal struct log {
  static func trace(_ message: String) {
    OutputDebugStringW("TRACE: \(message)\r\n".LPCWSTR)
  }

  static func debug(_ message: String) {
    OutputDebugStringW("DEBUG: \(message)\r\n".LPCWSTR)
  }

  static func info(_ message: String) {
    OutputDebugStringW("INFO: \(message)\r\n".LPCWSTR)
  }

  static func notice(_ message: String) {
    OutputDebugStringW("NOTICE: \(message)\r\n".LPCWSTR)
  }

  static func error(_ message: String) {
    OutputDebugStringW("ERROR: \(message)\r\n".LPCWSTR)
  }

  static func warning(_ message: String) {
    OutputDebugStringW("WARNING: \(message)\r\n".LPCWSTR)
  }

  static func critical(_ message: String) {
    OutputDebugStringW("CRITICAL: \(message)\r\n".LPCWSTR)
  }
}
#endif
