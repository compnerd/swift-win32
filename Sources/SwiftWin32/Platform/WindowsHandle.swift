// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

internal protocol HandleValue {
  associatedtype HandleType
  static func release(_: HandleType?)
}

internal class ManagedHandle<Value: HandleValue> {
  typealias HandleType = Value.HandleType

  private enum ValueType<HandleType> {
  case owning(HandleType?)
  case referencing(HandleType?)
  }

  private var handle: ValueType<HandleType>

  public var value: HandleType? {
    switch self.handle {
    case .owning(let handle):
      return handle
    case .referencing(let handle):
      return handle
    }
  }

  init(owning handle: HandleType?) {
    self.handle = .owning(handle)
  }

  init(referencing handle: HandleType?) {
    self.handle = .referencing(handle)
  }

  deinit {
    switch self.handle {
    case .owning(let handle):
      if let handle = handle {
        Value.release(handle)
      }
    case .referencing(_):
      break
    }
  }
}
