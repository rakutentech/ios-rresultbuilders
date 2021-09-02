//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/08/27.
//

import Foundation

public struct EmptyParameter: RequestParameter {
    public func buildParameter(_ request: inout URLRequest) {}
}
