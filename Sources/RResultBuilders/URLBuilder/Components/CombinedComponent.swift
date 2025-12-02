//
//  CombinedComponent.swift
//
//  Created by Pavan on 2021/09/03.
//

import Foundation

struct CombinedComponent: URLComponent {
    private let children: [URLComponent]
    
    init(_ children: [URLComponent]) {
        self.children = children
    }
    
    func build(_ urlComponents: inout URLComponents) {
        children.forEach {
            $0.build(&urlComponents)
        }
    }
}
