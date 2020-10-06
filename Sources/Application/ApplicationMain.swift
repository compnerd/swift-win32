/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK
import Foundation

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

@discardableResult
public func ApplicationMain(_ argc: Int32,
                            _ argv: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>,
                            _ application: String?,
                            _ delegate: String?) -> Int32 {
  let hRichEdit: HMODULE? = LoadLibraryW("msftedit.dll".LPCWSTR)
  if hRichEdit == nil {
    log.error("unable to load `msftedit.dll`: \(Error(win32: GetLastError()))")
  }

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

  if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
      if let contents = FileManager.default.contents(atPath: path) {
        Application.shared.information =
            try? PropertyListDecoder().decode(Application.Information.self,
                                              from: contents)
      }
  }

  // Enable Per Monitor DPI Awareness
  if !SetProcessDpiAwarenessContext(DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2) {
    log.error("SetProcessDpiAwarenessContext: \(Error(win32: GetLastError()))")
  }

  let dwICC: DWORD = DWORD(ICC_BAR_CLASSES)
                   | DWORD(ICC_DATE_CLASSES)
                   | DWORD(ICC_LISTVIEW_CLASSES)
                   | DWORD(ICC_NATIVEFNTCTL_CLASS)
                   | DWORD(ICC_PROGRESS_CLASS)
                   | DWORD(ICC_STANDARD_CLASSES)
  var ICCE: INITCOMMONCONTROLSEX =
      INITCOMMONCONTROLSEX(dwSize: DWORD(MemoryLayout<INITCOMMONCONTROLSEX>.size),
                           dwICC: dwICC)
  InitCommonControlsEx(&ICCE)

  var hSwiftWin32: HMODULE?
  if !GetModuleHandleExW(DWORD(GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT),
                         "SwiftWin32.dll".LPCWSTR, &hSwiftWin32) {
    log.error("GetModuleHandleExW: \(Error(win32: GetLastError()))")
  }

  let hWindowProcedureHook: HHOOK? =
      SetWindowsHookExW(WH_CALLWNDPROC, pApplicationWindowProc, hSwiftWin32, GetCurrentThreadId())
  if hWindowProcedureHook == nil {
    log.error("SetWindowsHookExW(WH_CALLWNDPROC): \(Error(win32: GetLastError()))")
  }

  defer {
    if let hWindowProcedureHook = hWindowProcedureHook {
      if !UnhookWindowsHookEx(hWindowProcedureHook) {
        log.error("UnhookWindowsHookEx(WndProc): \(Error(win32: GetLastError()))")
      }
    }
  }

  if Application.shared.delegate?
        .application(Application.shared,
                     didFinishLaunchingWithOptions: nil) == false {
    return EXIT_FAILURE
  }

  // TODO(compnerd) populate these based on the application instantiation
  let options: Scene.ConnectionOptions = Scene.ConnectionOptions()

  // Setup the scene session.
  let (_, session) =
      Application.shared.openSessions
          .insert(SceneSession(identifier: UUID().uuidString,
                               role: .windowApplication))

  // Update the scene configuration based on the delegate's response.
  if let configuration = Application.shared.delegate?
      .application(Application.shared, configurationForConnecting: session,
                   options: options) {
    session.configuration = configuration
  }

  // Create the scene.
  if let `class` = session.configuration.sceneClass,
     let SceneType = `class` as? Scene.Type {
    let (_, scene) =
        Application.shared.connectedScenes
            .insert(SceneType.init(session: session, connectionOptions: options))

    if let `class` = session.configuration.delegateClass,
       let DelegateType = `class` as? SceneDelegate.Type {
        scene.delegate = DelegateType.init()
    }

    scene.delegate?.scene(scene, willConnectTo: session, options: options)
    session.scene = scene
  }

  var msg: MSG = MSG()
  while GetMessageW(&msg, nil, 0, 0) > 0 {
    TranslateMessage(&msg)
    DispatchMessageW(&msg)
  }

  Application.shared.delegate?.applicationWillTerminate(Application.shared)

  return EXIT_SUCCESS
}

extension ApplicationDelegate {
  public static func main() {
    ApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil,
                    String(describing: String(reflecting: Self.self)))
  }
}
