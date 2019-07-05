
import WinSDK

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
  
  public private(set) static var defaultWindowClass: WindowClass =
    WindowClass(hInst: GetModuleHandleW(nil), name: "UI.Label")
  
  override public init(frame: Rect = .default,
                       `class`: WindowClass = defaultWindowClass,
                       style: Int32 = WS_TABSTOP | WS_VISIBLE) {
    super.init(frame: frame, class: `class`, style: style)
  }
}
