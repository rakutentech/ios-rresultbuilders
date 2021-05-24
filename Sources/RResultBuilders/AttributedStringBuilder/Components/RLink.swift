//
//  RLink.swift
//  RResultBuilders
//

import Foundation

/// Component to insert link in attributed string
public struct RLink: RAttributedComponent {
    public let attributedString: NSAttributedString
    
    // MARK:- Initializers
    public init(_ anchorText: String, url: URL, attributtes: RAttributes = [:]) {
        // Apply link
        var copyAttributters = attributtes
        copyAttributters[.link] = url
        attributedString = NSAttributedString(string: anchorText, attributes: copyAttributters)
    }
}
