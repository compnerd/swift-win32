/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import ucrt
import WinSDK

internal struct Error: Swift.Error {
  private enum ErrorCode {
    case errno(errno_t)
    case win32(DWORD)
    case nt(DWORD)
    case hresult(DWORD)
  }

  private let code: ErrorCode

  public init(win32 error: DWORD) {
    self.code = .win32(error)
  }

  public init(nt error: DWORD) {
    self.code = .nt(error)
  }

  public init(hresult hr: DWORD) {
    self.code = .hresult(hr)
  }

  public init(errno: errno_t) {
    self.code = .errno(errno)
  }
}

extension Error: CustomStringConvertible {
  public var description: String {
    switch self.code {
    case .errno(let errno):
      if let description = _wcserror(errno) {
        return "errno \(errno) - \(String(decodingCString: description, as: UTF16.self))"
      }
      return "errno: \(errno)"

    case .win32(let error):
      let buffer: UnsafeMutablePointer<WCHAR>? = nil
      let dwResult: DWORD =
          FormatMessageW(DWORD(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS),
                         nil, error, MAKELANGID(WORD(LANG_NEUTRAL), WORD(SUBLANG_DEFAULT)),
                         buffer, 0, nil)
      guard dwResult == 0, let message = buffer else {
        return "Error \(error)"
      }
      defer { LocalFree(buffer) }
      return "Win32 Error \(error) - \(String(decodingCString: message, as: UTF16.self)))"

    case .nt(let status):
      let buffer: UnsafeMutablePointer<WCHAR>? = nil
      let dwResult: DWORD =
          FormatMessageW(DWORD(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS),
                         nil, status, MAKELANGID(WORD(LANG_NEUTRAL), WORD(SUBLANG_DEFAULT)),
                         buffer, 0, nil)
      guard dwResult == 0, let message = buffer else {
        return "NTSTATUS: 0x\(String(status, radix: 16))"
      }
      defer { LocalFree(buffer) }
      return "0x\(String(status, radix: 16)) - \(String(decodingCString: message, as: UTF16.self))"

    case .hresult(let hr):
      let buffer: UnsafeMutablePointer<WCHAR>? = nil
      let dwResult: DWORD =
          FormatMessageW(DWORD(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS),
                         nil, hr, MAKELANGID(WORD(LANG_NEUTRAL), WORD(SUBLANG_DEFAULT)),
                         buffer, 0, nil)
      guard dwResult == 0, let message = buffer else {
        return "HRESULT: 0x\(String(hr, radix: 16))"
      }
      defer { LocalFree(buffer) }
      return "0x\(String(hr, radix: 16)) - \(String(decodingCString: message, as: UTF16.self))"
    }
  }
}
