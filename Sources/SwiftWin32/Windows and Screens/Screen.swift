/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

extension DEVICE_SCALE_FACTOR {
  internal var factor: Double {
    switch self {
    case SCALE_100_PERCENT: return 1.00
    case SCALE_120_PERCENT: return 1.20
    case SCALE_125_PERCENT: return 1.25
    case SCALE_140_PERCENT: return 1.40
    case SCALE_150_PERCENT: return 1.50
    case SCALE_160_PERCENT: return 1.60
    case SCALE_175_PERCENT: return 1.75
    case SCALE_180_PERCENT: return 1.80
    case SCALE_200_PERCENT: return 2.00
    case SCALE_225_PERCENT: return 2.25
    case SCALE_250_PERCENT: return 2.50
    case SCALE_300_PERCENT: return 3.00
    case SCALE_350_PERCENT: return 3.50
    case SCALE_400_PERCENT: return 4.00
    case SCALE_450_PERCENT: return 4.50
    case SCALE_500_PERCENT: return 5.00
    default: fatalError("unknown DEVICE_SCALE_FACTOR: \(self)")
    }
  }
}

public final class Screen {
  /// Returns the screen object representing the device's screen.
  public static var main: Screen { screens.first! }

  /// Returns an array containing all the screens attached to the device.
  public static var screens: [Screen] {
    let pfnEnumMonitor: MONITORENUMPROC = { hMonitor, hDC, lpRect, lParam in
      let pScreens: UnsafeMutablePointer<Array<Screen>> =
          UnsafeMutablePointer<Array<Screen>>(bitPattern: Int(lParam))!

      var info: MONITORINFOEXW = MONITORINFOEXW()
      info.cbSize = DWORD(MemoryLayout<MONITORINFOEXW>.size)
      if (withUnsafeMutablePointer(to: &info) {
        $0.withMemoryRebound(to: MONITORINFO.self, capacity: 1) {
          GetMonitorInfoW(hMonitor, $0)
        }
      }) == false { return false }

      let szDevice: String = withUnsafePointer(to: &info.szDevice) {
        $0.withMemoryRebound(to: WCHAR.self, capacity: MemoryLayout.size(ofValue: $0) / MemoryLayout<WCHAR>.size) {
          String(decodingCString: $0, as: UTF16.self)
        }
      }

      let _: DeviceContextHandle =
          ManagedHandle(owning: CreateDCW(szDevice.wide, nil, nil, nil))

      var dsfDeviceScaleFactor: DEVICE_SCALE_FACTOR = SCALE_100_PERCENT
      _ = GetScaleFactorForMonitor(hMonitor, &dsfDeviceScaleFactor)

      let screen: Screen =
          Screen(handle: hMonitor!,
                 height: info.rcMonitor.bottom, width: info.rcMonitor.right,
                 scale: dsfDeviceScaleFactor.factor)

      // The main screen is always at index 0
      if info.dwFlags & DWORD(MONITORINFOF_PRIMARY) == DWORD(MONITORINFOF_PRIMARY) {
        pScreens.pointee.insert(screen, at: 0)
      } else {
        pScreens.pointee.append(screen)
      }

      return true
    }

    var screens: [Screen] = []
    _ = withUnsafePointer(to: &screens) {
      EnumDisplayMonitors(nil, nil, pfnEnumMonitor, LPARAM(UInt(bitPattern: $0)))
    }
    return screens
  }

  /// The screen being mirrored by an external display.
  public var mirrored: Screen?

  /// The bounding rectangle of the screen, measured in points.
  public let bounds: Rect

  /// The bounding rectangle of the physical screen, measured in pixels.
  public let nativeBounds: Rect

  /// The native scale factor for the physical screen.
  public let nativeScale: Double

  /// The handle to the monitor that the screen represents.
  private let hMonitor: HMONITOR!

  public private(set) var traitCollection: TraitCollection

  private init(handle hMonitor: HMONITOR!, height: LONG, width: LONG,
               scale: Double) {
    self.hMonitor = hMonitor

    self.bounds = Rect(origin: Point(x: 0, y: 0),
                       size: Size(width: Double(width) / scale,
                                  height: Double(height) / scale))
    self.nativeBounds =
        Rect(origin: Point(x: 0, y: 0),
             size: Size(width: Double(width), height: Double(height)))
    self.nativeScale = scale

    self.traitCollection = TraitCollection(traitsFrom: [
      TraitCollection.current,
      TraitCollection(displayScale: scale),
    ])
  }
}

extension Screen: TraitEnvironment {
  public func traitCollectionDidChange(_ previousTraitCollection: TraitCollection?) {
    for screen in Screen.screens {
      var dpiX: UINT = 0
      var dpiY: UINT = 0
      guard GetDpiForMonitor(screen.hMonitor, MDT_EFFECTIVE_DPI,
                             &dpiX, &dpiY) == S_OK else {
        log.error("GetDpiForMonitor: invalid argument")
        fatalError()
      }

      // From MSDN: "The values of *dpiX and *dpiY are identical."
      assert(dpiX == dpiY)

      screen.traitCollection = TraitCollection(traitsFrom: [
        screen.traitCollection,
        TraitCollection(displayScale: Double(dpiX)),
      ])
    }
  }
}

extension Screen {
  internal static func == (_ lhs: Screen, _ rhs: HMONITOR) -> Bool {
    return lhs.hMonitor == rhs
  }

  internal static func == (_ lhs: HMONITOR, _ rhs: Screen) -> Bool {
    return rhs.hMonitor == lhs
  }
}

extension Screen: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "Screen(bounds: \(bounds), nativeScale: \(nativeScale))"
  }
}
