
import WinSDK
import SwiftWin32

class SwiftApplicationDelegate: ApplicationDelegate {
  var window: Window?
  var btn: Button?
  var label: Label?
  
  func application(_: Application,
                   didFinishLaunchingWithOptions options: [Application.LaunchOptionsKey:Any]?) -> Bool {

    class SwiftWindowDelegate: ViewDelegate {
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

    self.window = Window(title: "Swift Window")
    self.btn = Button(frame: Rect(x: 100, y: 100, width: 100, height: 100))
    self.label = Label(frame: Rect(x: 0, y: 0, width: 100, height: 100))

    self.window?.addSubview(self.btn!)
    self.window?.addSubview(self.label!)
    
    self.window?.delegate = SwiftWindowDelegate()
    
    self.window?.show()
    self.btn?.show()
    self.label?.show()
    
    return true
  }
}


ApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil,
                SwiftApplicationDelegate())

