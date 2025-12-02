//
//  EmptyComponent.swift
//
//  Created by Pavan on 2021/09/03.
//

import Foundation

struct EmptyComponent: URLComponent {
    func build(_ urlComponents: inout URLComponents) {
        // No op
    }
}
