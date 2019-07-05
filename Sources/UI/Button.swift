
import WinSDK

open class ButtonDelegate: DefaultDelegate {
  open override func OnPaint(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
      if let view = view {
        let rc = RenderContext(hWnd)
        let btn = view as! Button
        let bg = btn.backgroundColor
        let fg = btn.textColor
        rc.fillBackground(color: bg)
        rc.drawText(text: btn.text, color: fg)
    }
    return 0
  }
}

public class Button: View {
  public var textColor: Color = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
  public var text: String = "" {
    didSet(value) {
      self.invalidate()
    }
  }
  
  public private(set) static var defaultWindowClass: WindowClass =
    WindowClass(hInst: GetModuleHandleW(nil), name: "UI.Button")
  
  override public init(frame: Rect = .default,
                       `class`: WindowClass = defaultWindowClass,
                       style: Int32 = WS_TABSTOP | WS_VISIBLE) {
    super.init(frame: frame, class: `class`, style: style)
    self.delegate = ButtonDelegate()
  }
}
