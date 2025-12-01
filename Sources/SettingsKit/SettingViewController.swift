//
//  SettingViewController.swift
//  SettingsKit
//

import Cocoa
import SwiftUI

public final class SettingViewController<T: SettingContentRepresentable>: NSViewController {
  private let representable: T

  public init(representable: T) {
    self.representable = representable
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented.")
  }

  override public func loadView() {
    view = NSView()
    view.translatesAutoresizingMaskIntoConstraints = false

    let hostingViewController = NSHostingController(rootView: representable.view)
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

private extension NSView {
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
