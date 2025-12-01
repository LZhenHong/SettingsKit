//
//  SettingWindowController.swift
//  SettingsKit
//

import Cocoa

public final class SettingWindowController: NSWindowController {
  private let tabViewController: SettingTabViewController
  public private(set) var settings: [any SettingContentRepresentable]

  public init(settings: [any SettingContentRepresentable], title: String) {
    self.settings = settings

    tabViewController = SettingTabViewController()
    tabViewController.tabStyle = .toolbar

    let validSettings = settings.filter(\.isEnabled)
    if !validSettings.isEmpty {
      tabViewController.tabViewItems = validSettings.map(\.tabViewItem)
    }

    let window = NSWindow(contentRect: .zero, styleMask: [.titled, .closable], backing: .buffered, defer: false)
    window.collectionBehavior = [.managed, .participatesInCycle, .fullScreenNone]
    window.title = title
    window.contentViewController = tabViewController

    super.init(window: window)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented.")
  }

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
