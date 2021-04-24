// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

public protocol TextInputTraits {
  /// Managing the Keyboard Behaviour
  var isSecureTextEntry: Bool { get set }
}

extension TextInputTraits {
  public var isSecureTextEntry: Bool {
    get { return false }
    set { }
  }
}
