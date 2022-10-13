//
//  RAttributedString.swift
//  RResultBuilders
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Common modifiers

/// - warning: These modifiers will be affected to all child if does not exist, suppose if child has exisiting attribute then that takes priority over this.
extension NSAttributedString {
    func applyAtrributesIfNotExist(_ newAtrributes: RAttributes, range: NSRange? = nil) -> NSAttributedString {
        let mas = NSMutableAttributedString(attributedString: self)
        let resolvedRange = range ?? NSRange(location: 0, length: mas.length)
        
        // Convert into mutable attributed string and apply base modifiers if it does not exist in each attribute with range
        mas.enumerateAttributes(in: resolvedRange) { (attributes, range, stopEnumerating) in
            var copiedAttributes = attributes
            for (k, v) in newAtrributes {
                if copiedAttributes[k] == nil {
                    copiedAttributes[k] = v
                }
            }
            
            // Replace by new attributes
            mas.setAttributes(copiedAttributes, range: range)
        }
        
        return mas
    }
    
    public func font(_ font: RFont) -> NSAttributedString {
        return applyAtrributesIfNotExist([.font: font])
    }
    
    public func foregroundColor(_ color: RColor) -> NSAttributedString {
        return applyAtrributesIfNotExist([.foregroundColor: color])
    }
}

