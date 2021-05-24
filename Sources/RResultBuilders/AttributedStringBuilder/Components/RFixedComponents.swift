//
//  RStaticComponents.swift
//  RResultBuilders
//

import Foundation

/// Just empty component
public struct REmpty: RAttributedComponent {
    public let attributedString = NSAttributedString(string: "")
    
    public init() { }
}

/// Component to add space
public struct RSpace: RAttributedComponent {
    public let attributedString: NSAttributedString
    
    // MARK:- Initializer
    public init(count: Int = 1) {
        let spaces = Array(repeating: " ", count: count).joined()
        attributedString = NSAttributedString(string: spaces)
    }
}

/// Component to insert line break
public struct RLineBreak: RAttributedComponent {
    public let attributedString: NSAttributedString
    
    // MARK:- Initializer
    public init(count: Int = 1) {
        let lineBreaks = Array(repeating: "\n", count: count).joined()
        attributedString = NSAttributedString(string: lineBreaks)
    }
}

