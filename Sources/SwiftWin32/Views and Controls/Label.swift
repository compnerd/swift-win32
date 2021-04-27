/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

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

public class Label: View {
  private static let `class`: WindowClass =
      WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.Label")
  private static let style: WindowStyle = (base: WS_TABSTOP, extended: 0)

  private var hWnd_: HWND?

  public var text: String? {
    get {
      let szLength: Int32 = GetWindowTextLengthW(self.hWnd_)
      let buffer: [WCHAR] = Array<WCHAR>(unsafeUninitializedCapacity: Int(szLength) + 1) {
        $1 = Int(GetWindowTextW(self.hWnd_, $0.baseAddress!, CInt($0.count)))
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

  public override var frame: Rect {
    didSet {
      let size = self.frame.size
      _ = SetWindowPos(self.hWnd_, nil,
                       0, 0, CInt(size.width), CInt(size.height),
                       UINT(SWP_NOZORDER | SWP_FRAMECHANGED))
    }
  }

  public init(frame: Rect) {
    super.init(frame: frame, class: Label.class, style: Label.style)
    _ = SetWindowSubclass(hWnd, SwiftLabelProc, UINT_PTR(1),
                         unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))

    let size = self.frame.size
    self.hWnd_ = CreateWindowExW(0, WC_STATIC.wide, nil, DWORD(WS_CHILD),
                                 0, 0, CInt(size.width), CInt(size.height),
                                 self.hWnd, nil, GetModuleHandleW(nil), nil)!
    // Perform the font setting in `defer` which ensures that the property
    // observer is triggered.
    defer { self.font = Font.systemFont(ofSize: Font.systemFontSize) }
  }

  deinit {
    _ = DestroyWindow(self.hWnd_)
  }

  // ContentSizeCategoryAdjusting
  public var adjustsFontForContentSizeCategory = false

  // TraitEnvironment
  override public func traitCollectionDidChange(_ previousTraitCollection: TraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    guard self.adjustsFontForContentSizeCategory else { return }
    self.font = FontMetrics.default.scaledFont(for: self.font,
                                               compatibleWith: traitCollection)
  }


  // MARK - Control API that should be removed when GestureRecognizer is implemented
  private var actions: [Control.Event:[ControlEventCallable]] =
      Dictionary<Control.Event, [ControlEventCallable]>(minimumCapacity: 16)

  @inline(__always)
  private func addAction(_ callable: ControlEventCallable,
                         for controlEvents: Control.Event) {
    for event in Label.Event.semanticEvents {
      if controlEvents.rawValue & event.rawValue == event.rawValue {
        self.actions[event, default: []].append(callable)
      }
    }
  }

  func sendActions(for controlEvents: Control.Event) {
    for event in Label.Event.semanticEvents {
      if controlEvents.rawValue & event.rawValue == event.rawValue {
        _ = self.actions[event]?.map { $0(sender: self, event: controlEvents) }
      }
    }
  }

  public func addTarget<Target: AnyObject>(_ target: Target,
                                           action: @escaping (Target) -> () -> Void,
                                           for controlEvents: Control.Event) {
    self.addAction(ControlEventCallback<Self, Target>(binding: action, on: target),
                   for: controlEvents)
  }

  /// Associates a target object and action method with the control.
  public func addTarget<Source: Label, Target: AnyObject>(_ target: Target,
                                                            action: @escaping (Target) -> (_: Source) -> Void,
                                                            for controlEvents: Control.Event) {
    self.addAction(ControlEventCallback(binding: action, on: target),
                   for: controlEvents)
  }

  /// Returns the events for which the control has associated actions.
  public private(set) var allControlEvents: Control.Event =
      Control.Event(rawValue: 0)

  /// Associates a target object and action method with the control.
  public func addTarget<Source: Label, Target: AnyObject>(_ target: Target,
                                                            action: @escaping (Target) -> (_: Source, _: Control.Event) -> Void,
                                                            for controlEvents: Control.Event) {
    self.addAction(ControlEventCallback<Source, Target>(binding: action, on: target),
                   for: controlEvents)
  }
}

extension Label: ContentSizeCategoryAdjusting {
}


private protocol ControlEventCallable {
  func callAsFunction(sender: Label, event: Control.Event)
}

private struct ControlEventCallback<Source: Label, Target: AnyObject>: ControlEventCallable {
  private unowned(safe) let instance: Target
  private let method: (Target) -> (_: Source, _: Control.Event) -> Void

  public init(binding: @escaping (Target) -> (_: Source, _: Control.Event) -> Void,
              on: Target) {
    self.instance = on
    self.method = binding
  }

  public init(binding: @escaping (Target) -> (_: Source) -> Void, on: Target) {
    self.instance = on
    self.method = { (target: Target) in { (sender: Source, _: Control.Event) in
        binding(target)(sender)
      }
    }
  }

  public init(binding: @escaping (Target) -> () -> Void, on: Target) {
    self.instance = on
    self.method = { (target: Target) in { (_: Source, _: Control.Event) in
        binding(target)()
      }
    }
  }

  public func callAsFunction(sender: Label, event: Control.Event) {
    self.method(instance)(sender as! Source, event)
  }
}

extension Label.Event {
    /// A semantic action triggered by buttons.
  public static var primaryActionTriggered: Control.Event {
    Control.Event(rawValue: 1 << 13)
  }

  fileprivate static var semanticEvents: [Control.Event] {
    return [
      .primaryActionTriggered
    ]
  }
}
