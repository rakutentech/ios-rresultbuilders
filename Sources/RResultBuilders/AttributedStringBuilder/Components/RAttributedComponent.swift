//
//  RAttributedComponent.swift
//  RResultBuilders
//

#if canImport(UIKit)
import UIKit
#endif

public typealias RAttributes = [NSAttributedString.Key: Any]

/// Protocol that helps in constructing attributed components
public protocol RAttributedComponent {
    var attributedString: NSAttributedString { get }
}
