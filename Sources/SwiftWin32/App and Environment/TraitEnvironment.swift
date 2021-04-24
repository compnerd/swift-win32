// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

public protocol TraitEnvironment {
  var traitCollection: TraitCollection { get }
  func traitCollectionDidChange(_ previousTraitCollection: TraitCollection?)
}
