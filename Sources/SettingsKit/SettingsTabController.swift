//
//  SettingsTabController.swift
//  SettingsKit
//

import Cocoa

/// A tab view controller that manages setting panes with toolbar-style tabs.
///
/// This controller automatically resizes the window when switching between tabs
/// and respects accessibility settings for reduced motion.
public final class SettingsTabController: NSTabViewController {
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

  /// Resizes the window to fit the content while keeping the top edge anchored.
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
