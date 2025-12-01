//
//  SettingContentRepresentable.swift
//  SettingsKit
//

import Cocoa
import SwiftUI

public protocol SettingContentRepresentable {
  var tabViewImage: NSImage? { get }
  var preferredTitle: String { get }
  var isEnabled: Bool { get }
  @ViewBuilder var view: AnyView { get }
}

public extension SettingContentRepresentable {
  var tabViewItem: NSTabViewItem {
    let viewController = SettingViewController(representable: self)
    let item = NSTabViewItem(viewController: viewController)
    item.image = tabViewImage
    item.label = preferredTitle
    return item
  }

  var isEnabled: Bool {
    true
  }
}
