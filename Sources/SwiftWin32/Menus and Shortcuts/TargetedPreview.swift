// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

public class TargetedPreview {
  /// Creting a Targeted Preview Object

  /// Creates a targeted preview with the specified view, parameters, and target
  /// container.
  public init(view: View, parameters: PreviewParameters, target: PreviewTarget) {
    self.view = view
    // FIXME(compnerd) is this correct?
    self.size = view.frame.size
    self.target = target
    self.parameters = parameters
  }

  /// Creates a targeted preview for a view in the current window and including
  /// the specified parameters.
  public convenience init(view: View, parameters: PreviewParameters) {
    self.init(view: view, parameters: parameters,
              target: PreviewTarget(container: view, center: view.center))
  }

  /// Creates a targeted preview for a view in the current window.
  public convenience init(view: View) {
    self.init(view: view, parameters: PreviewParameters())
  }

  /// Getting the Preview Attributes

  /// The view that is the target of the animation
  public let view: View

  /// The view that is the container for the target view.
  public let target: PreviewTarget

  /// The size of the view.
  public let size: Size

  /// Additional parameters to use when configuring the animations.
  public let parameters: PreviewParameters

  /// Changing the Target's Container

  /// Returns a targeted preview object with the same view and parameters, but
  /// with a different target container.
  public func retargetedPreview(with newTarget: PreviewTarget)
      -> TargetedPreview {
    return TargetedPreview(view: self.view, parameters: self.parameters,
                           target: newTarget)
  }
}
