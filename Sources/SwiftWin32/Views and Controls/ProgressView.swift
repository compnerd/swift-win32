/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

public class ProgressView: Control {
  private static let `class`: WindowClass = WindowClass(named: PROGRESS_CLASS)
  private static let style: WindowStyle = (base: WS_POPUP, extended: 0)

  public init(frame: Rect) {
    super.init(frame: frame, class: ProgressView.class, style: ProgressView.style)
    SendMessageW(hWnd, UINT(PBM_SETRANGE32), 0, 100)
    SendMessageW(hWnd, UINT(PBM_SETPOS), 0, 0)
  }

  public func setProgress(_ progress: Float, animated: Bool) {
    SendMessageW(hWnd, UINT(PBM_SETPOS), WPARAM(100 * progress), 0)
  }
}
