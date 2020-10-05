/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK
import Foundation

internal class WindowsMessageLoopSource: RunLoop._Source {
  private var observer: RunLoop._Observer?

  override func didSchedule(in mode: RunLoop.Mode) {
    self.observer = RunLoop.main._observe([.beforeSources]) { _ in
      var msg: MSG = MSG()
      if PeekMessageW(&msg, nil, 0, 0, UINT(PM_NOREMOVE | PM_NOYIELD)) {
        self.signal()
      }
    }
  }

  override func didCancel(in mode: RunLoop.Mode) {
    PostQuitMessage(0)
  }

  override func perform() {
    var msg: MSG = MSG()
    switch Int(GetMessageW(&msg, nil, 0, 0)) {
    case -1:
      log.error("GetMessageW: \(GetLastError())")

    case 0:
      assert(msg.message == UINT(WM_QUIT),
             "GetMessageW returned 0 with non-WM_QUIT message")
      RunLoop.main._stop()

    default:
      TranslateMessage(&msg)
      DispatchMessageW(&msg)
    }
  }
}
