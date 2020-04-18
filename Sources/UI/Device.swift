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

import WinSDK

public enum UserInterfaceIdiom: Int {
case unspecified
case phone
case pad
case tv
case carPlay
}

public struct Device {
  public static let current: Device = Device()

  /// Is multitasking supported on the current device
  public internal(set) var isMultitaskingSupported: Bool = true

  /// The name identifyying the device
  public var name: String {
    var szBuffer: [WCHAR] =
        Array<WCHAR>(repeating: 0, count: Int(MAX_COMPUTERNAME_LENGTH) + 1)
    var nSize: DWORD = DWORD(szBuffer.count)
    guard GetComputerNameW(&szBuffer, &nSize) else {
#if ENABLE_LOGGING
      log.warning("GetComputerNameW: \(GetLastError())")
#endif
      return ""
    }
    return String(decodingCString: szBuffer, as: UTF16.self)
  }

  /// The name of the operating system running on the device represented by the
  // receiver.
  public var systemName: String {
    var szBuffer: [WCHAR] = Array<WCHAR>(repeating: 0, count: 64)
    while true {
      var cbData: DWORD = DWORD(szBuffer.count * MemoryLayout<WCHAR>.size)
      let lStatus: LSTATUS =
          RegGetValueW(HKEY_LOCAL_MACHINE,
                       "SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion".LPCWSTR,
                       "ProductName".LPCWSTR,
                       DWORD(RRF_RT_REG_SZ | RRF_ZEROONFAILURE),
                       nil, &szBuffer, &cbData)
      if lStatus == ERROR_MORE_DATA {
        szBuffer = Array<WCHAR>(repeating: 0, count: szBuffer.count * 2)
        continue
      }
      guard lStatus == 0 else {
#if ENABLE_LOGGING
        log.warning("RegGetValueW: \(lStatus)")
#endif
        return ""
      }
      return String(decodingCString: szBuffer, as: UTF16.self)
    }
  }

  /// The current version of the operating system.
  public var systemVersion: String {
    var szBuffer: [WCHAR] = Array<WCHAR>(repeating: 0, count: 64)
    while true {
      var cbData: DWORD = DWORD(szBuffer.count * MemoryLayout<WCHAR>.size)
      let lStatus: LSTATUS =
          RegGetValueW(HKEY_LOCAL_MACHINE,
                       "SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion".LPCWSTR,
                       "CurrentBuildNumber".LPCWSTR,
                       DWORD(RRF_RT_REG_SZ | RRF_ZEROONFAILURE),
                       nil, &szBuffer, &cbData)
      if lStatus == ERROR_MORE_DATA {
        szBuffer = Array<WCHAR>(repeating: 0, count: szBuffer.count * 2)
        continue
      }
      guard lStatus == 0 else {
#if ENABLE_LOGGING
        log.warning("RegGetValueW: \(lStatus)")
#endif
        return ""
      }
      return String(decodingCString: szBuffer, as: UTF16.self)
    }
  }

  /// The model of the device.
  public var model: String {
    fatalError("\(#function) not implemented")
  }

  public var localizedModel: String {
    fatalError("\(#function) not implemented")
  }

  /// The style of interface to use on the current device.
  public var userInterfaceIdiom: UserInterfaceIdiom {
    return .unspecified
  }

  /// An alphanumeric string that uniquely identifies a device to the
  /// application vendor.
  public var identifierForVendor: UUID? {
    // TODO(compnerd) should be Windows.System.Profile.GetSystemIdForPublisher()
    return nil
  }
}