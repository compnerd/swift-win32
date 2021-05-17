// Copyright (c) 2021 Yassine BENABBAS
// 
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

extension Label {
  /// Constants describing the types of events possible for controls.
  public struct Event: Equatable, Hashable, RawRepresentable {
    public typealias RawValue = Int

    public let rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}