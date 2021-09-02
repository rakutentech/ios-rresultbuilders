//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/08/27.
//

import Foundation

struct RequestBody: RequestParameter {
    private let data: Data?
    
    /// Creates the `Body` from an `Encodable` type using `JSONEncoder`
    /// NOTE:  Don't pass `Data` to this initializer instead use `init(data...)`
    public init<T: Encodable>(_ value: T) {
        self.data = try? JSONEncoder().encode(value)
    }
    
    /// Creates the `Body` from given`Data`
    public init(data: Data) {
        self.data = data
    }
    
    func buildParameter(_ request: inout URLRequest) {
        request.httpBody = data
    }
}
