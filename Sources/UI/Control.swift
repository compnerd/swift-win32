/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
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

public class Control: View {
}

public extension Control {
  struct State: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
  }
}

public extension Control.State {
  static let normal: Control.State = Control.State(rawValue: 1 << 0)
  static let highlighted: Control.State = Control.State(rawValue: 1 << 1)
  static let disabled: Control.State = Control.State(rawValue: 1 << 2)
  static let selected: Control.State = Control.State(rawValue: 1 << 3)
  static let focused: Control.State = Control.State(rawValue: 1 << 4)
  static let application: Control.State = Control.State(rawValue: 1 << 5)
  static let reserved: Control.State = Control.State(rawValue: 1 << 6)
}

extension Control {
  public struct Event: Equatable, Hashable, RawRepresentable {
    public typealias RawValue = Int

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension Control.Event {
  public static let touchDown: Control.Event =
      Control.Event(rawValue: 1 << 0)
  public static let touchDownRepeat: Control.Event =
      Control.Event(rawValue: 1 << 1)
  public static let touchDragInside: Control.Event =
      Control.Event(rawValue: 1 << 2)
  public static let touchDragOutside: Control.Event =
      Control.Event(rawValue: 1 << 3)
  public static let touchDragEnter: Control.Event =
      Control.Event(rawValue: 1 << 4)
  public static let touchDragExit: Control.Event =
      Control.Event(rawValue: 1 << 5)
  public static let touchUpInside: Control.Event =
      Control.Event(rawValue: 1 << 6)
  public static let touchUpOutside: Control.Event =
      Control.Event(rawValue: 1 << 7)
  public static let touchCancel: Control.Event =
      Control.Event(rawValue: 1 << 8)

  public static let valueChanged: Control.Event =
      Control.Event(rawValue: 1 << 12)
  public static let menuActionTriggered: Control.Event =
      Control.Event(rawValue: 0)
  public static let primaryActionTriggered: Control.Event =
      Control.Event(rawValue: 1 << 13)

  public static let editingDidBegin: Control.Event =
      Control.Event(rawValue: 1 << 16)
  public static let editingChanged: Control.Event =
      Control.Event(rawValue: 1 << 17)
  public static let editingDidEnd: Control.Event =
      Control.Event(rawValue: 1 << 18)
  public static let editingDidEndOnExit: Control.Event =
      Control.Event(rawValue: 1 << 19)

  public static let allTouchEvents: Control.Event =
      Control.Event(rawValue: 0x00000fff)
  public static let allEditingEvents: Control.Event =
      Control.Event(rawValue: 0x000f0000)

  public static let applicationReserved: Control.Event =
      Control.Event(rawValue: 0x0f000000)
  public static let systemReserved: Control.Event =
      Control.Event(rawValue: 0xf0000000)

  public static let allEvents: Control.Event =
      Control.Event(rawValue: 0xffffffff)
}
