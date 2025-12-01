//
//  SettingsPane.swift
//  SettingsKit
//

import Cocoa
import SwiftUI

/// A protocol that defines the content and appearance of a settings pane.
///
/// Conform to this protocol to create custom setting panes that can be displayed
/// in a ``SettingsWindowController``.
///
/// ## Example
/// ```swift
/// struct GeneralPane: SettingsPane {
///   var tabViewImage: NSImage? {
///     NSImage(systemSymbolName: "gear", accessibilityDescription: "General")
///   }
///
///   var preferredTitle: String { "General" }
///
///   var view: some View {
///     Text("General Settings")
///   }
/// }
/// ```
public protocol SettingsPane<Content> {
  associatedtype Content: View

  /// The image displayed in the toolbar for this setting pane.
  var tabViewImage: NSImage? { get }

  /// The title displayed in the toolbar and window title bar.
  var preferredTitle: String { get }

  /// Whether this setting pane is enabled and should be displayed.
  var isEnabled: Bool { get }

  /// The SwiftUI view content for this setting pane.
  @ViewBuilder var view: Content { get }
}

public extension SettingsPane {
  /// Creates an `NSTabViewItem` configured with this pane's content.
  var tabViewItem: NSTabViewItem {
    let viewController = SettingsPaneController(pane: self)
    let item = NSTabViewItem(viewController: viewController)
    item.image = tabViewImage
    item.label = preferredTitle
    return item
  }

  var isEnabled: Bool {
    true
  }
}
