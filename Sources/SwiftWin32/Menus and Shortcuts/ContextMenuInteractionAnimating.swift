// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

/// Methods adopted by system-supplied animator objects when interacting with
/// context menus.
public protocol ContextMenuInteractionAnimating {
  /// Adding Custom Animations

  /// Adds the specified animation block to the animator.
  func addAnimations(_ animations: @escaping () -> Void)

  /// Adds the specified completion block to the animator.
  func addCompletion(_ completion: @escaping () -> Void)

  /// Previewing the Content

  /// The current preview controller.
  var previewViewController: ViewController? { get }
}
