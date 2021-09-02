import Foundation

@resultBuilder
public struct RURLBuilder {
    /// Required by every result builder to build combined results from
    /// statement blocks.
    public static func buildBlock(_ components: RURLComponent...) -> RURLComponent {
        return resolveComponents(components)
    }
    
    /// If declared, provides contextual type information for statement
    /// expressions to translate them into partial results.
    public static func buildExpression(_ expression: RURLComponent) -> RURLComponent {
        return expression
    }
    
    public static func buildExpression(_ staticString: StaticString) -> URL? {
        return URL(string: "\(staticString)")
    }
    
    /// Enables support for `if` statements that do not have an `else`.
    public static func buildOptional(_ component: RURLComponent?) -> RURLComponent {
        return component ?? RURLComponent()
    }
    
    /// With buildEither(second:), enables support for 'if-else' and 'switch'
    /// statements by folding conditional results into a single result.
    public static func buildEither(first: RURLComponent) -> RURLComponent {
        return first
    }
    
    /// With buildEither(second:), enables support for 'if-else' and 'switch'
    /// statements by folding conditional results into a single result.
    public static func buildEither(second: RURLComponent) -> RURLComponent {
        return second
    }
    
    /// Enables support for 'for..in' loops by combining the
    /// results of all iterations into a single result.
    public static func buildArray(_ components: [RURLComponent]) -> RURLComponent {        
        return resolveComponents(components)
    }
    
    private static func resolveComponents(_ components: [RURLComponent]) -> RURLComponent {
        var urlComponents = URLComponents()
        
        for component in components {
            if let scheme = component.components.scheme {
                urlComponents.scheme = scheme
            }
            
            if let host = component.components.host {
                urlComponents.host = host
            }
            
            if !component.components.path.isEmpty {
                urlComponents.path += component.components.path
            }
            
            if let queryItems = component.components.queryItems, !queryItems.isEmpty {
                urlComponents.queryItems = queryItems
            }
        }
        
        return RURLComponent(components: urlComponents)
    }
}

// MARK: - URL
public extension URL {
    /// Custom initializer that constructs URL using result builder
    init?(@RURLBuilder _ build: () -> RURLComponent) {
        //Get URL from components here
        let builtComponent = build()
        if let url = builtComponent.components.url {
            self = url
        } else {
            return nil
        }
    }
}
