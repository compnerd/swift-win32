/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

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
