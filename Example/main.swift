//
//  main.swift
//  SettingsKitExample
//

import Cocoa
import SettingsKit

// MARK: - App Delegate

class AppDelegate: NSObject, NSApplicationDelegate {
  private var settingWindowController: SettingWindowController?

  func applicationDidFinishLaunching(_: Notification) {
    // Create setting panes
    let settings: [any SettingContentRepresentable] = [
      GeneralSettingPane(),
      AboutSettingPane(),
    ]

    // Create and show the settings window
    settingWindowController = SettingWindowController(settings: settings, title: "Preferences")
    settingWindowController?.show()
  }

  func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
    true
  }
}

// MARK: - Main

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
