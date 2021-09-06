//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/08/31.
//

import Foundation

/// Convenience extension on Data for decodings
extension Data {
    /**
     Convenience function for decoding from the data
     
     - parameter decoder: Decoder on which decoding happens, if not specified it has default __JSONDecoder__.
     
     - returns: Decoded value which is decodable type.
     */
    public func decoded<T: Decodable>(using decoder: RLevelDecoder = JSONDecoder()) throws -> T {
        return try decoder.decode(T.self, from: self)
    }
}
