
import WinSDK

let WS_OVERLAPPEDWINDOW: UINT =
    UINT(WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX)

public protocol WindowDelegate: class {
  func OnDestroy(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnPaint(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
}

extension WindowDelegate {
  func OnDestroy(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    PostQuitMessage(0)
    return 0
  }

  func OnPaint(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return DefWindowProcW(hWnd, UINT(WM_PAINT), wParam, lParam)
  }
}

public struct Window {
  public var delegate: WindowDelegate? {
    willSet(value) {
      if let value = value {
        SetWindowLongPtrW(self.hWnd, GWLP_USERDATA, unsafeBitCast(value, to: LONG_PTR.self))
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
      self.hWnd =
          CreateWindowExW(0, self.class.wszClassName.baseAddress, $0,
                          WS_OVERLAPPEDWINDOW, /*CW_USEDEFAULT*/-1, /*CW_USEDEFAULT*/-1,
                          640, 480, hWndParent, nil, hInstance, nil)
    }

    let WndProc: @convention(c) (HWND, UINT, WPARAM, LPARAM) -> LRESULT = {
      var delegate: WindowDelegate?

      let pointer = GetWindowLongPtrW($0, GWLP_USERDATA)
      if pointer != 0 {
        delegate = unsafeBitCast(pointer, to: WindowDelegate.self)
      }

      if let delegate = delegate {
        switch $1 {
        case UINT(WM_DESTROY):
          return delegate.OnDestroy($0, $2, $3)
        default:
          return DefWindowProcW($0, $1, $2, $3)
        }
      } else {
        return DefWindowProcW($0, $1, $2, $3)
      }
    }

    SetWindowLongPtrW(hWnd, GWLP_WNDPROC, unsafeBitCast(WndProc, to: LONG_PTR.self))
  }

  public func show() {
    ShowWindow(self.hWnd, SW_SHOW)
  }

  public func _runMessageLoop() {
    var msgMessage: MSG = MSG()
    while GetMessageW(&msgMessage, self.hWnd, 0, 0) != FALSE {
      TranslateMessage(&msgMessage)
      DispatchMessageW(&msgMessage)
    }
  }
}

