/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
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
      log.warning("CreateWindowExW: \(Error(win32: GetLastError()))")
      return
    }

    SetWindowSubclass(hWnd, SwiftBatteryMonitorProc, UINT_PTR(0),
                      unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))

    var setting: GUID = GUID_BATTERY_PERCENTAGE_REMAINING
    self.hBatteryStateNotification =
        RegisterPowerSettingNotification(self.hWnd, &setting,
                                         DWORD(DEVICE_NOTIFY_WINDOW_HANDLE))
    if self.hBatteryStateNotification == nil {
      log.warning("RegisterPowerSettingNotification: \(Error(win32: GetLastError()))")
    }
  }
}
