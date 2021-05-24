//
//  RAlertActionBuilder.swift
//  RResultBuilders
//

#if os(iOS)
import UIKit

/// RAlertControllerBuilder is `resultBuilder` which helps in building alert/action sheet in declarative way
@resultBuilder
public struct RAlertControllerBuilder {
    public typealias Component = [RAlertAction]
    
    /// Required by every result builder to build combined results from
    /// statement blocks.
    public static func buildBlock(_ components: Component...) -> Component {
        return components.flatMap { $0 }
    }
        
    /// If declared, provides contextual type information for statement
    /// expressions to translate them into partial results.
    public static func buildExpression(_ expression: RAlertAction) -> Component {
        return [expression]
    }
    
    /// With buildEither(second:), enables support for 'if-else' and 'switch'
    /// statements by folding conditional results into a single result.
    ///
    ///
    /// NOTE: If there is condition block in DSL body then output of `buildBlock{}` will be input to these methods,  hence type matching is mandatory beween `buildBlock.output -> buildEither.input`
    public static func buildEither(first: Component) -> Component {
        return first
    }

    /// With buildEither(second:), enables support for 'if-else' and 'switch'
    /// statements by folding conditional results into a single result.
    public static func buildEither(second: Component) -> Component {
        return second
    }
    
    /// Enables support for `if` statements that do not have an `else`.    
    public static func buildOptional(_ component: Component?) -> Component {
        return component ?? []
    }
    
    /// Enables support for `for..in` loop
    public static func buildArray(_ components: [Component]) -> Component {
        return components.flatMap { $0 }
    }
}

// MARK: - UIAlertController

public extension UIAlertController {
    convenience init(title: String,
                     message: String,
                     style: UIAlertController.Style = .alert,
                     @RAlertControllerBuilder build: () -> [RAlertAction]) {
        self.init(title: title, message: message, preferredStyle: style)
        
        let components = build()
        components.forEach { action in
            let action = UIAlertAction(title: action.title, style: action.style) { _ in
                action.action()
            }
            
            self.addAction(action)
        }
    }
}
#endif
