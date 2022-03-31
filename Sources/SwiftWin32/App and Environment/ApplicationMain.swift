// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK
import SwiftCOM
import Foundation

internal final class Delegate: ApplicationDelegate {}

private let pApplicationStateChangeRoutine: PAPPSTATE_CHANGE_ROUTINE = { (quiesced: UInt8, context: PVOID?) in
  let foregrounding: Bool = quiesced == 0
  if foregrounding {
    Application.shared.delegate?
        .applicationWillEnterForeground(Application.shared)

    // Post ApplicationDelegate.willEnterForegroundNotification
    NotificationCenter.default
        .post(name: Delegate.willEnterForegroundNotification,
              object: Application.shared)
  } else {
    Application.shared.delegate?
        .applicationDidEnterBackground(Application.shared)

    // Post ApplicationDelegate.willEnterBackgroundNotification
    NotificationCenter.default
        .post(name: Delegate.didEnterBackgroundNotification,
              object: Application.shared)
  }
}

// Waits for a message on the message queue, returning when either a message has
// arrived or the timeout specified has expired.
private func WaitMessage(_ dwMilliseconds: UINT) -> Bool {
  let uIDEvent = WinSDK.SetTimer(nil, 0, dwMilliseconds, nil)
  defer { WinSDK.KillTimer(nil, uIDEvent) }
  return WinSDK.WaitMessage()
}

@discardableResult
public func ApplicationMain(_ argc: Int32,
                            _ argv: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>,
                            _ application: String?,
                            _ delegate: String?) -> Int32 {
  let hRichEdit: HMODULE? = LoadLibraryW("msftedit.dll".wide)
  if hRichEdit == nil {
    log.error("unable to load `msftedit.dll`: \(Error(win32: GetLastError()))")
  }

  var information: Application.Information?
  if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
      let contents = FileManager.default.contents(atPath: path) {
    information = try? PropertyListDecoder().decode(Application.Information.self,
                                                    from: contents)
  }

  // Setup the main application class.  The following order describes how the
  // user may actually configure the selected class:
  //
  //    1. `application`: the parameter passd to `ApplicationMain(_:_:_:_:)`
  //    2. `PrincipalClass`: the value configured in `Info.plist`
  //    3. `Application`: the default application class provided by Swift/Win32
  //
  // We must have an application class to instantiate as this is the main entry
  // point which is executed by this framework.
  let application = application ?? (information?.principalClass ?? NSStringFromClass(Application.self))
  guard let instance = NSClassFromString(application) else {
    log.error("unable to find application class \(application)")
    exit(EXIT_FAILURE)
  }
  Application.shared = (instance as! Application.Type).init()

  // Setup the application's information which was loaded.  Because the
  // configuration can indicate the principal class it is loaded prior to the
  // construction of the shared application's construction.  Now that the
  // application has been construted, we can instill the configuration.
  Application.shared.information = information

  // Setup the application's delegate.
  if let delegate = delegate {
    guard let instance = NSClassFromString(delegate) else {
      fatalError("unable to find delegate class: \(delegate)")
    }
    if instance as? Application.Type == nil {
      Application.shared.delegate = (instance as! ApplicationDelegate.Type).init()
    } else {
      Application.shared.delegate = Application.shared as? ApplicationDelegate
    }
  }

  // Initialize COM
  do {
    try CoInitializeEx(COINIT_MULTITHREADED)
  } catch {
    log.error("CoInitializeEx: \(error)")
    return EXIT_FAILURE
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
  if !InitCommonControlsEx(&ICCE) {
    log.error("InitCommonControlsEx: \(Error(win32: GetLastError()))")
  }

  if Application.shared.delegate?
        .application(Application.shared,
                     willFinishLaunchingWithOptions: nil) == false {
    return EXIT_FAILURE
  }

  var pAppRegistration: PAPPSTATE_REGISTRATION?
  let ulStatus =
      RegisterAppStateChangeNotification(pApplicationStateChangeRoutine, nil,
                                         &pAppRegistration)
  if ulStatus != ERROR_SUCCESS {
    log.error("RegisterAppStateChangeNotification: \(Error(win32: GetLastError()))")
  }
  defer { UnregisterAppStateChangeNotification(pAppRegistration) }

  if Application.shared.delegate?
        .application(Application.shared,
                     didFinishLaunchingWithOptions: nil) == false {
    return EXIT_FAILURE
  }

  // Post ApplicationDelegate.didFinishLaunchingNotification
  NotificationCenter.default
      .post(name: Delegate.didFinishLaunchingNotification,
            object: nil, userInfo: nil)

  Application.shared.delegate?
      .applicationDidBecomeActive(Application.shared)

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
  let SceneType =
      (session.configuration.sceneClass as? Scene.Type) ?? WindowScene.self

  let (_, scene) =
      Application.shared.connectedScenes
          .insert(SceneType.init(session: session, connectionOptions: options))

  if let DelegateType =
      session.configuration.delegateClass as? SceneDelegate.Type {
    // Only instantiate the scene delegate if the scene delegate is not the
    // Application class or the ApplicationDelegate class.
    if DelegateType as? Application.Type == nil {
      if DelegateType as? ApplicationDelegate.Type == nil {
        scene.delegate = DelegateType.init()
      } else {
        scene.delegate = Application.shared.delegate as? SceneDelegate
      }
    } else {
      scene.delegate = Application.shared as? SceneDelegate
    }
  }

  scene.delegate?.scene(scene, willConnectTo: session, options: options)
  session.scene = scene

  var msg: MSG = MSG()
  var nExitCode: Int32 = EXIT_SUCCESS

  mainLoop: while true {
    // Process all messages in thread's message queue; for GUI applications UI
    // events must have high priority.
    while PeekMessageW(&msg, nil, 0, 0, UINT(PM_REMOVE)) {
      if msg.message == UINT(WM_QUIT) {
        nExitCode = Int32(msg.wParam)
        break mainLoop
      }

      TranslateMessage(&msg)
      DispatchMessageW(&msg)
    }

    var limitDate: Date? = nil
    repeat {
      // Execute Foundation.RunLoop once and determine the next time the timer
      // fires.  At this point handle all Foundation.RunLoop timers, sources and
      // Dispatch.DispatchQueue.main tasks
      limitDate = RunLoop.main.limitDate(forMode: .default)

      // If Foundation.RunLoop doesn't contain any timers or the timers should
      // not be running right now, we interrupt the current loop or otherwise
      // continue to the next iteration.
    } while (limitDate?.timeIntervalSinceNow ?? -1) <= 0

    // Yield control to other threads.  If Foundation.RunLoop contains a timer
    // to execute, we wait until a new message is placed in the thread's message
    // queue or the timer must fire, otherwise we proceed to the next iteration
    // of mainLoop, using 0 as the wait timeout.
    _ = WaitMessage(UINT(exactly: limitDate?.timeIntervalSinceNow ?? 0 * 1000)
                        ?? UINT.max)
  }

  Application.shared.delegate?.applicationWillTerminate(Application.shared)

  return nExitCode
}

extension ApplicationDelegate {
  public static func main() {
    ApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil,
                    String(describing: String(reflecting: Self.self)))
  }
}
