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
