//
//  Path.swift
//
//  Created by Pavan on 2021/09/03.
//

import Foundation


/// Injects path into `URLComponents`
public struct Path: URLComponent {
    private var path: String
    
    /// Initialize with custom path
    /// - Parameter path: custom path
    public init(_ path: String) {
        if !path.hasPrefix("/") {
            self.path = "/" + path
        } else {
            self.path = path
        }
    }
    
    public func build(_ urlComponents: inout URLComponents) {
        urlComponents.path += path
    }
}
