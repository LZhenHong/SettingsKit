//
//  SettingTabViewController.swift
//  SettingsKit
//

import Cocoa

public final class SettingTabViewController: NSTabViewController {
  override public func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
    super.tabView(tabView, didSelect: tabViewItem)

    guard let tabViewItem,
          let size = tabViewItem.view?.frame.size
    else {
      return
    }

    guard let window = view.window else {
      view.frame.size = size
      return
    }

    window.title = tabViewItem.label
    resize(window: window, to: size)
  }

  private func resize(window: NSWindow, to size: NSSize) {
    let contentRect = NSRect(origin: .zero, size: size)
    let frameRect = window.frameRect(forContentRect: contentRect)
    let heightDelta = window.frame.height - frameRect.height
    let newOrigin = NSPoint(x: window.frame.origin.x, y: window.frame.origin.y + heightDelta)
    let newFrame = NSRect(origin: newOrigin, size: frameRect.size)

    NSAnimationContext.runAnimationGroup { context in
      context.allowsImplicitAnimation = !NSWorkspace.shared.accessibilityDisplayShouldReduceMotion
      window.animator().setFrame(newFrame, display: false)
    }
  }
}
