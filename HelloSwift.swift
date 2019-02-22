
import WinSDK
import SwiftWin32

class SwiftApplicationDelegate: ApplicationDelegate {
  var window: Window?

  func application(_: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?) -> Bool {
    let SwiftWindowClass: WindowClass =
    WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.Window")
    _ = SwiftWindowClass.register()

    class SwiftWindowDelegate: WindowDelegate {
      func OnDestroy(_: HWND, _: WPARAM, _: LPARAM) -> LRESULT {
        exit(EXIT_SUCCESS)
      }
    }

    self.window = Window(class: SwiftWindowClass, title: "Swift Window")
    self.window?.delegate = SwiftWindowDelegate()
    self.window?.show()

    return true
  }
}


_ = ApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil,
                    SwiftApplicationDelegate())

