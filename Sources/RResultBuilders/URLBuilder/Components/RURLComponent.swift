//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/08/16.
//

import Foundation

public extension URL {
    enum Scheme: String {
        case http
        case https
    }
}

/// Custom URLComponent to build URL using components
public struct RURLComponent {
    private(set) var components = URLComponents()
    
    /// Default initializer
    init() {}
    
    /// Initialize component with URLComponents
    /// - Parameter components: url components
    init(components: URLComponents) {
        self.components = components
    }
    
    /// Initialize component with scheme
    /// - Parameter scheme: scheme
    public init(scheme: URL.Scheme) {
        components.scheme = scheme.rawValue
    }
    
    /// Initialize component with host
    /// - Parameter host: host
    public init(host: String) {
        components.host = host
    }
    
    /// Initialize component with path
    /// - Parameter path: path
    public init(path: String) {
        if !path.hasPrefix("/") {
            components.path = "/" + path
        } else {
            components.path = path
        }
    }
    
    /// Initialize component with single query and value
    /// - Parameters:
    ///   - name: query name
    ///   - value: query value
    public init(query name: String, value: String? = nil) {
        components.queryItems = [URLQueryItem(name: name, value: value)]
    }
    
    /// Initialize component with list of query-value pairs
    /// - Parameter queryPrameters: query value pairs
    public init(queryPrameters: [String: Any]) {
        components.queryItems = queryPrameters.map { URLQueryItem(name: $0.0, value: String(describing: $0.1)) }
    }
}
