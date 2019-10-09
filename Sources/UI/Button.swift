
import WinSDK

public protocol ButtonDelegate: class {
  func OnLeftButtonPressed(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnRightButtonPressed(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
}

public extension ButtonDelegate {
  func OnLeftButtonPressed(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return 1
  }

  func OnRightButtonPressed(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return 1
  }
}

internal let SwiftButtonProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let button: Button? = unsafeBitCast(dwRefData, to: AnyObject.self) as? Button
  switch uMsg {
  case UINT(WM_LBUTTONDOWN):
    if button?.delegate?.OnLeftButtonPressed(hWnd, wParam, lParam) == 0 {
      return 0
    }
    break
  case UINT(WM_RBUTTONDOWN):
    if button?.delegate?.OnRightButtonPressed(hWnd, wParam, lParam) == 0 {
      return 0
    }
    break
  default:
    break
  }
  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

public class Button: View {
  public static let `class`: WindowClass = WindowClass(named: "BUTTON")

  public weak var delegate: ButtonDelegate?

  public override init(frame: Rect = .default, `class`: WindowClass = Button.class,
                       style: DWORD = DWORD(WS_TABSTOP | WS_VISIBLE | BS_PUSHBUTTON)) {
    super.init(frame: frame, class: `class`, style: style)
    SetWindowSubclass(hWnd, SwiftButtonProc, UINT_PTR(1),
                      unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
  }

  public convenience init(frame: Rect = .zero, `class`: WindowClass = Button.class,
                          style: DWORD = DWORD(WS_TABSTOP | WS_VISIBLE | BS_PUSHBUTTON),
                          title: String) {
    self.init(frame: frame, class: `class`, style: style)
    SetWindowTextW(hWnd, title.LPCWSTR)
  }
}
