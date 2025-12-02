//
//  CachePolicy.swift
//
//  Created by Pavan on 2021/09/02.
//

import Foundation

public struct CachePolicy: RequestParameter {
    private let policy: URLRequest.CachePolicy
    
    public init(_ policy: URLRequest.CachePolicy) {
        self.policy = policy
    }
    
    public func buildParameter(_ request: inout URLRequest) {
        request.cachePolicy = policy
    }
}
