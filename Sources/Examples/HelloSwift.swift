import WinSDK
import SwiftWin32

class EventHandler: WindowDelegate {
  func OnDestroy(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM)
      -> LRESULT {
    PostQuitMessage(0)
    return 0
  }

  func OnCommand(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM)
      -> LRESULT {
    MessageBoxW(nil, "Swift/Win32 Demo!".LPCWSTR,
                "Swift/Win32 MessageBox!".LPCWSTR, UINT(MB_OK))
    return 0
  }
}

class SwiftApplicationDelegate: ApplicationDelegate {
  lazy var window: Window =
      Window(frame: .default, title: "Swift/Win32 Window")
  lazy var button: Button =
      Button(frame: Rect(x: 64, y: 0, width: 64, height: 32), title: "Press Me!")
  lazy var label: Label =
      Label(frame: Rect(x: 0, y: 0, width: 64, height: 8), title: "Read Me:")
  lazy var delegate = EventHandler()

  func application(_: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?) -> Bool {
    window.addSubview(self.label)
    window.addSubview(self.button)
    window.delegate = delegate
    return true
  }
}

ApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, SwiftApplicationDelegate())
