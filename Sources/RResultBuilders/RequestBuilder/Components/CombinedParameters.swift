//
//  CombinedParameters.swift
//
//  Created by Pavan on 2021/08/27.
//

import Foundation

struct CombinedParameters: RequestParameter, SessionParameter {
    let allParameters: [RequestParameter]
    
    init(_ allParameters: [RequestParameter]) {
        self.allParameters = allParameters
    }
    
    // Inject all parameters into requrst
    func buildParameter(_ request: inout URLRequest) {
        allParameters
            .filter { !($0 is SessionParameter) }
            .forEach { $0.buildParameter(&request) }
    }
    
    func buildConfiguration(_ configuration: URLSessionConfiguration) {
        allParameters
            .compactMap { $0 as? SessionParameter }
            .forEach { $0.buildConfiguration(configuration) }
    }
}
