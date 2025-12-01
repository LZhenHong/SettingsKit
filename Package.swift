// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "SettingsKit",
  platforms: [.macOS(.v14)],
  products: [.library(name: "SettingsKit", targets: ["SettingsKit"])],
  targets: [.target(name: "SettingsKit")]
)
