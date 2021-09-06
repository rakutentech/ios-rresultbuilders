//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/08/27.
//

import Foundation

public enum Method: String {
    case GET
    case HEAD
    case POST
    case PUT
    case DELETE
}

// MARK: - RequestParameter
extension Method: RequestParameter {
    public func buildParameter(_ request: inout URLRequest) {
        request.httpMethod = self.rawValue
    }
}
