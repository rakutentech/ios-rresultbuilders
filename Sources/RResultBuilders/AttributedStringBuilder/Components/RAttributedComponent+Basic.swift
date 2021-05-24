//
//  RAttributedComponent+Basic.swift
//  RResultBuilders
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public enum Ligature: Int {
    case none = 0
    case `default` = 1
    
    #if canImport(AppKit)
    case all = 2 // Value 2 is unsupported on iOS
    #endif
}

// MARK: - Helpers
extension RAttributedComponent {
    var allAttributes: RAttributes {
        let attributedString = self.attributedString
        return attributedString.attributes(at: 0,
                                           longestEffectiveRange: nil,
                                           in: NSRange(location: 0, length: attributedString.length))
    }
    
    /// Convenience method to apply attribute by  given key, value directly to component
    /// - Parameters:
    ///   - key: NSAttributedString.Key
    ///   - value: attributed value
    ///   - range: optional range if specified then it applies to that range else applies to whole component
    /// - Returns: new  attributed component
    /// - warning: It's recommened to use one of the factory method instead of this just to ensure type safety of values
    public func apply(_ key: NSAttributedString.Key, value: Any, range: NSRange? = nil) -> RAttributedComponent {
        return apply([key: value], range: range)
    }
    
    
    /// Convenience method to apply set of attributes directly to component
    /// - Parameters:
    ///   - newAttributes: attributes
    ///   - range: optional range if specified then it applies to that range else applies to whole component
    /// - Returns: new  attributed component
    /// - warning: It's recommened to use one of the factory method instead of this just to ensure type safety of values
    public func apply(_ newAttributes: RAttributes, range: NSRange? = nil) -> RAttributedComponent {
        let mas = NSMutableAttributedString(attributedString: attributedString)
        let applyRange = range ?? NSMakeRange(0, mas.length)
        mas.addAttributes(newAttributes, range: applyRange)
        
        return RText(mas)
    }    
}


// MARK: - Basic modifiers
// NOTE: You can extend this based on needss
extension RAttributedComponent {
    
    public func font(_ font: RFont, range: NSRange? = nil) -> RAttributedComponent {
        apply([.font: font], range: range)
    }
    
    public func foregroundColor(_ color: RColor, range: NSRange? = nil) -> RAttributedComponent {
        apply([.foregroundColor: color], range: range)
    }
    
    public func backgroundColor(_ color: RColor, range: NSRange? = nil) -> RAttributedComponent {
        apply([.backgroundColor: color], range: range)
    }
    
    public func baselineOffset(_ baselineOffset: CGFloat, range: NSRange? = nil) -> RAttributedComponent {
        apply([.baselineOffset: baselineOffset])
    }
    
    public func expansion(_ expansion: CGFloat, range: NSRange? = nil) -> RAttributedComponent {
        apply([.expansion: expansion], range: range)
    }
    
    public func kerning(_ kern: CGFloat, range: NSRange? = nil) -> RAttributedComponent {
        apply([.kern: kern], range: range)
    }
    
    public func ligature(_ ligature: Ligature, range: NSRange? = nil) -> RAttributedComponent {
        apply([.ligature: ligature.rawValue], range: range)
    }
    
    public func obliqueness(_ obliqueness: Float, range: NSRange? = nil) -> RAttributedComponent {        
        apply([.obliqueness: obliqueness], range: range)
    }
    
    public func strikethrough(_ style: NSUnderlineStyle, color: RColor? = nil, range: NSRange? = nil) -> RAttributedComponent {
        if let color = color {
            return apply([.strikethroughStyle: style.rawValue,
                          .strikethroughColor: color])
        }
        return apply([.strikethroughStyle: style.rawValue], range: range)
    }
    
    public func stroke(width: CGFloat, color: RColor? = nil, range: NSRange? = nil) -> RAttributedComponent {
        if let color = color {
            return apply([.strokeWidth: width,
                          .strokeColor: color])
        }
        return apply([.strokeWidth: width], range: range)
    }
    
    public func underline(_ style: NSUnderlineStyle, color: RColor? = nil, range: NSRange? = nil) -> RAttributedComponent {
        if let color = color {
            return apply([.underlineStyle: style.rawValue,
                          .underlineColor: color])
        }
        return apply([.underlineStyle: style.rawValue], range: range)
    }
    
    public func shadow(color: RColor? = nil, radius: CGFloat, x: CGFloat = 0, y: CGFloat = 0, range: NSRange? = nil) -> RAttributedComponent {
        let shadow = NSShadow()
        shadow.shadowColor = color
        shadow.shadowBlurRadius = radius
        shadow.shadowOffset = .init(width: x, height: y)
        return apply([.shadow: shadow], range: range)
    }
    
    public func textEffect(_ textEffect: NSAttributedString.TextEffectStyle, range: NSRange? = nil) -> RAttributedComponent {        
        return apply([.textEffect: textEffect], range: range)
    }
    
    public func writingDirection(_ writingDirection: NSWritingDirection, range: NSRange? = nil) -> RAttributedComponent {
        return apply([.writingDirection: writingDirection.rawValue], range: range)
    }
    
    #if canImport(AppKit)
    public func vertical(range: NSRange? = nil) -> RAttributedComponent {
        return apply([.verticalGlyphForm: 1], range: range)        
    }
    #endif
}
