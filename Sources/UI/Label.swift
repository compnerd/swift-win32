
import WinSDK

open class LabelDelegate: DefaultDelegate {
  open override func OnPaint(_ hWnd: HWND, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    if let view = self.view {
      let rc = RenderContext(hWnd)
      let label = view as! Label
      let bg = label.backgroundColor
      let bc = label.borderColor
      let fg = label.textColor

      rc.fillBackground(color: bg)
      rc.drawBorder(thickness: label.borderThickness, color: bc)
      rc.drawText(text: label.text, color: fg)
    }
    return 0
  }
}

public class Label: View {
  public var textColor: Color = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) {
    didSet(value) {
      self.invalidate()
    }
  }
  public var borderColor: Color = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) {
    didSet(value) {
      self.invalidate()
    }
  }
  public var borderThickness: Int32 = 2 {
    didSet(value) {
      self.invalidate()
    }
  }
  public var text: String = "" {
    didSet(value) {
      self.invalidate()
    }
  }

  public private(set) static var `class`: WindowClass =
    WindowClass(hInst: GetModuleHandleW(nil), name: "UI.Label")

  override public init(frame: Rect = .default, `class`: WindowClass = self.class,
                       style: Int32 = WS_TABSTOP | WS_VISIBLE) {
    super.init(frame: frame, class: `class`, style: style)
    self.delegate = LabelDelegate()
  }
}
