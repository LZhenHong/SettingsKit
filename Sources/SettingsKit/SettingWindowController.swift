//
//  SettingWindowController.swift
//  SettingsKit
//

import Cocoa

public final class SettingWindowController: NSWindowController {
  private var tabViewController: SettingTabViewController
  public private(set) var settings: [SettingContentRepresentable]

  public init(settings: [SettingContentRepresentable]) {
    self.settings = settings

    tabViewController = SettingTabViewController()
    tabViewController.tabStyle = .toolbar

    let validSettings = settings.filter(\.isEnabled)
    if validSettings.count > 0 {
      tabViewController.tabViewItems = validSettings.map(\.tabViewItem)
    }

    let window = NSWindow(contentRect: .zero, styleMask: [.titled, .closable], backing: .buffered, defer: false)
    window.collectionBehavior = [.managed, .participatesInCycle, .fullScreenNone]
    window.title = String(localized: "Settings")
    window.contentViewController = tabViewController

    super.init(window: window)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) can not been called.")
  }

  public func show(_ level: NSWindow.Level = .normal) {
    guard let window else { return }

    NSApp.activate(ignoringOtherApps: true)

    if !window.isKeyWindow {
      window.center()
    }
    window.level = level
    window.makeKeyAndOrderFront(NSApp)
    window.orderFrontRegardless()
    showWindow(self)
  }
}
