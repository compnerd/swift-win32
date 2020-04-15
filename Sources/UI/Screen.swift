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

internal extension DEVICE_SCALE_FACTOR {
  var factor: Double {
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

extension HDC__: HandleValue {
  typealias HandleType = HDC
  internal static func release(_ hDC: HandleType?) {
    if let hDC = hDC {
      DeleteDC(hDC)
    }
  }
}

internal typealias DeviceContextHandle = ManagedHandle<HDC__>

public final class Screen {
  /// Returns the screen object representing the device's screen.
  static var main: Screen { screens.first! }

  /// Returns an array containing all the screens attached to the device.
  static var screens: [Screen] {
    let pfnEnumMonitor: MONITORENUMPROC = { hMonitor, hDC, lpRect, lParam in
      let pScreens: UnsafeMutablePointer<Array<Screen>> =
          UnsafeMutablePointer<Array<Screen>>(bitPattern: Int(lParam))!

      var info: MONITORINFOEXW = MONITORINFOEXW()
      info.s.cbSize = DWORD(MemoryLayout<MONITORINFOEXW>.size)
      if !GetMonitorInfoW(hMonitor, &info.s) {
        return false
      }

      let szDevice: String = withUnsafePointer(to: &info.szDevice) {
        $0.withMemoryRebound(to: WCHAR.self, capacity: MemoryLayout.size(ofValue: $0) / MemoryLayout<WCHAR>.size) {
          String(decodingCString: $0, as: UTF16.self)
        }
      }

      let _: DeviceContextHandle =
          ManagedHandle(owning: CreateDCW(szDevice.LPCWSTR, nil, nil, nil))

      var dsfDevceScaleFactor: DEVICE_SCALE_FACTOR = SCALE_100_PERCENT
      _ = GetScaleFactorForMonitor(hMonitor, &dsfDevceScaleFactor)

      let screen: Screen =
          Screen(height: info.s.rcMonitor.bottom, width: info.s.rcMonitor.right,
                 scale: dsfDevceScaleFactor.factor)

      // The main screen is always at index 0
      if info.s.dwFlags & DWORD(MONITORINFOF_PRIMARY) == DWORD(MONITORINFOF_PRIMARY) {
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

  private init(height: LONG, width: LONG, scale: Double) {
    self.bounds = Rect(origin: Point(x: 0, y: 0),
                       size: Size(width: Double(width) / scale,
                                  height: Double(height) / scale))
    self.nativeBounds =
        Rect(origin: Point(x: 0, y: 0),
             size: Size(width: Double(width), height: Double(height)))
    self.nativeScale = scale
  }
}

extension Screen: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "Screen(bounds: \(bounds), nativeScale: \(nativeScale))"
  }
}
