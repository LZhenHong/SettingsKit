//
//  GeneralSettingPane.swift
//  SettingsKitExample
//

import Cocoa
import SettingsKit
import SwiftUI

struct GeneralSettingPane: SettingContentRepresentable {
  var tabViewImage: NSImage? {
    NSImage(systemSymbolName: "gear", accessibilityDescription: "General")
  }

  var preferredTitle: String { "General" }

  var view: some View {
    Form {
      Toggle("Launch at login", isOn: .constant(false))
      Toggle("Show in menu bar", isOn: .constant(true))

      Divider()

      Picker("Default action:", selection: .constant(0)) {
        Text("Option 1").tag(0)
        Text("Option 2").tag(1)
        Text("Option 3").tag(2)
      }
    }
    .formStyle(.grouped)
    .frame(width: 400, height: 200)
  }
}
