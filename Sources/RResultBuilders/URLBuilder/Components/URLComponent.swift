//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/09/03.
//

import Foundation

public protocol URLComponent {
    func build(_ urlComponents: inout URLComponents)
}
