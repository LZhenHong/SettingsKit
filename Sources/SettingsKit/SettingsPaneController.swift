//
//  SettingsPaneController.swift
//  SettingsKit
//

import Cocoa
import SwiftUI

/// A view controller that hosts a SwiftUI view from a ``SettingsPane``.
///
/// This controller bridges SwiftUI content to AppKit by embedding an `NSHostingController`
/// and automatically manages the preferred content size for window resizing.
public final class SettingsPaneController<T: SettingsPane>: NSViewController {
  private let pane: T

  /// Creates a new settings pane controller.
  /// - Parameter pane: The settings pane to display.
  public init(pane: T) {
    self.pane = pane
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented.")
  }

  override public func loadView() {
    view = NSView()
    view.translatesAutoresizingMaskIntoConstraints = false

    let hostingViewController = NSHostingController(rootView: pane.view)
    hostingViewController.sizingOptions = .preferredContentSize
    addChild(hostingViewController)
    view.addSubview(hostingViewController.view)
    hostingViewController.view.constrainToSuperviewBounds()
  }

  override public func viewWillAppear() {
    super.viewWillAppear()

    preferredContentSize = view.fittingSize
  }
}

// MARK: - NSView Extension

private extension NSView {
  /// Constrains the view to fill its superview.
  /// - Returns: The created constraints.
  @discardableResult
  func constrainToSuperviewBounds() -> [NSLayoutConstraint] {
    guard let superview else {
      preconditionFailure("superview has to be set first")
    }

    translatesAutoresizingMaskIntoConstraints = false
    let constraints = [
      leadingAnchor.constraint(equalTo: superview.leadingAnchor),
      trailingAnchor.constraint(equalTo: superview.trailingAnchor),
      topAnchor.constraint(equalTo: superview.topAnchor),
      bottomAnchor.constraint(equalTo: superview.bottomAnchor),
    ]
    NSLayoutConstraint.activate(constraints)
    return constraints
  }
}
