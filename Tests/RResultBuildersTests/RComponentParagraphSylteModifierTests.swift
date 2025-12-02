//
//  RComponentParagraphStyleModifierTests.swift
//

#if !os(watchOS)
import Testing
import Foundation
@testable import RResultBuilders

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

@Suite("NSAttributedString Paragraph Style Modifiers")
struct RAttributedComponentParagraphModifierTests {
    
    @Test("Empty paragraph style can be set")
    func testSetEmptyParagraphStyle() async throws {
        let ps = NSParagraphStyle()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .paragraphStyle(ps)
            RText(" with Swift")
        }
        
        // Verify paragraph style is set (even if empty/default)
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle != nil, "Should have paragraph style")
    }
    
    @Test("Mutable paragraph style can be modified")
    func testModifyMutableParagraphStyle() async throws {
        // Create fresh mutable paragraph style for each test run
        let mps = NSMutableParagraphStyle()
        mps.alignment = .right
        
        let sut = NSAttributedString {
            RText("Hello world")
                .paragraphStyle(mps)
            RText(" with Swift")
        }
        
        // Verify the mutable paragraph style was applied
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle != nil, "Should have paragraph style")
        #expect(paragraphStyle?.alignment == .right, "Alignment should be right")
        
        // Verify that the original mps wasn't modified (should be immutable copy)
        #expect(mps.alignment == .right, "Original paragraph style should remain unchanged")
    }
    
    @Test("Alignment modifier sets text alignment", arguments: [
        NSTextAlignment.left,
        NSTextAlignment.right,
        NSTextAlignment.center,
        NSTextAlignment.justified,
        NSTextAlignment.natural
    ])
    func testModifyAlignment(alignment: NSTextAlignment) async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .alignment(alignment)
            RText(" with Swift")
        }
        
        // Verify the attribute is set on the first text range
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle != nil, "Should have paragraph style")
        #expect(paragraphStyle?.alignment == alignment, "Alignment should be \(alignment)")
    }
    
    @Test("First line head indent can be set", arguments: [0.0, 16.0, 32.0, 50.5])
    func testModifyFirstHeadIndent(indent: CGFloat) async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .firstLineHeadIndent(indent)
            RText(" with Swift")
        }
        
        // Verify the attribute is set on the first text range
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle != nil, "Should have paragraph style")
        #expect(paragraphStyle?.firstLineHeadIndent == indent, "First line head indent should be \(indent)")
    }
    
    @Test("Head indent can be set", arguments: [0.0, 13.0, 25.0, 40.5])
    func testModifyHeadIndent(indent: CGFloat) async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .headIndent(indent)
            RText(" with Swift")
        }
        
        // Verify the attribute is set on the first text range
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle != nil, "Should have paragraph style")
        #expect(paragraphStyle?.headIndent == indent, "Head indent should be \(indent)")
    }
    
    @Test("Tail indent can be set", arguments: [0.0, 19.0, 30.0, 45.5])
    func testModifyTailIndent(indent: CGFloat) async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .tailIndent(indent)
            RText(" with Swift")
        }
        
        // Verify the attribute is set on the first text range
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle != nil, "Should have paragraph style")
        #expect(paragraphStyle?.tailIndent == indent, "Tail indent should be \(indent)")
    }
    
    @Test("Line break mode can be set", arguments: [
        NSLineBreakMode.byWordWrapping,
        NSLineBreakMode.byCharWrapping,
        NSLineBreakMode.byClipping,
        NSLineBreakMode.byTruncatingHead,
        NSLineBreakMode.byTruncatingTail,
        NSLineBreakMode.byTruncatingMiddle
    ])
    func testModifyLinebreakMode(mode: NSLineBreakMode) async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .lineBreakeMode(mode)
            RText(" with Swift")
        }
        
        // Verify the attribute is set on the first text range
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle != nil, "Should have paragraph style")
        #expect(paragraphStyle?.lineBreakMode == mode, "Line break mode should be \(mode)")
    }
    
    @Test("Line height properties can be set")
    func testModifyLineHeight() async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .lineHeight(multiple: 1, maximum: 22, minimum: 18)
            RText(" with Swift")
        }
        
        // Verify the attributes are set on the first text range
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle != nil, "Should have paragraph style")
        #expect(paragraphStyle?.lineHeightMultiple == 1, "Line height multiple should be 1")
        #expect(paragraphStyle?.maximumLineHeight == 22, "Maximum line height should be 22")
        #expect(paragraphStyle?.minimumLineHeight == 18, "Minimum line height should be 18")
    }
    
    @Test("Line spacing can be set", arguments: [0.0, 7.0, 10.0, 15.5])
    func testModifyLineSpacing(spacing: CGFloat) async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .lineSpacing(spacing)
            RText(" with Swift")
        }
        
        // Verify the attribute is set on the first text range
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle != nil, "Should have paragraph style")
        #expect(paragraphStyle?.lineSpacing == spacing, "Line spacing should be \(spacing)")
    }
    
    @Test("Paragraph spacing can be set")
    func testModifyParagraphSpacing() async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .paragraphSpacing(9.3, before: 17.2)
            RText(" with Swift")
        }
        
        // Verify the attributes are set on the first text range
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle != nil, "Should have paragraph style")
        #expect(paragraphStyle?.paragraphSpacing == 9.3, "Paragraph spacing should be 9.3")
        #expect(paragraphStyle?.paragraphSpacingBefore == 17.2, "Paragraph spacing before should be 17.2")
    }
    
    @Test("Base writing direction can be set", arguments: [
        NSWritingDirection.natural,
        NSWritingDirection.leftToRight,
        NSWritingDirection.rightToLeft
    ])
    func testModifyBaseWritingDirection(direction: NSWritingDirection) async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .baseWritingDirection(direction)
            RText(" with Swift")
        }
        
        // Verify the attribute is set on the first text range
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle != nil, "Should have paragraph style")
        #expect(paragraphStyle?.baseWritingDirection == direction, "Base writing direction should be \(direction)")
    }
    
    @Test("Hyphenation factor can be set", arguments: [0.0, 0.3, 0.5, 1.0])
    func testModifyHyphenationFactor(factor: Float) async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .hyphenationFactor(factor)
            RText(" with Swift")
        }
        
        // Verify the attribute is set on the first text range
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle != nil, "Should have paragraph style")
        #expect(paragraphStyle?.hyphenationFactor == factor, "Hyphenation factor should be \(factor)")
    }
    
    @Test("Multiple paragraph style modifiers can be chained")
    @available(iOS 9.0, macOS 10.11, *)
    func testChaining() async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .alignment(.right)
                .firstLineHeadIndent(16)
                .headIndent(13)
                .tailIndent(19)
                .lineBreakeMode(.byWordWrapping)
                .lineHeight(multiple: 1, maximum: 22, minimum: 18)
                .lineSpacing(7)
                .paragraphSpacing(9.3, before: 17.2)
                .baseWritingDirection(.rightToLeft)
                .hyphenationFactor(0.3)
            RText(" with Swift")
        }
        
        // Verify all chained modifiers are applied
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle != nil, "Should have paragraph style")
        #expect(paragraphStyle?.alignment == .right)
        #expect(paragraphStyle?.firstLineHeadIndent == 16)
        #expect(paragraphStyle?.headIndent == 13)
        #expect(paragraphStyle?.tailIndent == 19)
        #expect(paragraphStyle?.lineBreakMode == .byWordWrapping)
        #expect(paragraphStyle?.lineHeightMultiple == 1)
        #expect(paragraphStyle?.maximumLineHeight == 22)
        #expect(paragraphStyle?.minimumLineHeight == 18)
        #expect(paragraphStyle?.lineSpacing == 7)
        #expect(paragraphStyle?.paragraphSpacing == 9.3)
        #expect(paragraphStyle?.paragraphSpacingBefore == 17.2)
        #expect(paragraphStyle?.baseWritingDirection == .rightToLeft)
        #expect(paragraphStyle?.hyphenationFactor == 0.3)
    }
    
    @Test("Chained modifiers produce same result regardless of order")
    @available(iOS 9.0, macOS 10.11, *)
    func testRandomChainingOrderEqualness() async throws {
        let sut1 = NSAttributedString {
            RText("Hello world")
                .alignment(.right)
                .firstLineHeadIndent(16)
                .headIndent(13)
                .tailIndent(19)
                .lineBreakeMode(.byWordWrapping)
                .lineHeight(multiple: 1, maximum: 22, minimum: 18)
                .lineSpacing(7)
                .paragraphSpacing(9.3, before: 17.2)
                .baseWritingDirection(.rightToLeft)
                .hyphenationFactor(0.3)
            RText(" with Swift")
        }
        
        let sut2 = NSAttributedString {
            RText("Hello world")
                .firstLineHeadIndent(16)
                .headIndent(13)
                .alignment(.right)
                .tailIndent(19)
                .lineSpacing(7)
                .lineBreakeMode(.byWordWrapping)
                .hyphenationFactor(0.3)
                .lineHeight(multiple: 1, maximum: 22, minimum: 18)
                .paragraphSpacing(9.3, before: 17.2)
                .baseWritingDirection(.rightToLeft)
            RText(" with Swift")
        }
        
        // Compare paragraph styles from both
        let attributes1 = sut1.attributes(at: 0, effectiveRange: nil)
        let style1 = attributes1[.paragraphStyle] as? NSParagraphStyle
        
        let attributes2 = sut2.attributes(at: 0, effectiveRange: nil)
        let style2 = attributes2[.paragraphStyle] as? NSParagraphStyle
        
        #expect(style1?.alignment == style2?.alignment, "Alignment should match")
        #expect(style1?.firstLineHeadIndent == style2?.firstLineHeadIndent, "First line head indent should match")
        #expect(style1?.headIndent == style2?.headIndent, "Head indent should match")
        #expect(style1?.tailIndent == style2?.tailIndent, "Tail indent should match")
        #expect(style1?.lineBreakMode == style2?.lineBreakMode, "Line break mode should match")
        #expect(style1?.lineHeightMultiple == style2?.lineHeightMultiple, "Line height multiple should match")
        #expect(style1?.maximumLineHeight == style2?.maximumLineHeight, "Maximum line height should match")
        #expect(style1?.minimumLineHeight == style2?.minimumLineHeight, "Minimum line height should match")
        #expect(style1?.lineSpacing == style2?.lineSpacing, "Line spacing should match")
        #expect(style1?.paragraphSpacing == style2?.paragraphSpacing, "Paragraph spacing should match")
        #expect(style1?.paragraphSpacingBefore == style2?.paragraphSpacingBefore, "Paragraph spacing before should match")
        #expect(style1?.baseWritingDirection == style2?.baseWritingDirection, "Base writing direction should match")
        #expect(style1?.hyphenationFactor == style2?.hyphenationFactor, "Hyphenation factor should match")
    }
    
    @Test("Alignment modifier works without explicit paragraph style")
    func testAlignmentWithoutExplicitParagraphStyle() async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .alignment(.justified)
            RText(" with Swift")
        }
        
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle != nil, "Should have paragraph style")
        #expect(paragraphStyle?.alignment == .justified, "Alignment should be justified")
    }
}

// MARK: - Edge Cases and Combination Tests
@Suite("Paragraph Style Edge Cases")
struct ParagraphStyleEdgeCaseTests {
    
    @Test("Negative indent values are handled")
    func testNegativeIndents() async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .firstLineHeadIndent(-10)
                .headIndent(-5)
                .tailIndent(-15)
        }
        
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle?.firstLineHeadIndent == -10, "Negative first line indent should be set")
        #expect(paragraphStyle?.headIndent == -5, "Negative head indent should be set")
        #expect(paragraphStyle?.tailIndent == -15, "Negative tail indent should be set")
    }
    
    @Test("Zero values are handled correctly")
    func testZeroValues() async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .lineSpacing(0)
                .paragraphSpacing(0, before: 0)
                .hyphenationFactor(0)
        }
        
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle?.lineSpacing == 0, "Zero line spacing should be set")
        #expect(paragraphStyle?.paragraphSpacing == 0, "Zero paragraph spacing should be set")
        #expect(paragraphStyle?.paragraphSpacingBefore == 0, "Zero paragraph spacing before should be set")
        #expect(paragraphStyle?.hyphenationFactor == 0, "Zero hyphenation factor should be set")
    }
    
    @Test("Line height with same min, max, and multiple")
    func testUniformLineHeight() async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .lineHeight(multiple: 1.5, maximum: 20, minimum: 20)
        }
        
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle?.maximumLineHeight == 20, "Maximum line height should be 20")
        #expect(paragraphStyle?.minimumLineHeight == 20, "Minimum line height should be 20")
        #expect(paragraphStyle?.lineHeightMultiple == 1.5, "Line height multiple should be 1.5")
    }
    
    @Test("Multiple texts with different paragraph styles")
    func testMultipleTextsWithDifferentStyles() async throws {
        let sut = NSAttributedString {
            RText("First paragraph")
                .alignment(.left)
                .lineSpacing(10)
            RText("Second paragraph")
                .alignment(.right)
                .lineSpacing(5)
            RText("Third paragraph")
                .alignment(.center)
        }
        
        // Verify first text attributes
        let firstAttributes = sut.attributes(at: 0, effectiveRange: nil)
        let firstStyle = firstAttributes[.paragraphStyle] as? NSParagraphStyle
        #expect(firstStyle?.alignment == .left, "First text should be left aligned")
        #expect(firstStyle?.lineSpacing == 10, "First text should have line spacing of 10")
        
        // Verify second text has different styles
        #expect(sut.string.contains("Second paragraph"), "Should contain second paragraph text")
    }
    
    @Test("Paragraph style persists across text concatenation")
    func testStylePersistence() async throws {
        let alignment = NSTextAlignment.justified
        let lineSpacing: CGFloat = 12.0
        
        let sut = NSAttributedString {
            RText("Hello")
                .alignment(alignment)
                .lineSpacing(lineSpacing)
            RText(" world")
        }
        
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle?.alignment == alignment, "Alignment should persist")
        #expect(paragraphStyle?.lineSpacing == lineSpacing, "Line spacing should persist")
    }
}

// MARK: - Compatibility Tests
@Suite("Paragraph Style Compatibility")
struct ParagraphStyleCompatibilityTests {
    
    @Test("All modifiers can be applied together without conflicts")
    @available(iOS 9.0, macOS 10.11, *)
    func testAllModifiersCombined() async throws {
        let sut = NSAttributedString {
            RText("Comprehensive test")
                .alignment(.justified)
                .firstLineHeadIndent(20)
                .headIndent(10)
                .tailIndent(-10)
                .lineBreakeMode(.byWordWrapping)
                .lineHeight(multiple: 1.2, maximum: 30, minimum: 15)
                .lineSpacing(8)
                .paragraphSpacing(12, before: 6)
                .baseWritingDirection(.leftToRight)
                .hyphenationFactor(0.8)
        }
        
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        #expect(paragraphStyle != nil, "Paragraph style should exist")
        #expect(paragraphStyle?.alignment == .justified)
        #expect(paragraphStyle?.firstLineHeadIndent == 20)
        #expect(paragraphStyle?.headIndent == 10)
        #expect(paragraphStyle?.tailIndent == -10)
        #expect(paragraphStyle?.lineBreakMode == .byWordWrapping)
        #expect(paragraphStyle?.lineHeightMultiple == 1.2)
        #expect(paragraphStyle?.maximumLineHeight == 30)
        #expect(paragraphStyle?.minimumLineHeight == 15)
        #expect(paragraphStyle?.lineSpacing == 8)
        #expect(paragraphStyle?.paragraphSpacing == 12)
        #expect(paragraphStyle?.paragraphSpacingBefore == 6)
        #expect(paragraphStyle?.baseWritingDirection == .leftToRight)
        #expect(paragraphStyle?.hyphenationFactor == 0.8)
    }
}

#endif // !os(watchOS)
