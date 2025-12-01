//
//  main.swift
//  SettingsKitExample
//

import Cocoa
import SettingsKit

// MARK: - App Delegate

class AppDelegate: NSObject, NSApplicationDelegate {
  private var settingsWindowController: SettingsWindowController?

  func applicationDidFinishLaunching(_: Notification) {
    // Create setting panes
    let panes: [any SettingsPane] = [
      GeneralSettingPane(),
      AboutSettingPane(),
    ]

    // Create and show the settings window
    settingsWindowController = SettingsWindowController(panes: panes, title: "Preferences")
    settingsWindowController?.show()
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
