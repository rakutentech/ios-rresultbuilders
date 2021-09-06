//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/09/03.
//

import Foundation

public struct Query: URLComponent {
    private var queryPrameters: [String: Any] = [:]
    
    /// Initialize component with query-value
    public init(query name: String, value: Any? = nil) {
        queryPrameters[name] = value
    }
    
    /// Initialize component with list of query-value pairs
    /// - Parameter queryPrameters: query value pairs
    public init(queryPrameters other: [String: Any]) {
        self.queryPrameters.merge(other) { (current, _) in current }
    }
    
    public func build(_ urlComponents: inout URLComponents) {
        urlComponents.queryItems = queryPrameters.map { URLQueryItem(name: $0.0, value: String(describing: $0.1)) }
    }
}
