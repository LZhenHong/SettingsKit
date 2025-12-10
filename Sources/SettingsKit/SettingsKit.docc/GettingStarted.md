# Getting Started

Learn how to create a macOS preferences window using SettingsKit.

## Overview

This guide walks you through the basic steps to create a preferences window for your macOS application.

## Create a Settings Pane

First, create a struct that conforms to the ``SettingsPane`` protocol:

```swift
import SettingsKit
import SwiftUI

struct GeneralSettingPane: SettingsPane {
  var tabViewImage: NSImage? {
    NSImage(systemSymbolName: "gear", accessibilityDescription: "General")
  }

  var preferredTitle: String { "General" }

  var view: some View {
    Form {
      Toggle("Launch at login", isOn: .constant(false))
      Toggle("Show in menu bar", isOn: .constant(true))
    }
    .formStyle(.grouped)
    .frame(width: 400, height: 200)
  }
}
```

## Create the Settings Window

Next, create a ``SettingsWindowController`` with your panes:

```swift
import SettingsKit

class AppDelegate: NSObject, NSApplicationDelegate {
  private var settingsWindowController: SettingsWindowController?

  func applicationDidFinishLaunching(_ notification: Notification) {
    let panes: [any SettingsPane] = [
      GeneralSettingPane(),
      AboutSettingPane(),
    ]

    settingsWindowController = SettingsWindowController(
      panes: panes,
      title: "Preferences"
    )
  }
}
```

## Show the Settings Window

Call the ``SettingsWindowController/show(paneIndex:level:)`` method to display the window:

```swift
@IBAction func showPreferences(_ sender: Any) {
  settingsWindowController?.show()
}
```

## Select a Specific Pane

You can select a specific pane when showing the window or programmatically at runtime:

```swift
// Show window and select the second pane (index 1)
settingsWindowController?.show(paneIndex: 1)

// Or select a pane at runtime
settingsWindowController?.selectPane(at: 2)

// Get the currently selected pane index
let currentIndex = settingsWindowController?.selectedPaneIndex
```

## Conditionally Enable Panes

You can conditionally show or hide panes by implementing the ``SettingsPane/isEnabled`` property:

```swift
struct AdvancedSettingPane: SettingsPane {
  var isEnabled: Bool {
    UserDefaults.standard.bool(forKey: "showAdvancedSettings")
  }

  // ... rest of implementation
}
```
