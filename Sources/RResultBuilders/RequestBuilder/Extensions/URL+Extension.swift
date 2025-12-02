//
//  URL+Extension.swift
//
//  Created by Pavan on 2021/08/31.
//

import Foundation

extension URL: RequestParameter {
    public func buildParameter(_ request: inout URLRequest) {
        request.url = self
    }
}
