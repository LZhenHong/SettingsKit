//
//  SettingsWindowController.swift
//  SettingsKit
//

import Cocoa

/// A window controller that presents a macOS-style preferences window.
///
/// This controller creates a toolbar-style tab interface for displaying multiple
/// setting panes, similar to the native macOS System Preferences/Settings app.
///
/// ## Usage
/// ```swift
/// let panes: [any SettingsPane] = [
///   GeneralPane(),
///   AboutPane(),
/// ]
/// let controller = SettingsWindowController(panes: panes, title: "Preferences")
/// controller.show()
/// ```
public final class SettingsWindowController: NSWindowController {
  private let tabController: SettingsTabController

  /// The setting panes managed by this controller.
  public private(set) var panes: [any SettingsPane]

  /// Creates a new settings window controller.
  /// - Parameters:
  ///   - panes: An array of setting panes to display. Only enabled panes will be shown.
  ///   - title: The window title.
  public init(panes: [any SettingsPane], title: String) {
    self.panes = panes

    tabController = SettingsTabController()
    tabController.tabStyle = .toolbar

    let validPanes = panes.filter(\.isEnabled)
    if !validPanes.isEmpty {
      tabController.tabViewItems = validPanes.map(\.tabViewItem)
    }

    let window = NSWindow(contentRect: .zero, styleMask: [.titled, .closable], backing: .buffered, defer: false)
    window.collectionBehavior = [.managed, .participatesInCycle, .fullScreenNone]
    window.title = title
    window.contentViewController = tabController

    super.init(window: window)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented.")
  }

  /// Shows the settings window and brings it to the front.
  /// - Parameter level: The window level. Defaults to `.normal`.
  public func show(_ level: NSWindow.Level = .normal) {
    guard let window else { return }

    if !window.isVisible {
      window.center()
    }
    window.level = level
    showWindow(self)
    NSApp.activate(ignoringOtherApps: true)
  }
}
