/**
 * Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

import WinSDK

public class ViewController: Responder {
  // MARK - Managing the View

  /// The view that the controller manages.
  public var view: View! {
    get {
      loadViewIfNeeded()
      return self.viewIfLoaded
    }
    set {
      self.viewIfLoaded = newValue
    }
  }

  /// The controller's view or `nil` if the view is not yet loaded.
  public private(set) var viewIfLoaded: View?

  /// Indicates if the view is loaded into memory.
  public var isViewLoaded: Bool {
    return self.viewIfLoaded == nil ? false : true
  }

  /// Creates the view that the controller manages.
  public func loadView() {
    self.view = View(frame: .zero)
  }

  /// Called after the controller's view is loaded info memory.
  public func viewDidLoad() {
  }

  /// Loads the controller's view if it has not yet been loaded.
  public func loadViewIfNeeded() {
    guard !self.isViewLoaded else { return }
    self.loadView()
    self.viewDidLoad()
  }

  /// A localized string that represents the view this controller manages.
  public var title: String? {
    get {
      let szLength: Int32 = GetWindowTextLengthW(view.hWnd)
      let buffer: [WCHAR] = Array<WCHAR>(unsafeUninitializedCapacity: Int(szLength) + 1) {
        $1 = Int(GetWindowTextW(view.hWnd, $0.baseAddress!, CInt($0.count)))
      }
      return String(decodingCString: buffer, as: UTF16.self)
    }
    set(value) { _ = SetWindowTextW(view.hWnd, value?.LPCWSTR) }
  }

  /// The preferred size for the view controller's view.
  public var preferredContentSize: Size {
    fatalError("not yet implemented")
  }

  // MARK - Responding to View Related Events

  /// Notifies the view controller that its view is about to be added to a view
  /// hierarchy.
  public func viewWillAppear(_ animated: Bool) {
  }

  /// Notifies the view controller that its view was added to a view hierarchy.
  public func viewDidAppear(_ animated: Bool) {
  }

  /// Notifies the view controller that its view is about to be removed from a
  /// view hierarchy.
  public func viewWillDisappear(_ animated: Bool) {
  }

  /// Notifies the view controller that its view was removed from a view
  /// hierarchy.
  public func viweDidDisappear(_ animated: Bool) {
  }

  /// A Boolean value indicating whether the view controller is being dismissed.
  public private(set) var isBeingDismissed: Bool = false

  /// A Boolean value indicating whether the view controller is being presented.
  public private(set) var isBeingPresented: Bool = false

  /// A Boolean value indicating whether the view controller is being removed
  /// from a parent view controller.
  public private(set) var isMovingFromParent: Bool = false

  /// A Boolean value indicating whether the view controller is being moved to a
  /// parent view controller.
  public private(set) var isMovingToParent: Bool = false

  override public init() {
  }

  // MARK - Responder Chain

  override public var next: Responder? {
    return view?.superview
  }
}

extension ViewController: ContentContainer {
  public func willTransition(to: Size,
                             with coodinator: ViewControllerTransitionCoordinator) {
  }

  public func willTransition(to: TraitCollection,
                             with coordinator: ViewControllerTransitionCoordinator) {
  }

  public func size(forChildContentContainer container: ContentContainer,
                   withParentContainerSize parentSize: Size) -> Size {
    return .zero
  }

  public func preferredContentSizeDidChange(forChildContentContainer container: ContentContainer) {
  }

  public func systemLayoutFittingSizeDidChange(forChildContentContainer container: ContentContainer) {
  }
}
