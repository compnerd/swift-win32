/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK
import struct Foundation.IndexPath

// Notification Proxy

// When the Window is created, the initial parent is cached.  This cache cannot
// be updated.  Instead, we always parent any table view control to the
// `Swift.TableView.Proxy` which is process-wide.  All notifications
// about the control events will be dispatched by the proxy.

private let SwiftTableViewProxyWindowProc: WNDPROC = { (hWnd, uMsg, wParam, lParam) in
  switch uMsg {
  case UINT(WM_DRAWITEM):
    let lpDrawItem: UnsafeMutablePointer<DRAWITEMSTRUCT> =
        UnsafeMutablePointer<DRAWITEMSTRUCT>(bitPattern: UInt(lParam))!

    switch lpDrawItem.pointee.itemAction {
    case UINT(ODA_SELECT):
      // TODO(compnerd) figure out how to render the selection
      fallthrough
    case UINT(ODA_DRAWENTIRE):
      if let view = unsafeBitCast(lpDrawItem.pointee.itemData,
                                  to: AnyObject.self) as? View {
        let rctRect: RECT = lpDrawItem.pointee.rcItem
        _ = SetWindowPos(view.hWnd, nil, rctRect.left, rctRect.top, 0, 0,
                         UINT(SWP_NOSIZE))
        return DefWindowProcW(view.hWnd, UINT(WM_PAINT), 0, 0)
      }

      break
    case UINT(ODA_FOCUS):
      // TODO(compnerd) figure out how to deal with focus
      return LRESULT(1)
    default:
      fatalError("unhandled message: \(lpDrawItem.pointee.itemAction)")
    }

  case UINT(WM_MEASUREITEM):
    let lpMeasurement: UnsafeMutablePointer<MEASUREITEMSTRUCT> =
        UnsafeMutablePointer<MEASUREITEMSTRUCT>(bitPattern: UInt(lParam))!

    if let view = unsafeBitCast(lpMeasurement.pointee.itemData,
                                to: AnyObject.self) as? View {
      lpMeasurement.pointee.itemHeight = UINT(view.frame.size.height)
      lpMeasurement.pointee.itemWidth = UINT(view.frame.size.width)
    }

    return LRESULT(1)
  default: break
  }

  return DefWindowProcW(hWnd, uMsg, wParam, lParam)
}

private class TableViewProxy {
  private static let `class`: WindowClass =
      WindowClass(hInst: GetModuleHandleW(nil), name: "Swift.TableView.Proxy",
                  WindowProc: SwiftTableViewProxyWindowProc)

  fileprivate var hWnd: HWND!

  fileprivate init() {
    _ = TableViewProxy.class.register()
    self.hWnd = CreateWindowExW(0, TableViewProxy.class.name, nil, 0, 0, 0, 0, 0,
                                HWND_MESSAGE, nil, GetModuleHandleW(nil), nil)!
  }

  deinit {
    _ = DestroyWindow(self.hWnd)
    _ = TableViewProxy.class.unregister()
  }
}


extension TableView {
  public enum Style: Int {
  /// A plain table view.
  case plain
  /// A table view where sections have distinct groups of rows.
  case group
  /// A table view where the grouped sections are inset with rounded corners.
  case insetGrouped
  }
}


/// A view that presents data using rows arranged in a single column.
public class TableView: View {
  private static let `class`: WindowClass = WindowClass(named: WC_LISTBOX)
  private static let style: WindowStyle =
      (base: DWORD(WS_BORDER | WS_HSCROLL) | WS_POPUP | DWORD(WS_TABSTOP | WS_VSCROLL | LBS_NODATA | LBS_OWNERDRAWVARIABLE),
       extended: 0)

  private static let proxy: TableViewProxy = TableViewProxy()

  // MARK - Creating a Table View

  /// Initializes and returns a table view having the given frame and style.
  public init(frame: Rect, style: TableView.Style) {
    self.style = style
    super.init(frame: frame, class: TableView.class, style: TableView.style,
               parent: TableView.proxy.hWnd)
  }

  // MARK - Providing the Table's Data and Cells

  /// The object that acts as the data source of the table view.
  public weak var dataSource: TableViewDataSource? {
    didSet { self.reloadData() }
  }

  // MARK - Configuring the Table's Appearance

  /// The style of the table view.
  public let style: TableView.Style

  // MARK - Selecting Rows

  /// A boolean value that determines whether users can select more than one row
  /// outside of editing mode.
  public var allowsMultipleSelection: Bool {
    get { self.GWL_STYLE & LBS_EXTENDEDSEL == LBS_EXTENDEDSEL }
    set {
      self.GWL_STYLE = (self.GWL_STYLE & ~LBS_EXTENDEDSEL)
                     | (newValue ? 0 : LBS_EXTENDEDSEL)
    }
  }

  // MARK - Reloading the Table View

  /// Reloads the rows and sections of the table view.
  public func reloadData() {
    guard let dataSource = self.dataSource else { return }

    _ = SendMessageW(self.hWnd, UINT(LB_RESETCONTENT), 0, 0)

    for section in 0 ..< dataSource.numberOfSections(in: self) {
      for row in 0 ..< dataSource.tableView(self,
                                            numberOfRowsInSection: section) {
        let cell =
            dataSource.tableView(self,
                                 cellForRowAt: IndexPath(row: row,
                                                         section: section))
        // Resize the frame to the size that fits the content
        cell.frame.size = cell.sizeThatFits(cell.frame.size)

        _ = SendMessageW(self.hWnd, UINT(LB_INSERTSTRING),
                         WPARAM(bitPattern: -1),
                         unsafeBitCast(cell as AnyObject, to: LPARAM.self))
        addSubview(cell)
      }
    }
  }
}
