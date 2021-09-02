//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/09/01.
//

import Foundation

public enum Auth {
    case basic(username: String, password: String)
    case bearer(token: String)
    case custom(name: String, token: String)
    
    var value: String {
        switch self {
        case .basic(let username, let password):
            let encodedInfo = Data("\(username):\(password)".utf8).base64EncodedString()
            return "Basic \(encodedInfo)"
        case .bearer(let token):
            return "Bearer \(token)"
        case .custom(let name, let token):
            return "\(name) \(token)"
        }
    }
}
