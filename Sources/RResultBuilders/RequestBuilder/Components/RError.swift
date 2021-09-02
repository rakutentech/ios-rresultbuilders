//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/08/31.
//

import Foundation

/// An error returned by the `Request`
public enum RError {
    /// Raw Http error from URLSession
    case raw(error: Error)
    /// Http status code error
    case http(statusCode: Int, error: Data?)
    /// Decoding error for expected response type
    case decoding(error: Error)
}
