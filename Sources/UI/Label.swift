
import WinSDK

public class Label: View {
  public static let `class`: WindowClass = WindowClass(named: "STATIC")

  public override init(frame: Rect, `class`: WindowClass = Label.class,
                       style: DWORD = DWORD(WS_TABSTOP | WS_VISIBLE)) {
    super.init(frame: frame, class: `class`, style: style)
  }
}
