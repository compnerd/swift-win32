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
import class Foundation.NSNotification

public struct Device {
  public static let current: Device = Device()

  /// Is multitasking supported on the current device
  public internal(set) var isMultitaskingSupported: Bool = true

  /// The name identifyying the device
  public var name: String {
    let value: [WCHAR] = Array<WCHAR>(unsafeUninitializedCapacity: Int(MAX_COMPUTERNAME_LENGTH) + 1) {
      var nSize: DWORD = DWORD($0.count)
      $1 = GetComputerNameW($0.baseAddress!, &nSize) ? Int(nSize) : 0
    }
    return String(decodingCString: value, as: UTF16.self)
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
        log.warning("RegGetValueW: \(lStatus)")
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
        log.warning("RegGetValueW: \(lStatus)")
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

  /// Tracking the Device Orientation
  public var orientation: Device.Orientation {
    var dmDeviceMode: DEVMODEW = DEVMODEW()
    dmDeviceMode.dmSize = WORD(MemoryLayout<DEVMODEW>.size)
    dmDeviceMode.dmDriverExtra = 0
    if !EnumDisplaySettingsExW(nil, ENUM_CURRENT_SETTINGS, &dmDeviceMode, 0) {
      log.warning("EnumDisplaySettingsExW: \(GetLastError())")
      return .unknown
    }

    let dwRequiredFields: DWORD =
        DWORD(DM_PELSWIDTH | DM_PELSHEIGHT | DM_DISPLAYORIENTATION)
    guard dmDeviceMode.dmFields & dwRequiredFields == dwRequiredFields else {
      return .unknown
    }

    switch dmDeviceMode.u.s2.dmDisplayOrientation {
    case DWORD(DMDO_90), DWORD(DMDO_270):
      swap(&dmDeviceMode.dmPelsHeight, &dmDeviceMode.dmPelsWidth)
    case DWORD(DMDO_DEFAULT), DWORD(DMDO_180):
      break
    default:
      log.error("unknown display orientation: \(dmDeviceMode.u.s2.dmDisplayOrientation)")
      return .unknown
    }

    let bPortrait: Bool = dmDeviceMode.dmPelsWidth < dmDeviceMode.dmPelsHeight
    switch dmDeviceMode.u.s2.dmDisplayOrientation {
    case DWORD(DMDO_DEFAULT):
      return bPortrait ? .portrait : .landscape
    case DWORD(DMDO_90):
      return bPortrait ? .landscapeRight : .portrait
    case DWORD(DMDO_180):
      return bPortrait ? .portraitUpsideDown : .landscapeRight
    case DWORD(DMDO_270):
      return bPortrait ? .landscape : .portraitUpsideDown
    default:
      return .unknown
    }
  }

  public var isGeneratingDeviceOrientationNotifications: Bool = false

  public func beginGeneratingDeviceOrientationNotifications() {
    // TODO(compnerd) implement this
  }

  public func endGeneratingDeviceOrientationNotifications() {
    // TODO(compnerd) implement this
  }

  /// Determining the Current Orientation
  public var isPortrait: Bool {
    switch self.orientation {
    case .portrait, .portraitUpsideDown: return true
    default: return false
    }
  }

  public var isLandscape: Bool {
    switch self.orientation {
    case .landscapeLeft, .landscapeRight: return true
    default: return false
    }
  }

  public var isValidIntefaceOrientation: Bool {
    true
  }

  /// Getting the Device Battery State
  public var batteryLevel: Float {
    guard Device.current.isBatteryMonitoringEnabled else { return -1.0 }

    var status: SYSTEM_POWER_STATUS = SYSTEM_POWER_STATUS()
    guard GetSystemPowerStatus(&status) else {
      log.warning("GetSystemPowerStatus: \(GetLastError())")
      return -1.0
    }

    if status.BatteryLifePercent == 255 { return -1.0 }
    return Float(status.BatteryLifePercent) / 100.0
  }

  private var batteryMonitor: BatteryMonitor?
  public var isBatteryMonitoringEnabled: Bool = false {
    didSet {
      self.batteryMonitor =
          self.isBatteryMonitoringEnabled
              ? (self.batteryMonitor ?? BatteryMonitor())
              : nil
    }
  }

  public var batteryState: Device.BatteryState {
    guard Device.current.isBatteryMonitoringEnabled else { return .unknown }

    var status: SYSTEM_POWER_STATUS = SYSTEM_POWER_STATUS()
    guard GetSystemPowerStatus(&status) else {
      log.warning("GetSystemPowerStatus: \(GetLastError())")
      return .unknown
    }

    // If the system does not have a battery (e.g. desktop system), present as
    // `unknown`.
    guard status.BatteryFlag & BYTE(BATTERY_FLAG_NO_BATTERY) == 0 else {
      return .unknown
    }

    // If AC power is offline, we are unplugged.
    if status.ACLineStatus & BYTE(AC_LINE_OFFLINE) == BYTE(AC_LINE_OFFLINE) {
      return .unplugged
    }

    // Either we are `charging` or the battery is `full`.
    return status.BatteryFlag & BYTE(BATTERY_FLAG_CHARGING) == BYTE(BATTERY_FLAG_CHARGING)
        ? .charging
        : .full
  }
}

extension Device {
  public enum BatteryState: Int {
  case unknown
  case unplugged
  case charging
  case full
  }
}

extension Device {
  public enum Orientation: Int {
  case unknown
  case portrait
  case portraitUpsideDown
  case landscapeLeft
  case landscapeRight
  case faceUp
  case faceDown
  }
}

extension Device {
  public static let batteryLevelDidChangeNotification: NSNotification.Name =
      NSNotification.Name(rawValue: "UIDeviceBatteryLevelDidChangeNotification")
  public static let batteryStateDidChangeNotification: NSNotification.Name =
      NSNotification.Name(rawValue: "UIDeviceBatteryStateDidChangeNotification")
  public static let orientationDidChangeNotification: NSNotification.Name =
      NSNotification.Name(rawValue: "UIDeviceOrientationDidChangeNotification")
  public static let proximityStateDidChangeNotification: NSNotification.Name =
      NSNotification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification")
}

extension Device.Orientation {
  internal static let landscape: Device.Orientation = .landscapeLeft
}
