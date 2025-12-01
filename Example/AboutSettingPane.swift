//
//  AboutSettingPane.swift
//  SettingsKitExample
//

import Cocoa
import SettingsKit
import SwiftUI

struct AboutSettingPane: SettingContentRepresentable {
  var tabViewImage: NSImage? {
    NSImage(systemSymbolName: "info.circle", accessibilityDescription: "About")
  }

  var preferredTitle: String { "About" }

  var view: some View {
    VStack(spacing: 16) {
      Image(systemName: "app.fill")
        .font(.system(size: 64))
        .foregroundStyle(.blue)

      Text("SettingsKit Example")
        .font(.title)

      Text("Version 1.0.0")
        .foregroundStyle(.secondary)

      Text("A demonstration of how to use SettingsKit to create macOS preference windows.")
        .multilineTextAlignment(.center)
        .foregroundStyle(.secondary)
        .frame(maxWidth: 300)
    }
    .frame(width: 400, height: 250)
  }
}
