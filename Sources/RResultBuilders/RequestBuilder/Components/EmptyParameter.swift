//
//  EmptyParameter.swift
//
//  Created by Pavan on 2021/08/27.
//

import Foundation

public struct EmptyParameter: RequestParameter {
    public func buildParameter(_ request: inout URLRequest) {}
}
