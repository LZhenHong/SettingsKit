# SettingsKit

A lightweight Swift framework for creating macOS preferences windows with SwiftUI content in **AppKit-based applications**.

## When to Use

| App Architecture | Recommended Approach |
|------------------|---------------------|
| **AppKit** (`NSApplicationDelegate`) | ✅ Use SettingsKit |
| **SwiftUI** (`@main struct App`) | Use native [`Settings`](https://developer.apple.com/documentation/swiftui/settings/) scene |

> **Note:** If your app uses the SwiftUI App lifecycle (`@main struct MyApp: App`), you should use SwiftUI's built-in `Settings` scene instead of this library.

## Features

- Native macOS toolbar-style tab interface
- SwiftUI content support with AppKit integration
- Automatic window resizing when switching tabs
- Accessibility support (respects Reduce Motion setting)
- Simple, protocol-based API

## Requirements

- macOS 14.0+
- Swift 5.9+
- Xcode 15.0+

## Installation

### Swift Package Manager

Add the following to your `Package.swift`:

```swift
dependencies: [
  .package(url: "https://github.com/LZhenHong/SettingsKit.git", from: "0.0.1")
]
```

Or add it through Xcode:
1. File → Add Package Dependencies...
2. Enter the repository URL
3. Select the version rule and add to your target

## Usage

### 1. Create Setting Panes

Conform to the `SettingsPane` protocol to create your setting panes:

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
      Toggle("Launch at login", isOn: $launchAtLogin)
      Toggle("Show in menu bar", isOn: $showInMenuBar)
    }
    .formStyle(.grouped)
    .frame(width: 400, height: 200)
  }
}
```

### 2. Create and Show the Settings Window

```swift
import SettingsKit

class AppDelegate: NSObject, NSApplicationDelegate {
  private var settingsWindowController: SettingsWindowController?

  func applicationDidFinishLaunching(_ notification: Notification) {
    let panes: [any SettingsPane] = [
      GeneralSettingPane(),
      AboutSettingPane(),
    ]

    settingsWindowController = SettingsWindowController(panes: panes, title: "Preferences")
  }

  @IBAction func showPreferences(_ sender: Any) {
    settingsWindowController?.show()
  }
}
```

### 3. Optional: Conditionally Enable Panes

```swift
struct AdvancedSettingPane: SettingsPane {
  var isEnabled: Bool {
    // Only show this pane for power users
    UserDefaults.standard.bool(forKey: "showAdvancedSettings")
  }

  // ... rest of implementation
}
```

## API Reference

### SettingsPane

A protocol that defines the content and appearance of a settings pane.

| Property | Type | Description |
|----------|------|-------------|
| `tabViewImage` | `NSImage?` | The image displayed in the toolbar |
| `preferredTitle` | `String` | The title displayed in the toolbar and window title |
| `isEnabled` | `Bool` | Whether this pane should be displayed (default: `true`) |
| `view` | `some View` | The SwiftUI view content |

### SettingsWindowController

A window controller that presents a macOS-style preferences window.

| Method | Description |
|--------|-------------|
| `init(panes:title:)` | Creates a new settings window with the given panes |
| `show(_:)` | Shows the settings window and brings it to front |

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
