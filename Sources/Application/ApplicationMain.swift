/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
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

@discardableResult
public func ApplicationMain(_ argc: Int32,
                            _ argv: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>,
                            _ application: Application?,
                            _ delegate: ApplicationDelegate?) -> Int32 {
  if let application = application {
    Application.shared = application
  }
  Application.shared.delegate = delegate

  // Enable Per Monitor DPI Awareness
  if !SetProcessDpiAwarenessContext(DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2) {
#if ENABLE_LOGGING
    log.error("SetProcessDpiAwarenessContext: \(GetLastError())")
#endif
  }

  var ICCE: INITCOMMONCONTROLSEX =
      INITCOMMONCONTROLSEX(dwSize: DWORD(MemoryLayout<INITCOMMONCONTROLSEX>.size),
                           dwICC: DWORD(ICC_BAR_CLASSES | ICC_LISTVIEW_CLASSES | ICC_NATIVEFNTCTL_CLASS | ICC_PROGRESS_CLASS | ICC_STANDARD_CLASSES))
  InitCommonControlsEx(&ICCE)

  if Application.shared.delegate?
        .application(Application.shared,
                     didFinishLaunchingWithOptions: nil) == false {
    return EXIT_FAILURE
  }

  var msg: MSG = MSG()
  while GetMessageW(&msg, nil, 0, 0) {
    TranslateMessage(&msg)
    DispatchMessageW(&msg)
  }

  return EXIT_SUCCESS
}

