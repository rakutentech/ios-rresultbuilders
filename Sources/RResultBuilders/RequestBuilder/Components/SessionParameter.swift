//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/08/31.
//

import Foundation

protocol SessionParameter: RequestParameter {
    func buildConfiguration(_ configuration: URLSessionConfiguration)
}

extension SessionParameter {
    public func buildParameter(_ request: inout URLRequest) {
        fatalError("SessionParam shouldn't build URLRequest")
    }
}
