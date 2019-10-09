import WinSDK
import SwiftWin32

class SwiftApplicationDelegate: ApplicationDelegate {
  lazy var window: Window = Window(title: "Swift/Win32 Window")
  lazy var button: Button = Button(frame: Rect(x: 10, y: 10, width: 0, height: 0),
                                   title: "Press Me!")

  func application(_: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?) -> Bool {
    window.addSubview(self.button)
    window.delegate = self
    return true
  }
}

extension SwiftApplicationDelegate: WindowDelegate {
  func OnDestroy(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    PostQuitMessage(0)
    return 0
  }

  func OnCommand(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    MessageBoxW(nil, "Swift/Win32 Demo!".LPCWSTR,
                "Swift/Win32 MessageBox!".LPCWSTR, UINT(MB_OK))
    return 0
  }
}

ApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, SwiftApplicationDelegate())
