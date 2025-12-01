//
//  SettingViewController.swift
//  SettingsKit
//

import Cocoa
import SwiftUI

public final class SettingViewController<T: SettingContentRepresentable>: NSViewController {
  private let representable: T
  private var constraints: [NSLayoutConstraint] = []

  public init(representable: T) {
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
    constraints = hostingViewController.view.constrainToSuperviewBounds()
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

    var result = [NSLayoutConstraint]()
    result.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|",
                                                             options: .directionLeadingToTrailing,
                                                             metrics: nil,
                                                             views: ["subview": self]))
    result.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|",
                                                             options: .directionLeadingToTrailing,
                                                             metrics: nil,
                                                             views: ["subview": self]))
    translatesAutoresizingMaskIntoConstraints = false
    superview.addConstraints(result)

    return result
  }
}
