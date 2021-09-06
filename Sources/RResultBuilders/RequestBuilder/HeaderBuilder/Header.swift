//
//  File.swift
//  File
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/09/01.
//

import Foundation

// Inject Header parameter into URLRequest
public struct Header: RequestParameter {
    private let key: String
    private let value: String?
    
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
    
    public func buildParameter(_ request: inout URLRequest) {
        request.setValue(value, forHTTPHeaderField: key)
    }
}

// MARK: - Helper functions
public extension Header {
    /// Specifies the media type the client is expecting and able to handle
    static func Accept(_ type: MediaType) -> RequestParameter {
        Header(key: "Accept", value: type.rawValue)
    }
    
    /// Authenticates the `Request` for HTTP authentication
    static func Authorization(_ auth: Auth) -> RequestParameter {
        Header(key: "Authorization", value: auth.value)
    }
    
    /// Specifies caching mechanisms for the `Request`
    static func CacheControl(_ cache: CacheType) -> RequestParameter {
        Header(key: "Cache-Control", value: cache.value)
    }
    /// The length of the `Body` in octets (8-bit bytes)
    /// - Parameter octets: Length in 8-bit bytes
    static func ContentLength(_ octets: Int) -> RequestParameter {
        Header(key: "Content-Length", value: "\(octets)")
    }
    /// The `MediaType` of the `Body`
    /// - Note: Used with `Method(.post)` and `Method(.put)`
    static func ContentType(_ type: MediaType) -> RequestParameter {
        Header(key: "Content-Type", value: type.rawValue)
    }
    
    /// Sets the user agent string
    static func UserAgent(_ userAgent: String) -> RequestParameter {
        Header(key: "User-Agent", value: userAgent)
    }
    
    /// The domain name of the server (for virtual hosting), and optionally, the port.
    static func Host(_ host: String, port: String = "") -> RequestParameter {
        Header(key: "Host", value: host + port)
    }
    
    /// Construct custom header with given key and value
    /// - Parameters:
    ///   - key: header key
    ///   - value: header value
    /// - Returns: Request parameter
    static func Custom(_ key: String, value: String) -> RequestParameter {
        Header(key: key, value: value)
    }
}
