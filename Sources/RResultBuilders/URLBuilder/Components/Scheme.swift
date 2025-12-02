//
//  Scheme.swift
//
//  Created by Pavan on 2021/09/03.
//

import Foundation

/// Assign scheme to URLComponent
public struct Scheme: URLComponent {
    public enum `Type` {
        case http
        case https
        case custom(String)
        
        var rawValue: String {
            switch self {
            case .http:
                return "http"
            case .https:
                return "https"
            case .custom(let scheme):
                return scheme
            }
        }
    }
    
    private let schemeType: `Type`
    
    /// Initialize component with scheme
    /// - Parameter type: scheme type
    public init(_ type: `Type`) {
        schemeType = type
    }
    
    public func build(_ urlComponents: inout URLComponents) {
        urlComponents.scheme = schemeType.rawValue
    }
}
