
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
      func OnClose(hWnd: HWND, _: WPARAM, _: LPARAM) -> LRESULT {
        DestroyWindow(hWnd)
        return 0
      }

      func OnDestroy(_: HWND, _: WPARAM, _: LPARAM) -> LRESULT {
        PostQuitMessage(0)
        return 0
      }

      func OnPaint(_ hWnd: HWND, _: WPARAM, _: LPARAM) -> LRESULT {
        let red: Color = #colorLiteral(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)

        var rctRect: RECT = RECT()

        GetClientRect(hWnd, &rctRect)

        var psPaint: PAINTSTRUCT = PAINTSTRUCT()
        let hDC: HDC = BeginPaint(hWnd, &psPaint)
          SelectObject(hDC, GetStockObject(NULL_PEN))
          SelectObject(hDC, GetStockObject(DC_BRUSH))
          SetDCBrushColor(hDC, red.COLORREF)
          Rectangle(hDC, rctRect.left, rctRect.top, rctRect.right, rctRect.bottom)
        EndPaint(hWnd, &psPaint)

        return 0
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

