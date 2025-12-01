//
//  ViewExtensions.swift
//  SettingsKit
//

import SwiftUI

extension NSView {
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

public extension View {
  func eraseToAnyView() -> AnyView {
    AnyView(self)
  }
}
