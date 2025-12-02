//
//  Decoders.swift
//
//  Created by Pavan on 2021/09/01.
//

import Foundation
public protocol RLevelDecoder {    
    func decode<T>(_ type: T.Type, from: Data) throws -> T where T : Decodable
}

// Protocol conformance to default decoders
extension JSONDecoder: RLevelDecoder {}
extension PropertyListDecoder: RLevelDecoder {}
