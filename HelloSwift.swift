
import WinSDK
import SwiftWin32

let SwiftWindowClass: WindowClass =
    WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.Window")
_ = SwiftWindowClass.register()

class SwiftWindowDelegate: WindowDelegate {
  func OnDestroy(_: HWND, _: WPARAM, _: LPARAM) -> LRESULT {
    exit(EXIT_SUCCESS)
  }
}

var window = Window(class: SwiftWindowClass, title: "Swift Window")
window.delegate = SwiftWindowDelegate()
window.show()
window._runMessageLoop()

