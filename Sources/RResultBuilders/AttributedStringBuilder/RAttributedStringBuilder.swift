//
//  NSAttributedStringBuilder.swift
//  RResultBuilders
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// RAttributedStringBuilder is `resultBuilder` which helps in building attributed strings in declarative way
@resultBuilder
public struct RAttributedStringBuilder {
    /// Required by every result builder to build combined results from
    /// statement blocks.
    public static func buildBlock(_ components: RAttributedComponent...) -> RAttributedComponent {
        let result = components.reduce(into: NSMutableAttributedString()) { $0.append($1.attributedString) }
        return RText(result)
    }
    
    /// If declared, provides contextual type information for statement
    /// expressions to translate them into partial results.
    public static func buildExpression(_ expression: RAttributedComponent) -> RAttributedComponent {
        return expression
    }
    
    /// If declared, provides contextual type information for statement
    /// expressions to translate them into partial results.
    #if !os(watchOS)    
    public static func buildExpression(_ expression: RImage) -> RAttributedComponent {
        return RImageAttachment(image: expression)
    }
    #endif
    
    /// With buildEither(second:), enables support for 'if-else' and 'switch'
    /// statements by folding conditional results into a single result.
    ///
    ///
    /// NOTE: If there is condition block in DSL body then output of `buildBlock{}` will be input to these methods,  hence type matching is mandatory beween `buildBlock.output -> buildEither.input`
    public static func buildEither(first: RAttributedComponent) -> RAttributedComponent {
        return first
    }
    
    /// With buildEither(second:), enables support for 'if-else' and 'switch'
    /// statements by folding conditional results into a single result.
    public static func buildEither(second: RAttributedComponent) -> RAttributedComponent {
        return second
    }
    
    /// Enables support for `if` statements that do not have an `else`.
    public static func buildOptional(_ component: RAttributedComponent?) -> RAttributedComponent {
        return component ?? REmpty()
    }
    
    /// Enables support for `for..in` loop
    public static func buildArray(_ components: [RAttributedComponent]) -> RAttributedComponent {
        let result = components.reduce(into: NSMutableAttributedString()) { $0.append($1.attributedString) }
        return RText(result)
    }
}

// MARK: - NSAttributedString
public extension NSAttributedString {
    /// Convenience initializer build attributed string
    /// - Parameter build: building closure to construct attriibuted string
    convenience init(@RAttributedStringBuilder _ build: () -> RAttributedComponent)  {
        let builtComponent = build()
        self.init(attributedString: builtComponent.attributedString)
    }
}



