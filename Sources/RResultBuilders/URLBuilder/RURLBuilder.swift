import Foundation

@resultBuilder
public struct RURLBuilder {
    /// Required by every result builder to build combined results from
    /// statement blocks.
    public static func buildBlock(_ components: URLComponent...) -> URLComponent {
        CombinedComponent(components)
    }
    
    /// If declared, provides contextual type information for statement
    /// expressions to translate them into partial results.
    public static func buildExpression(_ expression: URLComponent) -> URLComponent {
        expression
    }
    
    public static func buildExpression(_ staticString: StaticString) -> URL? {
        return URL(string: "\(staticString)")
    }
    
    /// Enables support for `if` statements that do not have an `else`.
    public static func buildOptional(_ component: URLComponent?) -> URLComponent {
        component ?? EmptyComponent()
    }
    
    /// With buildEither(second:), enables support for 'if-else' and 'switch'
    /// statements by folding conditional results into a single result.
    public static func buildEither(first: URLComponent) -> URLComponent {
        first
    }
    
    /// With buildEither(second:), enables support for 'if-else' and 'switch'
    /// statements by folding conditional results into a single result.
    public static func buildEither(second: URLComponent) -> URLComponent {
        second
    }
    
    /// Enables support for 'for..in' loops by combining the
    /// results of all iterations into a single result.
    public static func buildArray(_ components: [URLComponent]) -> URLComponent {
        CombinedComponent(components)
    }
}

// MARK: - URL
public extension URL {
    /// Custom initializer that constructs URL using result builder
    init?(@RURLBuilder _ build: () -> URLComponent) {
        //Get URL from components here
        let combinedComponent = build()
        var urlComponents = URLComponents()
        combinedComponent.build(&urlComponents)
        
        if let url = urlComponents.url {
            self = url
        } else {
            return nil
        }
    }
}
