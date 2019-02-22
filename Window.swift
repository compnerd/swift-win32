
import WinSDK


typealias WindowProc = @convention(c) (HWND, UINT, WPARAM, LPARAM) -> LRESULT
let WndProc: WindowProc = { (hWnd, uMsg, wParam, lParam) in
  let pointer = GetWindowLongPtrW(hWnd, GWLP_USERDATA)
  if pointer == 0 { return DefWindowProcW(hWnd, uMsg, wParam, lParam) }

  let delegate: WindowDelegate =
      unsafeBitCast(pointer, to: AnyObject.self) as! WindowDelegate
  switch uMsg {
  case UINT(WM_CREATE):
    return delegate.OnCreate(hWnd, wParam, lParam)
  case UINT(WM_DESTROY):
    return delegate.OnDestroy(hWnd, wParam, lParam)
  case UINT(WM_PAINT):
    return delegate.OnPaint(hWnd, wParam, lParam)
  case UINT(WM_QUIT):
    return delegate.OnQuit(hWnd, wParam, lParam)
  default:
    return DefWindowProcW(hWnd, uMsg, wParam, lParam)
  }
}


public struct Window {
  public var delegate: WindowDelegate? {
    willSet(value) {
      if let value = value {
        SetWindowLongPtrW(self.hWnd, GWLP_USERDATA,
                          unsafeBitCast(value as AnyObject, to: LONG_PTR.self))
      } else {
        SetWindowLongPtrW(self.hWnd, GWLP_USERDATA, 0)
      }
    }
  }

  private var `class`: WindowClass
  private var hWnd: HWND?

  public init(`class`: WindowClass, title: String, hInstance: HINSTANCE? = nil,
              hWndParent: HWND? = nil) {
    self.class = `class`
    title.withCString(encodedAs: UTF16.self) {
      self.hWnd = CreateWindowExW(0, self.class.name.baseAddress, $0,
                                  WS_OVERLAPPEDWINDOW, /*CW_USEDEFAULT*/-1,
                                  /*CW_USEDEFAULT*/-1, 640, 480, hWndParent,
                                  nil, hInstance, nil)
    }

    SetWindowLongPtrW(hWnd, GWLP_WNDPROC,
                      unsafeBitCast(WndProc, to: LONG_PTR.self))
  }

  public func show() {
    ShowWindow(self.hWnd, SW_SHOW)
  }
}

