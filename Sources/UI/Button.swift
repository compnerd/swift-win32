
import WinSDK

open class ButtonDelegate: DefaultDelegate {
  open override func OnPaint(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM)
      -> LRESULT {
    if let button = view as? Button else {
      let context = RenderContext(hWnd)
      context.fillBackground(color: button.backgroundColor)
      context.drawText(text: button.text, color: button.textColor)
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

  public private(set) static var `class`: WindowClass =
    WindowClass(hInst: GetModuleHandleW(nil), name: "UI.Button")

  override public init(frame: Rect = .default, `class`: WindowClass = .class,
                       style: Int32 = WS_TABSTOP | WS_VISIBLE | BS_PUSHBUTTON) {
    super.init(frame: frame, class: `class`, style: style)
    self.delegate = ButtonDelegate()
  }
}
