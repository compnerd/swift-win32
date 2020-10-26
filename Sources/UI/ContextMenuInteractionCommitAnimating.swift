/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// Constants that control the interaction commit style.
public enum ContextMenuInteractionCommitStyle: Int {
/// An interaction with no animations.
case dismiss
/// An interaction that uses animations.
case pop
}

/// Methods adopted by system-supplied animator objects when committing
/// preview-related animations.
public protocol ContextMenuInteractionCommitAnimating: ContextMenuInteractionAnimating {
  /// Specifying the Commit Style
  var preferredCommitStyle: ContextMenuInteractionCommitStyle { get set }
}
