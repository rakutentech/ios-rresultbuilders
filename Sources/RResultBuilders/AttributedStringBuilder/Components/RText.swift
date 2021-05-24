//
//  RText.swift
//  RResultBuilders
//

import Foundation

/// Component to construct atrributed text
public struct RText: RAttributedComponent {
    public let attributedString: NSAttributedString
            
    public init(_ text: String, attributtes: RAttributes = [:]) {
        attributedString = NSAttributedString(string: text, attributes: attributtes)
    }
    
    public init(_ attributedString: NSAttributedString) {
        self.attributedString = attributedString
    }
}
