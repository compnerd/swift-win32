
import WinSDK

public protocol WindowDelegate: class {
  func OnCreate(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnPaint(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnCommand(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnDestroy(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnQuit(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
}

public extension WindowDelegate {
  func OnCreate(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return 1
  }

  func OnPaint(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return 1
  }

  func OnDestroy(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return 1
  }

  func OnCommand(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return 1
  }

  func OnQuit(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return 1
  }
}

internal let SwiftWindowProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let window: Window? = unsafeBitCast(dwRefData, to: AnyObject.self) as? Window
  switch uMsg {
  case UINT(WM_CREATE):
    if window?.delegate?.OnCreate(hWnd, wParam, lParam) == 0 {
      return 0
    }
    break
  case UINT(WM_PAINT):
    if window?.delegate?.OnPaint(hWnd, wParam, lParam) == 0 {
      return 0
    }
    break
  case UINT(WM_DESTROY):
    if window?.delegate?.OnDestroy(hWnd, wParam, lParam) == 0 {
      return 0
    }
    break
  case UINT(WM_QUIT):
    if window?.delegate?.OnQuit(hWnd, wParam, lParam) == 0 {
      return 0
    }
    break
  case UINT(WM_COMMAND):
    if window?.delegate?.OnCommand(hWnd, wParam, lParam) == 0 {
      return 0
    }
    break
  default:
    break
  }
  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

public class Window: View {
  public static let `class`: WindowClass =
      WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.Window")

  public weak var delegate: WindowDelegate?

  public override init(frame: Rect, `class`: WindowClass = Window.class,
                       style: DWORD = WS_OVERLAPPEDWINDOW | DWORD(WS_VISIBLE)) {
    super.init(frame: frame, class: `class`, style: style)
    SetWindowSubclass(hWnd, SwiftWindowProc, UINT_PTR(0),
                      unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
  }

  public convenience init(frame: Rect = .zero, `class`: WindowClass = Window.class,
                          style: DWORD = WS_OVERLAPPEDWINDOW | DWORD(WS_VISIBLE),
                          title: String) {
    self.init(frame: frame, class: `class`, style: style)
    SetWindowTextW(hWnd, title.LPCWSTR)
  }
}
