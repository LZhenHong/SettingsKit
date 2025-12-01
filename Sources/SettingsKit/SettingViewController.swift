//
//  SettingViewController.swift
//  SettingsKit
//

import Cocoa
import SwiftUI

public final class SettingViewController: NSViewController {
  private let representable: SettingContentRepresentable
  private var constrains: [NSLayoutConstraint] = []

  public init(representable: SettingContentRepresentable) {
    self.representable = representable
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) can not been called.")
  }

  override public func loadView() {
    view = NSView()
    view.translatesAutoresizingMaskIntoConstraints = false

    let hostingViewController = NSHostingController(rootView: representable.view)
    hostingViewController.sizingOptions = .preferredContentSize
    addChild(hostingViewController)
    view.addSubview(hostingViewController.view)
    constrains = hostingViewController.view.constrainToSuperviewBounds()
  }

  override public func viewWillAppear() {
    super.viewWillAppear()

    preferredContentSize = view.fittingSize
  }
}
