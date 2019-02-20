
import WinSDK

public protocol WindowDelegate: class {
  func OnDestroy(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnPaint(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
}

public extension WindowDelegate {
  func OnDestroy(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    PostQuitMessage(0)
    return 0
  }

  func OnPaint(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return DefWindowProcW(hWnd, UINT(WM_PAINT), wParam, lParam)
  }
}

