//
//  Host.swift
//
//  Created by Pavan on 2021/09/03.
//

import Foundation

public struct Host: URLComponent {
    private let host: String
    
    /// Initialize with custom host
    /// - Parameter host: custom host
    public init(_ host: String) {
        self.host = host
    }
    
    public func build(_ urlComponents: inout URLComponents) {
        urlComponents.host = host
    }
}
