//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/08/31.
//

import Foundation

public enum MediaType: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    case json
    case xml
    case text
    case html
    case css
    case javascript
    case custom(String)
    
    public var rawValue: String {
        switch self {
        case .json:
            return "application/json"
        case .xml:
            return "application/xml"
        case .text:
            return "text/plain"
        case .html:
            return "text/html"
        case .css:
            return "text/css"
        case .javascript:
            return "text/javascript"
        case .custom(let string):
            return string
        }
    }
    
    public init(stringLiteral value: String) {
        self = .custom(value)
    }
}
