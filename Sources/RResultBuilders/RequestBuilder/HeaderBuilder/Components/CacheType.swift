//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/09/01.
//

import Foundation

/// The caching method, to be used with the `Cache-Control` header
public enum CacheType {
    case noCache
    case noStore
    case noTransform
    case onlyIfCached
    case maxAge(seconds: Int)
    
    var value: String {
        switch self {
        case .noCache:
            return "no-cache"
        case .noStore:
            return "no-store"
        case .noTransform:
            return "no-transform"
        case .onlyIfCached:
            return "only-if-cached"
        case .maxAge(let seconds):
            return "max-age=\(seconds)"
        }
    }
}
