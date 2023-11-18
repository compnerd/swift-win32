// Copyright © 2020 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

#if swift(>=5.7)
import CoreGraphics
#endif

/// A reusable view that you place at the top or bottom of a table section to
/// display additional information for that section.
public class TableViewHeaderFooterView: View {
  private static let `class`: WindowClass =
      WindowClass(hInst: GetModuleHandleW(nil),
                  name: "Swift.TableViewHeaderFooterView",
                  style: UInt32(CS_HREDRAW | CS_VREDRAW),
                  hbrBackground: GetSysColorBrush(COLOR_3DFACE),
                  hCursor: LoadCursorW(nil, IDC_ARROW))
  private static let style: WindowStyle = (base: 0, extended: 0)

  // MARK - Creating the View

  /// Initializes a header/footer view with the specified reuse identifier.
  public init(reuseIdentifier identifier: String?) {
    self.reuseIdentifier = identifier

    self.contentView = View(frame: .zero)
    self.configurationState =
        ViewConfigurationState(traitCollection: TraitCollection.current)

    super.init(frame: .zero, class: TableViewHeaderFooterView.class,
               style: TableViewHeaderFooterView.style)
  }

  // MARK - Managing View Reuse

  /// A string used to identify a reusable header or footer.
  public private(set) var reuseIdentifier: String?

  /// Prepares a reusable header or footer view for reuse by the table.
  public func prepareForReuse() {
  }

  // MARK - Configuring the Background

  /// The current background configuration of the view.
  public var backgroundConfiguration: BackgroundConfiguration? {
    didSet {
      if self.backgroundConfiguration != nil {
        self.backgroundColor = nil
        self.backgroundView = nil
      }
    }
  }

  /// A boolean value that determines whether the view automatically updates its
  /// background configuration when its state changes.
  public var automaticallyUpdatesBackgroundConfiguration: Bool = true

  /// The background view of the header or footer.
  public var backgroundView: View? {
    didSet {
      if self.backgroundView != nil {
        self.backgroundConfiguration = nil
      }
    }
  }

  // MARK - Managing the Content

  /// Retrieves a default list content configuration for the view's style.
  public func defaultContentConfiguration() -> ListContentConfiguration {
    fatalError("\(#function) not yet implemented")
  }

  /// The current content configuration of the view.
  public var contentConfiguration: ContentConfiguration?

  /// A boolean value that determines whether the view automatically updates its
  /// content configuration when its state changes.
  public var automaticallyUpdatesContentConfiguration: Bool = true

  /// The content view of the header or footer.
  public private(set) var contentView: View

  // MARK - Managing the State

  /// The current configuration state of the view.
  public private(set) var configurationState: ViewConfigurationState

  /// Informs the view to update its configuration for its current state.
  public func setNeedsUpdateConfiguration() {
    fatalError("\(#function) not yet implemented")
  }

  /// Updates the view's configuration using the current state.
  public func updateConfiguration(using state: ViewConfigurationState) {
    fatalError("\(#function) not yet implemented")
  }
}
