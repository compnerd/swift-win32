
import WinSDK

public protocol ViewDelegate: class {
  var view: View? { get set }
  
  func OnCreate(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnDestroy(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnPaint(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnQuit(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnLeftButtonDown(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
}

public extension ViewDelegate {
  func OnCreate(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return DefWindowProcW(hWnd, UINT(WM_CREATE), wParam, lParam)
  }

  func OnDestroy(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return DefWindowProcW(hWnd, UINT(WM_DESTROY), wParam, lParam)
  }

  func OnPaint(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return DefWindowProcW(hWnd, UINT(WM_PAINT), wParam, lParam)
  }

  func OnQuit(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return DefWindowProcW(hWnd, UINT(WM_QUIT), wParam, lParam)
  }
  
  func OnLeftButtonDown(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return DefWindowProcW(hWnd, UINT(WM_LBUTTONDOWN), wParam, lParam)
  }
}

open class DefaultDelegate: ViewDelegate {
  public var view: View?

  public init() {
  }

  open func OnCreate(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return DefWindowProcW(hWnd, UINT(WM_CREATE), wParam, lParam)
  }

  open func OnClose(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return DefWindowProcW(hWnd, UINT(WM_CLOSE), wParam, lParam)
  }
  
  open func OnDestroy(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return DefWindowProcW(hWnd, UINT(WM_DESTROY), wParam, lParam)
  }

  open func OnPaint(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return DefWindowProcW(hWnd, UINT(WM_PAINT), wParam, lParam)
  }

  open func OnQuit(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return DefWindowProcW(hWnd, UINT(WM_QUIT), wParam, lParam)
  }

  open func OnLeftButtonDown(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return DefWindowProcW(hWnd, UINT(WM_LBUTTONDOWN), wParam, lParam)
  }
}
