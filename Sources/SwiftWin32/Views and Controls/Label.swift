// Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

private let SwiftLabelProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let label: Label? = unsafeBitCast(dwRefData, to: AnyObject.self) as? Label

  switch uMsg {
  case UINT(WM_LBUTTONUP):
    label?.sendActions(for: .primaryActionTriggered)
  default:
    break
  }

  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

public class Label: Control {
  private static let `class`: WindowClass =
      WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.Label")
  private static let style: WindowStyle = (base: WS_TABSTOP, extended: 0)

  private var hWnd_: HWND?

  public var text: String? {
    get {
      let szLength: Int32 = GetWindowTextLengthW(self.hWnd_)
      guard szLength > 0 else { return nil }

      let buffer: [WCHAR] = Array<WCHAR>(unsafeUninitializedCapacity: Int(szLength) + 1) {
        $1 = Int(GetWindowTextW(self.hWnd_, $0.baseAddress!, CInt($0.count))) + 1
      }
      return String(decodingCString: buffer, as: UTF16.self)
    }
    set(value) {
      _ = SetWindowTextW(self.hWnd_, value?.wide)
    }
  }

  public override var font: Font! {
    didSet {
      SendMessageW(self.hWnd_, UINT(WM_SETFONT),
                   unsafeBitCast(self.font?.hFont.value, to: WPARAM.self),
                   LPARAM(1))
    }
  }

  public var textAlignment: TextAlignment {
    get {
      switch GWL_STYLE & SS_TYPEMASK {
      case SS_CENTER:
        return .center
      case SS_RIGHT:
        return .right
      case SS_LEFTNOWORDWRAP, SS_LEFT:
        return .left
      default:
        fatalError("unknown alignment for WC_STATIC")
      }
    }

    set {
      var lAlignment = GWL_STYLE & ~SS_TYPEMASK
      switch newValue {
      case .left: lAlignment |= SS_LEFTNOWORDWRAP
      case .right: lAlignment |= SS_RIGHT
      case .center: lAlignment |= SS_CENTER
      case .justified, .natural:
        log.error("TextAlignment.\(newValue) is not supported")
      }
      GWL_STYLE = lAlignment
      if !SetWindowPos(self.hWnd_, nil, 0, 0, 0, 0,
                       UINT(SWP_NOACTIVATE | SWP_NOCOPYBITS | SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_DRAWFRAME)) {
        log.warning("SetWindowPos: \(Error(win32: GetLastError()))")
      }
    }
  }

  public override var frame: Rect {
    didSet {
      let frame = self.frame.scaled(for: GetDpiForWindow(self.hWnd),
                                    style: Label.style)
      _ = SetWindowPos(self.hWnd_, nil,
                       0, 0, CInt(frame.size.width), CInt(frame.size.height),
                       UINT(SWP_NOZORDER | SWP_FRAMECHANGED))
    }
  }

  public init(frame: Rect) {
    super.init(frame: frame, class: Label.class, style: Label.style)
    _ = SetWindowSubclass(hWnd, SwiftLabelProc, UINT_PTR(1),
                         unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))

    let size = self.frame.scaled(for: GetDpiForWindow(self.hWnd),
                                 style: Label.style).size
    self.hWnd_ = CreateWindowExW(0, WC_STATIC.wide, nil, DWORD(WS_CHILD),
                                 0, 0, CInt(size.width), CInt(size.height),
                                 self.hWnd, nil, GetModuleHandleW(nil), nil)!
    // Perform the font setting in `defer` which ensures that the property
    // observer is triggered.
    defer { self.font = Font.systemFont(ofSize: Font.systemFontSize) }

    self.isUserInteractionEnabled = false
  }

  // MARK -

  deinit {
    _ = DestroyWindow(self.hWnd_)
  }

  // MARK - View Overrides

  override public func sizeThatFits(_ size: Size) -> Size {
    let hDC: DeviceContextHandle =
        DeviceContextHandle(owning: GetDC(self.hWnd_))
    _ = SelectObject(hDC.value, self.font.hFont.value)

    return withExtendedLifetime(hDC) {
      var sz: SIZE = SIZE()
      if !GetTextExtentPoint32W(hDC.value, self.text?.wide ?? nil,
                                CInt(self.text?.wide.count ?? 1) - 1, &sz) {
        log.warning("GetTextExtentPoint32W: \(Error(win32: GetLastError()))")
        return size
      }
      // TODO(compnerd) handle padding and margins
      return Size(width: sz.cx, height: sz.cy)
    }
  }

  // MARK - Label(ContentSizeCategoryAdjusting)

  public var adjustsFontForContentSizeCategory = false

  // MARK - TraitEnvironment Overrides

  override public func traitCollectionDidChange(_ previousTraitCollection: TraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    guard self.adjustsFontForContentSizeCategory else { return }
    self.font =
        FontMetrics.default.scaledFont(for: self.font,
                                       compatibleWith: traitCollection)
  }
}

extension Label: ContentSizeCategoryAdjusting {
}
