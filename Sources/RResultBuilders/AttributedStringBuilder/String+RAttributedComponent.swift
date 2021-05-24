//
//  String+RAttributedComponent.swift
//  
//

import Foundation

/// String type that represents  as `RAttributedComponent`
extension String: RAttributedComponent {
    public var attributedString: NSAttributedString {
        NSAttributedString(string: self)
    }
}
