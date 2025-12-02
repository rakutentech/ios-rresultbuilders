//
//  RRequestBuilder.swift
//
//  Created by Pavan on 2021/08/27.
//

import Foundation

@resultBuilder
public struct RRequestBuilder {
    /// Required by every result builder to build combined results from
    /// statement blocks.
    public static func buildBlock(_ params: RequestParameter...) -> RequestParameter {
        CombinedParameters(params)
    }
    
    /// Required by every result builder to build combined results from
    /// statement blocks.
    public static func buildBlock(_ param: RequestParameter) -> RequestParameter {
        param
    }
    
    /// Required by every result builder to build combined results from
    /// statement blocks.
    public static func buildBlock() -> EmptyParameter {
        EmptyParameter()
    }
    
    /// Enables support for `if` statements that do not have an `else`.
    public static func buildOptional(_ param: RequestParameter?) -> RequestParameter {
        param ?? EmptyParameter()
    }
    
    /// With buildEither(second:), enables support for 'if-else' and 'switch'
    /// statements by folding conditional results into a single result.
    public static func buildEither(first: RequestParameter) -> RequestParameter {
        first
    }
    
    /// With buildEither(second:), enables support for 'if-else' and 'switch'
    /// statements by folding conditional results into a single result.
    public static func buildEither(second: RequestParameter) -> RequestParameter {
        second
    }
    
    /// Enables support for 'for..in' loops by combining the
    /// results of all iterations into a single result.
    public static func buildArray(_ params: [RequestParameter]) -> RequestParameter {
        CombinedParameters(params)
    }
}

