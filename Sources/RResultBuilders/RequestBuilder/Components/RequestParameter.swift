//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/08/27.
//

import Foundation

/// A parameter used to build the `Request`
public protocol RequestParameter {
    func buildParameter(_ request: inout URLRequest)
}
