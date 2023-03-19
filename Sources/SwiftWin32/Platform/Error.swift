// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

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
    let dwFlags: DWORD = DWORD(FORMAT_MESSAGE_ALLOCATE_BUFFER)
                       | DWORD(FORMAT_MESSAGE_FROM_SYSTEM)
                       | DWORD(FORMAT_MESSAGE_IGNORE_INSERTS)

    let short: String
    let dwResult: DWORD
    var buffer: UnsafeMutablePointer<WCHAR>?

    switch self.code {
    case .errno(let errno):
      short = "errno \(errno)"

      // MSDN indicates that the returned string can have a maximum of 94
      // characters, so allocate 95 characters.
#if swift(>=5.6)
      return withUnsafeTemporaryAllocation(of: wchar_t.self, capacity: 95) {
        let result: errno_t = _wcserror_s($0.baseAddress, $0.count, errno)
        guard result == 0 else { return short }
        return "\(short) - \(String(decodingCString: $0.baseAddress!, as: UTF16.self))"
      }
#else
      let buffer: UnsafeMutablePointer<wchar_t> = .allocate(capacity: 95)
      defer { buffer.deallocate() }

      let result: errno_t = _wcserror_s(buffer, 95, errno)
      guard result == 0 else { return short }
      return "\(short) - \(String(decodingCString: buffer, as: UTF16.self))"
#endif

    case .win32(let error):
      short = "Win32 Error \(error)"

      dwResult = withUnsafeMutablePointer(to: &buffer) {
        $0.withMemoryRebound(to: WCHAR.self, capacity: 2) {
          FormatMessageW(dwFlags, nil, error,
                         MAKELANGID(WORD(LANG_NEUTRAL), WORD(SUBLANG_DEFAULT)),
                         $0, 0, nil)
        }
      }


    case .nt(let status):
      short = "NTSTATUS 0x\(String(status, radix: 16))"

      dwResult = withUnsafeMutablePointer(to: &buffer) {
        $0.withMemoryRebound(to: WCHAR.self, capacity: 2) {
          FormatMessageW(dwFlags, nil, status,
                         MAKELANGID(WORD(LANG_NEUTRAL), WORD(SUBLANG_DEFAULT)),
                         $0, 0, nil)
        }
      }

    case .hresult(let hr):
      short = "HRESULT 0x\(String(hr, radix: 16))"

      dwResult = withUnsafeMutablePointer(to: &buffer) {
        $0.withMemoryRebound(to: WCHAR.self, capacity: 2) {
          FormatMessageW(dwFlags, nil, hr,
                         MAKELANGID(WORD(LANG_NEUTRAL), WORD(SUBLANG_DEFAULT)),
                         $0, 0, nil)
        }
      }
    }

    guard dwResult > 0, let message = buffer else { return short }
    defer { LocalFree(buffer) }
    return "\(short) - \(String(decodingCString: message, as: UTF16.self))"
  }
}
