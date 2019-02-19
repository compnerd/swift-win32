
import WinSDK
import SwiftWin32

let SwiftWindowClass: WindowClass =
    WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.Window")
SwiftWindowClass.register()

let window = Window(class: SwiftWindowClass, title: "Swift Window")
window.show()
window._runMessageLoop()

