// Copyright © 2021 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import SwiftWin32

/// A property wrapper that is used in `App` to provide an application delegate
/// from Swift/Win32.
@propertyWrapper
public struct UIApplicationDelegateAdaptor<DelegateType: ApplicationDelegate> {
  /// The underlying delegate.
  public private(set) var wrappedValue: DelegateType

  /// Creates an `UIApplicationDelegateAdaptor` using an ApplicationDelegate.
  public init(_ delegateType: DelegateType.Type = DelegateType.self) {
    self.wrappedValue = delegateType.init()
  }
}
