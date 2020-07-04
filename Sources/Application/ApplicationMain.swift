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

private let pApplicationWindowProc: HOOKPROC = { (nCode: Int32, wParam: WPARAM, lParam: LPARAM) -> LRESULT in
  guard nCode == HC_ACTION else {
    return CallNextHookEx(nil, nCode, wParam, lParam)
  }

  if let pMessage = UnsafeMutablePointer<CWPSTRUCT>(bitPattern: UInt(lParam)) {
    switch pMessage.pointee.message {
    case UINT(WM_ACTIVATEAPP):
      let application: Application = Application.shared
      let bActivation: Bool = pMessage.pointee.wParam > 0
      if bActivation {
        // quiesce foreground notifications
        if application.state == .active { break }
        application.delegate?.applicationWillEnterForeground(application)
        application.state = .active
        application.delegate?.applicationDidBecomeActive(application)
      } else {
        // quiesce background notifications
        if application.state == .background { break }
        application.delegate?.applicationWillResignActive(application)
        Application.shared.state = .background
        application.delegate?.applicationDidEnterBackground(application)
      }
    default:
      break
    }
  }

  return CallNextHookEx(nil, nCode, wParam, lParam)
}

private let pApplicationMessageProc: HOOKPROC = { (nCode: Int32, wParam: WPARAM, lParam: LPARAM) -> LRESULT in
  guard nCode == HC_ACTION else {
    return CallNextHookEx(nil, nCode, wParam, lParam)
  }

  return CallNextHookEx(nil, nCode, wParam, lParam)
}

private func NSClassFromString(_ string: String) -> AnyClass? {
  return _typeByName(string) as? AnyClass
}

@discardableResult
public func ApplicationMain(_ argc: Int32,
                            _ argv: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>,
                            _ application: String?,
                            _ delegate: String?) -> Int32 {
  if let application = application {
    guard let instance = NSClassFromString(application) else {
      fatalError("unable to find application class: \(application)")
    }
    Application.shared = (instance as! Application.Type).init()
  }
  if let delegate = delegate {
    guard let instance = NSClassFromString(delegate) else {
      fatalError("unable to find delegate class: \(delegate)")
    }
    Application.shared.delegate = (instance as! ApplicationDelegate.Type).init()
  }

  // Enable Per Monitor DPI Awareness
  if !SetProcessDpiAwarenessContext(DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2) {
    log.error("SetProcessDpiAwarenessContext: \(GetLastError())")
  }

  var ICCE: INITCOMMONCONTROLSEX =
      INITCOMMONCONTROLSEX(dwSize: DWORD(MemoryLayout<INITCOMMONCONTROLSEX>.size),
                           dwICC: DWORD(ICC_BAR_CLASSES | ICC_LISTVIEW_CLASSES | ICC_NATIVEFNTCTL_CLASS | ICC_PROGRESS_CLASS | ICC_STANDARD_CLASSES))
  InitCommonControlsEx(&ICCE)

  var hSwiftWin32: HMODULE?
  if !GetModuleHandleExW(DWORD(GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT),
                               "SwiftWin32.dll".LPCWSTR, &hSwiftWin32) {
    log.error("GetModuleHandleExW: \(GetLastError())")
  }

  let hWindowProcedureHook: HHOOK? =
      SetWindowsHookExW(WH_CALLWNDPROC, pApplicationWindowProc, hSwiftWin32, 0)
  if hWindowProcedureHook == nil {
    log.error("SetWindowsHookExW(WH_CALLWNDPROC): \(GetLastError())")
  }

  let hMessageProcedureHook: HHOOK? =
      SetWindowsHookExW(WH_GETMESSAGE, pApplicationMessageProc, hSwiftWin32, 0)
  if hMessageProcedureHook == nil {
    log.error("SetWindowsHookExW(WH_GETMESSAGE): \(GetLastError())")
  }

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

  if let hMessageProcedureHook = hMessageProcedureHook {
    if !UnhookWindowsHookEx(hMessageProcedureHook) {
      log.error("UnhookWindowsHookEx(MsgProc): \(GetLastError())")
    }
  }

  if let hWindowProcedureHook = hWindowProcedureHook {
    if !UnhookWindowsHookEx(hWindowProcedureHook) {
      log.error("UnhookWindowsHookEx(WndProc): \(GetLastError())")
    }
  }

  return EXIT_SUCCESS
}
