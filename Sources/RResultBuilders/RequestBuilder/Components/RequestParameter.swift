//
//  RequestParameter.swift
//
//  Created by Pavan on 2021/08/27.
//

import Foundation

/// A parameter used to build the `Request`
public protocol RequestParameter: Sendable {
    func buildParameter(_ request: inout URLRequest)
}
