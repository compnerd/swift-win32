// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

import struct Foundation.IndexPath
import class Foundation.NSAttributedString

// Notification Proxy

// When the Window is created, the initial parent is cached.  This cache cannot
// be updated.  Instead, we always parent any picker view control to the
// `Swift.PickerView.Proxy` which is process-wide.  All notifications
// about the control events will be dispatched by the proxy.

private let SwiftPickerViewProxyWindowProc: WNDPROC = { (hWnd, uMsg, wParam, lParam) in
  switch uMsg {
  case UINT(WM_DRAWITEM):
    let lpDrawItem: UnsafeMutablePointer<DRAWITEMSTRUCT> =
        UnsafeMutablePointer<DRAWITEMSTRUCT>(bitPattern: UInt(lParam))!

    // No selected item.
    if Int32(bitPattern: UInt32(lpDrawItem.pointee.itemID)) == -1 { break }

    switch lpDrawItem.pointee.itemAction {
    case UINT(ODA_SELECT):
      _ = DrawFocusRect(lpDrawItem.pointee.hDC, &lpDrawItem.pointee.rcItem)
      if lpDrawItem.pointee.itemState & DWORD(ODS_SELECTED) == DWORD(ODS_SELECTED) {
        // If the item is selected, we have drawn the focus rectangle and the
        // operation is complete.
        return LRESULT(1)
      }

    case UINT(ODA_FOCUS):
      break

    case UINT(ODA_DRAWENTIRE):
      if let view = unsafeBitCast(lpDrawItem.pointee.itemData,
                                  to: AnyObject.self) as? View {
        let rctRect: RECT = lpDrawItem.pointee.rcItem
        _ = SetWindowPos(view.hWnd, nil, rctRect.left, rctRect.top, 0, 0,
                         UINT(SWP_NOSIZE))
        // Setting `isHidden` is necessary for Views generated after initial
        // call to `Window.makeKeyAndVisible()`
        if IsWindowVisible(GetParent(view.hWnd)) && !IsWindowVisible(view.hWnd) {
          view.isHidden = false
        }
        return DefWindowProcW(view.hWnd, UINT(WM_PAINT), 0, 0)
      }

    default:
      fatalError("unhandled message: \(lpDrawItem.pointee.itemAction)")
    }

  case UINT(WM_DELETEITEM):
    let lpDeleteItem: UnsafeMutablePointer<DELETEITEMSTRUCT> =
        UnsafeMutablePointer<DELETEITEMSTRUCT>(bitPattern: UInt(lParam))!

    if let view = unsafeBitCast(lpDeleteItem.pointee.itemData,
                                to: AnyObject.self) as? View {
      view.removeFromSuperview()
    }

    return LRESULT(1)

  case UINT(WM_COMMAND):
    if HIWORD(wParam) == CBN_SELENDOK {
      let hWnd: HWND = HWND(bitPattern: UInt(lParam))!

      // Query the ComboxBox info, which provides the hWnd for the ListView
      // which serves as the rightful parent for the view.
      // FIXME(compnerd) should we cache the value?  It is unlikely to change.
      var cbiInfo: COMBOBOXINFO = COMBOBOXINFO()
      cbiInfo.cbSize = DWORD(MemoryLayout<COMBOBOXINFO>.size)
      _ = withUnsafeMutablePointer(to: &cbiInfo) {
        SendMessageW(hWnd, UINT(CB_GETCOMBOBOXINFO), 0,
                    LPARAM(Int(bitPattern: $0)))
      }

      _ = SendMessageW(cbiInfo.hwndItem, UINT(LB_SETCURSEL), 0, 0)
    }
    break

  default: break
  }

  return DefWindowProcW(hWnd, uMsg, wParam, lParam)
}

private let SwiftPickerViewWindowProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  switch uMsg {
  case UINT(WM_PAINT):
    guard let pickerView = unsafeBitCast(dwRefData, to: AnyObject.self) as? PickerView else {
      break
    }

    let lSelection = SendMessageW(hWnd, UINT(CB_GETCURSEL), 0, 0)
    guard lSelection >= 0 else { break }

    let lItemData = SendMessageW(pickerView.hWnd, UINT(CB_GETITEMDATA),
                                 WPARAM(lSelection), 0)
    guard let view = unsafeBitCast(UInt(lItemData), to: AnyObject.self) as? View else {
      break
    }

    var cbiInfo: COMBOBOXINFO = COMBOBOXINFO()
    cbiInfo.cbSize = DWORD(MemoryLayout<COMBOBOXINFO>.size)
    _ = withUnsafeMutablePointer(to: &cbiInfo) {
      SendMessageW(pickerView.hWnd, UINT(CB_GETCOMBOBOXINFO), 0,
                  LPARAM(Int(bitPattern: $0)))
    }

    var rcClient: RECT = RECT()
    _ = GetClientRect(view.hWnd, &rcClient)

    let hDCItem: DeviceContextHandle =
        DeviceContextHandle(owning: GetDC(view.hWnd))
    let hBitmap: BitmapHandle =
        BitmapHandle(owning: CreateCompatibleBitmap(hDCItem.value,
                                                    rcClient.right - rcClient.left,
                                                    rcClient.bottom - rcClient.top))

    let hDCMemory: DeviceContextHandle =
        DeviceContextHandle(owning: CreateCompatibleDC(nil))
    _ = SelectObject(hDCMemory.value, hBitmap.value)

    _ = SendMessageW(view.hWnd, UINT(WM_PRINT),
                     WPARAM(UInt(bitPattern: hDCMemory.value)),
                     LPARAM(PRF_CHILDREN | PRF_CLIENT | PRF_ERASEBKGND | PRF_OWNED))

    let lResult = DefSubclassProc(hWnd, uMsg, wParam, lParam)

    let hDC: DeviceContextHandle =
        DeviceContextHandle(owning: GetDC(hWnd))

    _ = BitBlt(hDC.value, cbiInfo.rcItem.left, cbiInfo.rcItem.top,
               cbiInfo.rcItem.right - cbiInfo.rcItem.left,
               cbiInfo.rcItem.bottom - cbiInfo.rcItem.top, hDCMemory.value,
               0, 0, UINT(SRCCOPY))

    return lResult

  default: break
  }
  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

private class PickerViewProxy {
  private static let `class`: WindowClass =
      WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.PickerView.Proxy",
                  WindowProc: SwiftPickerViewProxyWindowProc)

  fileprivate var hWnd: HWND!

  fileprivate init() {
    _ = PickerViewProxy.class.register()
    self.hWnd =
        CreateWindowExW(0, PickerViewProxy.class.name, nil, 0, 0, 0, 0, 0,
                        HWND_MESSAGE, nil, GetModuleHandleW(nil), nil)!
  }

  deinit {
    _ = DestroyWindow(self.hWnd)
    _ = PickerViewProxy.class.unregister()
  }
}


/// Mediates between a `PickerView` object and your application's data model for
/// that picker view.
public protocol PickerViewDataSource: AnyObject {
  // MARK - Providing Counts for the Picker View

  /// Called by the picker view when it needs the number of components.
  func numberOfComponents(in pickerView: PickerView) -> Int

  /// Called by the picker view when it needs the number of rows for a specified
  /// component.
  func pickerView(_ pickerView: PickerView,
                  numberOfRowsInComponent component: Int) -> Int
}

/// The delegate of a `PickerView` object must adopt this protocol and implement
/// at least some of its methods to provide the picker view with the data it
/// needs to construct itself.
public protocol PickerViewDelegate: AnyObject {
  // MARK - Setting the Dimensions of the Picker View

  /// Called by the picker view when it needs the row height to use for drawing
  /// row content.
  func pickerView(_ pickerView: PickerView,
                  rowHeightForComponent component: Int) -> Double

  /// Called by the picker view when it needs the row width to use for drawing
  /// row content.
  func pickerView(_ pickerView: PickerView,
                  widthForComponent component: Int) -> Double

  // MARK - Setting the Content of Component Rows

  /// Called by the picker view when it needs the title to use for a given row
  /// in a given component.
  func pickerView(_ pickerView: PickerView, titleForRow row: Int,
                  forComponent component: Int) -> String?

  /// Called by the picker view when it needs the styled title to use for a
  /// given row in a given component.
  func pickerView(_ pickerView: PickerView, attributedTitleForRow row: Int,
                  forComponent component: Int) -> NSAttributedString?

  /// Called by the picker view when it needs the view to use for a given row in
  /// a given component.
  func pickerView(_ pickerView: PickerView, viewForRow row: Int,
                  forComponent component: Int, reusing view: View?) -> View

  // MARK - Responding to Row Selection

  /// Called by the picker view when the user selects a row in a component.
  func pickerView(_ pickerView: PickerView, didSelectRow row: Int,
                  inComponent component: Int)
}

extension PickerViewDelegate {
  public func pickerView(_ pickerView: PickerView,
                         rowHeightForComponent component: Int) -> Double {
    return 0.0
  }

  public func pickerView(_ pickerView: PickerView,
                         widthForComponent component: Int) -> Double {
    return 0.0
  }
}

fileprivate let kUnimplementedSentinel: View = View(frame: .zero)

extension PickerViewDelegate {
  public func pickerView(_ pickerView: PickerView, titleForRow row: Int,
                         forComponent component: Int) -> String? {
    return pickerView.delegate?.pickerView(pickerView,
                                           attributedTitleForRow: row,
                                           forComponent: component)?.string
  }

  public func pickerView(_ pickerView: PickerView,
                         attributedTitleForRow row: Int,
                         forComponent component: Int) -> NSAttributedString? {
    // FIXME(compnerd) what is the proper default value?
    return nil
  }

  public func pickerView(_ pickerView: PickerView, viewForRow row: Int,
                         forComponent component: Int, reusing view: View?)
      -> View {
    return kUnimplementedSentinel
  }
}

extension PickerViewDelegate {
  public func pickerView(_ pickerView: PickerView, didSelectRow row: Int,
                         inComponent component: Int) {
  }
}

/// A view that shows one or more sets of values.
public class PickerView: View {
  private static let `class`: WindowClass = WindowClass(named: WC_COMBOBOX)
  // FIXME(compnerd) `CBS_OWNERDRAWVARIABLE` is ideal, but we do not get the
  // proper callbacks for the rendering of the items.
  private static let style: WindowStyle =
      (base: WS_BORDER | WS_HSCROLL | WS_POPUP | WS_TABSTOP | WS_VSCROLL | DWORD(CBS_DROPDOWNLIST | CBS_OWNERDRAWFIXED),
       extended: 0)

  private static let proxy: PickerViewProxy = PickerViewProxy()

  // MARK -

  public init(frame: Rect = .zero) {
    super.init(frame: frame, class: PickerView.class, style: PickerView.style,
               parent: PickerView.proxy.hWnd)

    _ = SendMessageW(self.hWnd, UINT(CB_SETITEMHEIGHT),
                     WPARAM(UInt(bitPattern: -1)), LPARAM(UInt(frame.height)))

    var cbiInfo: COMBOBOXINFO = COMBOBOXINFO()
    cbiInfo.cbSize = DWORD(MemoryLayout<COMBOBOXINFO>.size)
    _ = withUnsafeMutablePointer(to: &cbiInfo) {
      SendMessageW(self.hWnd, UINT(CB_GETCOMBOBOXINFO), 0,
                   LPARAM(UInt(bitPattern: $0)))
    }
    _ = SetWindowSubclass(cbiInfo.hwndItem, SwiftPickerViewWindowProc,
                          UINT_PTR(4),
                          unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
  }

  // MARK - Providing the Picker Data

  /// The data source for the picker view.
  public weak var dataSource: PickerViewDataSource?

  // MARK - Customing the Picker Behaviour

  /// The delegate for the picker view.
  public weak var delegate: PickerViewDelegate?

  // MARK - Getting the Dimensions of the View Picker

  /// Gets the number of components for the picker view.
  public var numberOfComponents: Int {
    // TODO(compnerd) cache the value from the dataSource
    self.dataSource?.numberOfComponents(in: self) ?? 0
  }

  /// Returns the number of rows for a component.
  public func numberOfRows(inComponent component: Int) -> Int {
    // TODO(compnerd) cache the value from the dataSource
    self.dataSource?.pickerView(self, numberOfRowsInComponent: component) ?? 0
  }

  /// Returns the size of a row for a component.
  public func rowSize(forComponent component: Int) -> Size {
    guard let delegate = self.delegate else { return Size(width: 0, height: 0) }
    // TODO(compnerd) cache the value from the dataSource
    return Size(width: delegate.pickerView(self, widthForComponent: component),
                height: delegate.pickerView(self, rowHeightForComponent: component))
  }

  // MARK - Reloading the View Picker

  /// Reloads all components of the picker view.
  public func reloadAllComponents() {
    for component in (0 ..< self.numberOfComponents) {
      self.reloadComponent(component)
    }
  }

  private var viewCache: [IndexPath:View] = [:]

  /// Reloads a particular component of the picker view.
  public func reloadComponent(_ component: Int) {
    assert(component == 0, "multi-component PickerView not yet implemented")

    // Clear any existing items in the picker view.  We may have content from a
    // previous load.
    _ = SendMessageW(self.hWnd, UINT(CB_RESETCONTENT), 0, 0)

    // Query the ComboxBox info, which provides the hWnd for the ListView which
    // serves as the rightful parent for the view.
    // FIXME(compnerd) should we cache the value?  It is unlikely to change.
    var cbiInfo: COMBOBOXINFO = COMBOBOXINFO()
    cbiInfo.cbSize = DWORD(MemoryLayout<COMBOBOXINFO>.size)
    _ = withUnsafeMutablePointer(to: &cbiInfo) {
      SendMessageW(self.hWnd, UINT(CB_GETCOMBOBOXINFO), 0,
                   LPARAM(Int(bitPattern: $0)))
    }

    // We have a restriction on the row count at 32,768.  We may overflow, but
    // this seems unlikely as the UX at that point would make this less than
    // ideal for usage.
    let cbRows: Int = self.numberOfRows(inComponent: component)

    // Initialize the storage for the picker view.  This avoids allocations on
    // each entry being added.  We should ideally have an `underestimatedCount`
    // in use here, so as to avoid over-allocation of memory.
    _ = SendMessageW(self.hWnd, UINT(CB_INITSTORAGE), WPARAM(cbRows),
                     LPARAM(MemoryLayout<Int>.size))

    // Suspend redraws while repopulating the view.
    _ = SendMessageW(self.hWnd, UINT(WM_SETREDRAW), 0, 0)

    for row in 0 ..< cbRows {
      if let view = self.view(forRow: row, forComponent: component,
                              reusing: self.viewCache[[component, row]]) {
        self.viewCache[[component, row]] = view

        _ = SendMessageW(self.hWnd, UINT(CB_INSERTSTRING),
                         WPARAM(bitPattern: -1),
                         unsafeBitCast(view as AnyObject, to: LPARAM.self))
        _ = SendMessageW(self.hWnd, UINT(CB_SETITEMHEIGHT),
                         WPARAM(0), LPARAM(view.frame.size.height))

        // Reparent the view.
        _ = SetParent(view.hWnd, cbiInfo.hwndList)

        view.GWL_STYLE &= ~LONG(bitPattern: WS_POPUP | WS_CAPTION)
        view.GWL_STYLE |= WS_CHILD
        // FIXME(compnerd) can this be avoided somehow?
        if view is TextField || view is TextView || view is TableView {
          view.GWL_STYLE |= WinSDK.WS_BORDER
          view.GWL_EXSTYLE &= ~WS_EX_CLIENTEDGE
        }

        _ = SetWindowPos(view.hWnd, nil, 0, 0, 0, 0,
                         UINT(SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_FRAMECHANGED))
      }
    }

    // Resume redraws.
    _ = SendMessageW(self.hWnd, UINT(WM_SETREDRAW), 1, 0)
  }

  // MARK - Selecting Rows in the View Picker

  /// Selects a row ina  specified component of the picker view.
  public func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
    assert(component == 0, "multi-component PickerView not yet implemented")

    assert(!animated, "not yet implemented")
    _ = SendMessageW(self.hWnd, UINT(CB_SETCURSEL), WPARAM(row), 0)
    self.delegate?.pickerView(self, didSelectRow: row, inComponent: component)
  }

  /// Returns the index of the selected row in a given component.
  public func selectedRow(inComponent component: Int) -> Int {
    assert(component == 0, "multi-component PickerView not yet implemented")

    let lResult: LRESULT = SendMessageW(self.hWnd, UINT(CB_GETCURSEL), 0, 0)
    if lResult == CB_ERR { return -1 }
    return Int(lResult)
  }

  // MARK - Returning the View for a Row and Component

  /// Returns the view used by the picker view for a given row and component.
  public func view(forRow row: Int, forComponent component: Int,
                   reusing view: View?) -> View? {
    assert(component == 0, "multi-component PickerView not yet implemented")

    var view: View? =
        self.delegate?.pickerView(self, viewForRow: row, forComponent: component,
                                  reusing: self.viewCache[[component, row]])
    if view === kUnimplementedSentinel {
      let label = Label(frame: .zero)
      label.text = self.delegate?.pickerView(self, titleForRow: row,
                                             forComponent: component)
      // TODO(compnerd) what is the right default size for the view?
      label.frame.size = self.rowSize(forComponent: component)
      if label.frame.size == .zero {
        label.frame.size = label.sizeThatFits(label.frame.size)
        label.frame.size.width = self.frame.size.width
      }
      view = label
    }
    self.viewCache[[component, row]] = view
    return view
  }
}
