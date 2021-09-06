//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/09/03.
//

import Foundation

struct Host: URLComponent {
    private let host: String
    
    /// Initialize with custom host
    /// - Parameter host: custom host
    public init(_ host: String) {
        self.host = host
    }
    
    func build(_ urlComponents: inout URLComponents) {
        urlComponents.host = host
    }
}
