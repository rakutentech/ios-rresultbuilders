//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/08/31.
//

import Foundation

/// Injects timeout interval for request
public struct Timeout: SessionParameter {
    private let timeout: TimeInterval
    
    /// Initialize with timeout value
    public init(_ timeout: TimeInterval) {
        self.timeout = timeout
    }
    
    public func buildConfiguration(_ configuration: URLSessionConfiguration) {
        configuration.timeoutIntervalForRequest = timeout
    }
}
