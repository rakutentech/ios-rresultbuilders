//
//  RAttributedComponent+Paragraph.swift
//  RResultBuilders
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Paragraph Style Modifiers

extension RAttributedComponent {
    public func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> RAttributedComponent {
        return apply([.paragraphStyle: paragraphStyle])
    }
    
    public func paragraphStyle(_ paragraphStyle: NSMutableParagraphStyle) -> RAttributedComponent {
        return apply([.paragraphStyle: paragraphStyle])
    }
    
    private func mutableParagraphStyle() -> NSMutableParagraphStyle {
        let currentAttributes = allAttributes
        if let mps = currentAttributes[.paragraphStyle] as? NSMutableParagraphStyle {
            return mps
        } else if let ps = currentAttributes[.paragraphStyle] as? NSParagraphStyle,
            let mps = ps.mutableCopy() as? NSMutableParagraphStyle {
            return mps
        }
        return NSMutableParagraphStyle()
    }
    
    public func alignment(_ alignment: NSTextAlignment) -> RAttributedComponent {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle.alignment = alignment
        return self.paragraphStyle(paragraphStyle)
    }
    
    public func firstLineHeadIndent(_ indent: CGFloat) -> RAttributedComponent {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = indent
        return self.paragraphStyle(paragraphStyle)
    }

    public func headIndent(_ indent: CGFloat) -> RAttributedComponent {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle.headIndent = indent
        return self.paragraphStyle(paragraphStyle)
    }
    
    public func tailIndent(_ indent: CGFloat) -> RAttributedComponent {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle.tailIndent = indent
        return self.paragraphStyle(paragraphStyle)
    }
        
    public func lineBreakeMode(_ lineBreakMode: NSLineBreakMode) -> RAttributedComponent {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        return self.paragraphStyle(paragraphStyle)
    }
    
    public func lineHeight(multiple: CGFloat = 0, maximum: CGFloat = 0, minimum: CGFloat) -> RAttributedComponent {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = multiple
        paragraphStyle.maximumLineHeight = maximum
        paragraphStyle.minimumLineHeight = minimum
        return self.paragraphStyle(paragraphStyle)
    }
    
    public func lineSpacing(_ spacing: CGFloat) -> RAttributedComponent {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        return self.paragraphStyle(paragraphStyle)
    }
    
    public func paragraphSpacing(_ spacing: CGFloat, before: CGFloat = 0) -> RAttributedComponent  {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle.paragraphSpacing = spacing
        paragraphStyle.paragraphSpacingBefore = before
        return self.paragraphStyle(paragraphStyle)
    }
    
    public func baseWritingDirection(_ baseWritingDirection: NSWritingDirection) -> RAttributedComponent {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle.baseWritingDirection = baseWritingDirection
        return self.paragraphStyle(paragraphStyle)
    }
    
    public func hyphenationFactor(_ hyphenationFactor: Float) -> RAttributedComponent {
        let paragraphStyle = mutableParagraphStyle()
        paragraphStyle.hyphenationFactor = hyphenationFactor
        return self.paragraphStyle(paragraphStyle)
    }
}

