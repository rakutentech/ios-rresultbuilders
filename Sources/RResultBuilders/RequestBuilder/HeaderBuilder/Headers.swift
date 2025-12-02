//
//  Headers.swift
//
//  Created by Pavan on 2021/08/31.
//

import Foundation

// Inject Header parameter into URLRequest
public struct Headers: RequestParameter {
    private var rootParameter: RequestParameter?
    private var customHeaders: [String: String]?
        
    /// Initialer that combines all `Header` parameter into one
    public init(@RRequestBuilder builder: () -> RequestParameter) {
        rootParameter = builder()
    }
    
    /// Initialize with custom headers
    public init(custom: [String: String]) {
        customHeaders = custom
    }
    
    public func buildParameter(_ request: inout URLRequest) {
        if let customHeaders = customHeaders {
            customHeaders.forEach { k, v in
                request.setValue(v, forHTTPHeaderField: k)
            }
        } else if let rootParameter = rootParameter {
            rootParameter.buildParameter(&request)
        }
    }
}
