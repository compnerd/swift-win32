/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK
import SwiftCOM

internal class OrientationSensorEventListener: SwiftCOM.ISensorEvents {
  public func OnEvent(_ pSensor: SwiftCOM.ISensor, _ eventID: REFGUID,
                      _ pEventData: SwiftCOM.IPortableDeviceValues) -> HRESULT {
    switch eventID.pointee {
    case SENSOR_EVENT_PROPERTY_CHANGED:
      break
    default:
      break
    }
    return S_OK
  }
}

internal class OrientationSensorManager {
  private var SensorManager: SwiftCOM.ISensorManager?
  private var OrientationSensor: SwiftCOM.ISensor?
  private var EventListener: SwiftWin32.OrientationSensorEventListener =
      OrientationSensorEventListener()

  public lazy var shared: OrientationSensorManager? = OrientationSensorManager()

  private init?() {
    do {
      self.SensorManager =
          try ISensorManager.CreateInstance(class: CLSID_SensorManager)
    } catch where (error as? COMError)?.hr == HRESULT_FROM_WIN32(DWORD(ERROR_ACCESS_DISABLED_BY_POLICY)) {
      // TODO(compnerd) unable to access SensorManager due to Group Policy
      // Settings, surface to the user
      return nil
    } catch {
      log.error("CoCreateInstance(CLSID_SensorManager, IID_ISensorManager): \(error)")
      return nil
    }

    guard let sensors =
        try? SensorManager?.GetSensorsByType(SENSOR_TYPE_AGGREGATED_DEVICE_ORIENTATION) else {
      return nil
    }

    // FIXME(compnerd) can we select a sensor in a better way?
    self.OrientationSensor = try? sensors.GetAt(0)
    if self.OrientationSensor == nil { return nil }

    // FIXME(compnerd) can we continue to an alternative sensor?
    switch try? self.OrientationSensor?.GetState() {
    case .some(SENSOR_STATE_ACCESS_DENIED):
      // Request Sensor Access
      do {
        try self.SensorManager?.RequestPermissions(nil, sensors, false)
      } catch where (error as? COMError)?.hr == HRESULT_FROM_WIN32(DWORD(ERROR_ACCESS_DENIED)) {
        // The user denied access to the sensor
        return nil
      } catch where (error as? COMError)?.hr == HRESULT_FROM_WIN32(DWORD(ERROR_CANCELLED)) {
        // The user cancelled the requested
        return nil
      } catch {
        log.error("ISensorManager::RequestPermissions: \(error)")
        return nil
      }
    case .none, .some(_):
      return nil
    }

    try? self.OrientationSensor?.SetEventSink(self.EventListener)
  }

  deinit {
    _ = try? self.OrientationSensor?.SetEventSink(nil)
  }
}
