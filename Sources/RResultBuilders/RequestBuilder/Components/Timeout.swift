//
//  Timeout.swift
//
//  Created by Pavan on 2021/08/31.
//

import Foundation

/// Injects timeout interval for request
public struct Timeout: RequestParameter, SessionParameter {
    private let timeout: TimeInterval
    
    /// Initialize with timeout value
    public init(_ timeout: TimeInterval) {
        self.timeout = timeout
    }
    
    // Apply to the URLRequest directly
    public func buildParameter(_ request: inout URLRequest) {
        request.timeoutInterval = timeout
    }
    
    // Apply to the session configuration
    public func buildConfiguration(_ configuration: URLSessionConfiguration) {
        configuration.timeoutIntervalForRequest = timeout
    }
}
