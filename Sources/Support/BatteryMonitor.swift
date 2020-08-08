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
import class Foundation.NotificationCenter

private func ==<T: Equatable>(_ lhs: (T, T, T, T, T, T, T, T),
                              _ rhs: (T, T, T, T, T, T, T, T)) -> Bool {
  return lhs.0 == rhs.0 &&
         lhs.1 == rhs.1 &&
         lhs.2 == rhs.2 &&
         lhs.3 == rhs.3 &&
         lhs.4 == rhs.4 &&
         lhs.5 == rhs.5 &&
         lhs.6 == rhs.6 &&
         lhs.7 == rhs.7
}

private func ~=(_ lhs: GUID, _ rhs: GUID) -> Bool {
  return lhs.Data1 == rhs.Data1 &&
         lhs.Data2 == rhs.Data2 &&
         lhs.Data3 == rhs.Data3 &&
         lhs.Data4 == rhs.Data4
}

private let SwiftBatteryMonitorProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let monitor: BatteryMonitor? =
      unsafeBitCast(dwRefData, to: AnyObject.self) as? BatteryMonitor

  switch uMsg {
  case UINT(WM_POWERBROADCAST):
    guard wParam == PBT_POWERSETTINGCHANGE else {
      log.info("\(#function): uMsg: \(uMsg), wParam: \(wParam), lParam: \(lParam)")
      break
    }

    let pSetting: UnsafeMutablePointer<POWERBROADCAST_SETTING> =
        UnsafeMutablePointer<POWERBROADCAST_SETTING>(bitPattern: UInt(lParam))!
    let dwDataLength: DWORD = pSetting.pointee.DataLength

    switch pSetting.pointee.PowerSetting {
    case GUID_BATTERY_PERCENTAGE_REMAINING:
      assert(dwDataLength == MemoryLayout<DWORD>.size)
      let dwBatteryLevel: DWORD =
          withUnsafePointer(to: &pSetting.pointee.Data) {
            $0.withMemoryRebound(to: DWORD.self, capacity: 1) { $0.pointee }
          }

      NotificationCenter.default
          .post(name: Device.batteryLevelDidChangeNotification, object: nil)
    default:
      break
    }

  default:
    break
  }

  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

internal struct BatteryMonitor {
  private static let `class`: WindowClass =
      WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.BatteryMonitor")

  private var hWnd: HWND?
  private var hBatteryStateNotification: HPOWERNOTIFY?
  private var hPowerSourceNotification: HPOWERNOTIFY?

  public init() {
    self.hWnd = CreateWindowExW(0, BatteryMonitor.class.name, nil, 0, 0, 0, 0, 0,
                                HWND_MESSAGE, nil, GetModuleHandleW(nil), nil)
    guard let hWnd = self.hWnd else {
      log.warning("CreateWindowExW: \(GetLastError())")
      return
    }

    SetWindowSubclass(hWnd, SwiftBatteryMonitorProc, UINT_PTR(0),
                      unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))

    var setting: GUID = GUID_BATTERY_PERCENTAGE_REMAINING
    self.hBatteryStateNotification =
        RegisterPowerSettingNotification(self.hWnd, &setting,
                                         DWORD(DEVICE_NOTIFY_WINDOW_HANDLE))
    if self.hBatteryStateNotification == nil {
      log.warning("RegisterPowerSettingNotification: \(GetLastError())")
    }
  }
}
