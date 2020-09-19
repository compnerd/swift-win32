/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

public class ViewController {
  /// Managing the View
  public var view: View!

  public var preferredContentSize: Size { fatalError("not yet implemented") }

  public var title: String? {
    get {
      let szLength: Int32 = GetWindowTextLengthW(view.hWnd)
      let buffer: [WCHAR] = Array<WCHAR>(unsafeUninitializedCapacity: Int(szLength) + 1) {
        $1 = Int(GetWindowTextW(view.hWnd, $0.baseAddress!, CInt($0.count)))
      }
      return String(decodingCString: buffer, as: UTF16.self)
    }
    set(value) {
      SetWindowTextW(view.hWnd, value?.LPCWSTR)
    }
  }

  public init() {
  }
}

extension ViewController: ContentContainer {
  public func willTransition(to: Size,
                             with coodinator: ViewControllerTransitionCoordinator) {
  }

  public func willTransition(to: TraitCollection,
                             with coordinator: ViewControllerTransitionCoordinator) {
  }

  public func size(forChildContentContainer container: ContentContainer,
                   withParentContainerSize parentSize: Size) -> Size {
    return .zero
  }

  public func preferredContentSizeDidChange(forChildContentContainer container: ContentContainer) {
  }

  public func systemLayoutFittingSizeDidChange(forChildContentContainer container: ContentContainer) {
  }
}
