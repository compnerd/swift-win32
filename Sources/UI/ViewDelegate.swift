
import WinSDK

public protocol ViewDelegate: class {
  func OnCreate(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnDestroy(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnPaint(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnQuit(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
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
}

