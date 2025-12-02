//
//  RComponentBasicModifierTests.swift
//
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

@Suite("NSAttributedString Basic Modifiers")
struct RComponentBasicModifierTests {
    
    @Test("Single foreground color attribute can be applied")
    func testModifyWithSingleAttribute() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.foregroundColor: RColor.yellow])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .foregroundColor(RColor.yellow)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Foreground color should be applied correctly")
    }
    
    @Test("Background color can be modified", arguments: [
        RColor.red,
        RColor.blue,
        RColor.green,
        RColor.yellow
    ])
    func testModifyBackgroundColor(color: RColor) async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.backgroundColor: color])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .backgroundColor(color)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Background color should be applied correctly")
    }
    
    @Test("Baseline offset can be modified", arguments: [0, 5, 10, -5, -10])
    func testModifyBaselineOffset(offset: CGFloat) async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.baselineOffset: offset])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .baselineOffset(offset)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Baseline offset of \(offset) should be applied correctly")
    }
    
    @Test("Font and color can be modified together")
    func testModifyFontAndColor() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "")
            mas.append(NSAttributedString(string: "Hello world",
                                          attributes: [
                                            .font: RFont.systemFont(ofSize: 20),
                                            .foregroundColor: RColor.yellow]))
            mas.append(NSAttributedString(string: "\n"))
            mas.append(NSAttributedString(string: "Second line",
                                          attributes: [.font: RFont.systemFont(ofSize: 24)]))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .font(.systemFont(ofSize: 20))
                .foregroundColor(.yellow)
            RLineBreak()
            RText("Second line")
                .font(.systemFont(ofSize: 24))
        }
        
        #expect(sut.isEqual(to: testData), "Font and color should be applied correctly")
    }
    
    @Test("Expansion can be modified", arguments: [0.0, 0.5, 1.0, -0.5])
    func testModifyExpansion(expansion: CGFloat) async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.expansion: expansion])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .expansion(expansion)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Expansion of \(expansion) should be applied correctly")
    }
    
    @Test("Kerning can be modified", arguments: [0, 1, 3, 5, -2])
    func testModifyKerning(kerning: CGFloat) async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.kern: kerning])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .kerning(kerning)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Kerning of \(kerning) should be applied correctly")
    }
    
    @Test("Ligature can be disabled")
    func testModifyLigature() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.ligature: 0])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .ligature(.none)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Ligature should be disabled")
    }
    
    @Test("Obliqueness can be modified", arguments: [0.0, 0.5, 1.0, -0.5])
    func testModifyObliqueness(obliqueness: Float) async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.obliqueness: obliqueness])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .obliqueness(obliqueness)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Obliqueness of \(obliqueness) should be applied correctly")
    }
    
    @Test("Shadow can be applied")
    func testModifyShadow() async throws {
        let testData: NSAttributedString = {
            let shadow = NSShadow()
            shadow.shadowColor = RColor.black
            shadow.shadowBlurRadius = 10
            shadow.shadowOffset = .init(width: 4, height: 4)
            
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.shadow: shadow])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .shadow(color: .black, radius: 10, x: 4, y: 4)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Shadow should be applied correctly")
    }
    
    @Test("Strikethrough style can be applied", arguments: [
        NSUnderlineStyle.single,
        NSUnderlineStyle.double,
        NSUnderlineStyle.thick
    ])
    func testModifyStrikethrough(style: NSUnderlineStyle) async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.strikethroughStyle: style.rawValue])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .strikethrough(style)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Strikethrough style \(style) should be applied correctly")
    }
    
    @Test("Strikethrough with color can be applied")
    func testModifyStrikethroughWithColor() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.strikethroughStyle: NSUnderlineStyle.patternDash.rawValue,
                                                             .strikethroughColor: RColor.black])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .strikethrough(.patternDash, color: .black)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Strikethrough with color should be applied correctly")
    }
    
    @Test("Stroke width can be modified", arguments: [-3, -2, -1, 1, 2, 3])
    func testModifyStroke(width: CGFloat) async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.strokeWidth: width])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .stroke(width: width)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Stroke width of \(width) should be applied correctly")
    }
    
    @Test("Stroke with color can be applied")
    func testModifyStrokeWithColor() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.strokeWidth: -2,
                                                             .strokeColor: RColor.green])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .stroke(width: -2, color: .green)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Stroke with color should be applied correctly")
    }
    
    @Test("Text effect can be applied")
    func testModifyTextEffect() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.textEffect: NSAttributedString.TextEffectStyle.letterpressStyle])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .textEffect(.letterpressStyle)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Text effect should be applied correctly")
    }
    
    @Test("Underline style can be applied", arguments: [
        NSUnderlineStyle.single,
        NSUnderlineStyle.double,
        NSUnderlineStyle.thick,
        NSUnderlineStyle.patternDashDotDot
    ])
    func testModifyUnderline(style: NSUnderlineStyle) async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.underlineStyle: style.rawValue])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .underline(style)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Underline style \(style) should be applied correctly")
    }
    
    @Test("Underline with color can be applied")
    func testModifyUnderlineWithColor() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.underlineStyle: NSUnderlineStyle.patternDashDotDot.rawValue,
                                                             .underlineColor: RColor.cyan])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .underline(.patternDashDotDot, color: .cyan)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Underline with color should be applied correctly")
    }
    
    @Test("Writing direction can be modified", arguments: [
        NSWritingDirection.leftToRight,
        NSWritingDirection.rightToLeft
    ])
    func testModifyWritingDirection(direction: NSWritingDirection) async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.writingDirection: direction.rawValue])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .writingDirection(direction)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Writing direction should be applied correctly")
    }
    
    #if canImport(AppKit)
    @Test("Vertical glyph form can be applied")
    func testModifyVertical() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.verticalGlyphForm: 1])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .vertical()
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "Vertical glyph form should be applied correctly")
    }
    #endif
    
    @Test("All modifiers can be chained together")
    func testChaining() async throws {
        let testData: NSAttributedString = {
            let shadow = NSShadow()
            shadow.shadowColor = RColor.black
            shadow.shadowBlurRadius = 10
            shadow.shadowOffset = .init(width: 4, height: 4)
            
            let mas = NSMutableAttributedString(
                string: "Hello world",
                attributes: [.backgroundColor: RColor.red,
                             .baselineOffset: 10,
                             .font: RFont.systemFont(ofSize: 20),
                             .foregroundColor: RColor.yellow,
                             .expansion: 1,
                             .kern: 3,
                             .ligature: 0,
                             .obliqueness: 0.5,
                             .shadow: shadow,
                             .strikethroughStyle: NSUnderlineStyle.patternDash.rawValue,
                             .strikethroughColor: RColor.black,
                             .strokeWidth: -2,
                             .strokeColor: RColor.green,
                             .textEffect: NSAttributedString.TextEffectStyle.letterpressStyle,
                             .underlineStyle: NSUnderlineStyle.patternDashDotDot.rawValue,
                             .underlineColor: RColor.cyan,
                             .writingDirection: NSWritingDirection.rightToLeft.rawValue
                ])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .backgroundColor(.red)
                .baselineOffset(10)
                .font(.systemFont(ofSize: 20))
                .foregroundColor(.yellow)
                .expansion(1)
                .kerning(3)
                .ligature(.none)
                .obliqueness(0.5)
                .shadow(color: .black, radius: 10, x: 4, y: 4)
                .strikethrough(.patternDash, color: .black)
                .stroke(width: -2, color: .green)
                .textEffect(.letterpressStyle)
                .underline(.patternDashDotDot, color: .cyan)
                .writingDirection(.rightToLeft)
            RText(" with Swift")
        }
        
        #expect(sut.isEqual(to: testData), "All chained modifiers should be applied correctly")
    }
}

// MARK: - Edge Cases and Combinations
@Suite("Basic Modifiers Edge Cases")
struct BasicModifiersEdgeCaseTests {
    
    @Test("Zero values are handled correctly")
    func testZeroValues() async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .baselineOffset(0)
                .kerning(0)
                .expansion(0)
                .obliqueness(0)
        }
        
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        #expect(attributes[.baselineOffset] as? Int == 0, "Zero baseline offset should be set")
        #expect(attributes[.kern] as? Int == 0, "Zero kerning should be set")
        #expect(attributes[.expansion] as? Float == 0, "Zero expansion should be set")
        #expect(attributes[.obliqueness] as? Float == 0, "Zero obliqueness should be set")
    }
    
    @Test("Negative values are handled correctly")
    func testNegativeValues() async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .baselineOffset(-10)
                .kerning(-5)
                .expansion(-0.5)
                .obliqueness(-0.5)
                .stroke(width: -2)
        }
        
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        #expect(attributes[.baselineOffset] as? Int == -10, "Negative baseline offset should be set")
        #expect(attributes[.kern] as? Int == -5, "Negative kerning should be set")
        #expect(attributes[.expansion] as? Float == -0.5, "Negative expansion should be set")
        #expect(attributes[.obliqueness] as? Float == -0.5, "Negative obliqueness should be set")
        #expect(attributes[.strokeWidth] as? Int == -2, "Negative stroke width should be set")
    }
    
    @Test("Modifiers can be applied to empty text")
    func testModifiersOnEmptyText() async throws {
        let sut = NSAttributedString {
            RText("")
                .foregroundColor(.red)
                .font(.systemFont(ofSize: 16))
        }
        
        #expect(sut.string.isEmpty, "Text should be empty")
        #expect(sut.length == 0, "Length should be zero")
    }
    
    @Test("Different texts can have different modifiers")
    func testDifferentModifiersOnDifferentTexts() async throws {
        let sut = NSAttributedString {
            RText("Red text")
                .foregroundColor(.red)
                .font(.systemFont(ofSize: 20))
            RText("Blue text")
                .foregroundColor(.blue)
                .font(.systemFont(ofSize: 14))
            RText("Green text")
                .foregroundColor(.green)
                .font(.boldSystemFont(ofSize: 18))
        }
        
        // Verify first text
        let firstAttributes = sut.attributes(at: 0, effectiveRange: nil)
        #expect(firstAttributes[.foregroundColor] as? RColor == .red, "First text should be red")
        
        // Verify string contains all texts
        #expect(sut.string.contains("Red text"), "Should contain first text")
        #expect(sut.string.contains("Blue text"), "Should contain second text")
        #expect(sut.string.contains("Green text"), "Should contain third text")
    }
    
    @Test("Shadow with zero blur radius")
    func testShadowWithZeroBlur() async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .shadow(color: .black, radius: 0, x: 0, y: 0)
        }
        
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        let shadow = attributes[.shadow] as? NSShadow
        #expect(shadow != nil, "Shadow should be set")
        #expect(shadow?.shadowBlurRadius == 0, "Shadow blur radius should be zero")
    }
    
    @Test("Multiple color-based modifiers can coexist")
    func testMultipleColorModifiers() async throws {
        let sut = NSAttributedString {
            RText("Hello world")
                .foregroundColor(.red)
                .backgroundColor(.yellow)
                .underline(.single, color: .blue)
                .strikethrough(.single, color: .green)
                .stroke(width: 1, color: .purple)
        }
        
        let attributes = sut.attributes(at: 0, effectiveRange: nil)
        #expect(attributes[.foregroundColor] as? RColor == .red, "Foreground color should be red")
        #expect(attributes[.backgroundColor] as? RColor == .yellow, "Background color should be yellow")
        #expect(attributes[.underlineColor] as? RColor == .blue, "Underline color should be blue")
        #expect(attributes[.strikethroughColor] as? RColor == .green, "Strikethrough color should be green")
        #expect(attributes[.strokeColor] as? RColor == .purple, "Stroke color should be purple")
    }
}

// MARK: - Modifier Order Independence
@Suite("Basic Modifiers Order Independence")
struct BasicModifiersOrderTests {
    
    @Test("Modifier order does not affect result")
    func testModifierOrderIndependence() async throws {
        let sut1 = NSAttributedString {
            RText("Hello world")
                .foregroundColor(.red)
                .backgroundColor(.yellow)
                .font(.systemFont(ofSize: 16))
                .kerning(2)
        }
        
        let sut2 = NSAttributedString {
            RText("Hello world")
                .kerning(2)
                .font(.systemFont(ofSize: 16))
                .backgroundColor(.yellow)
                .foregroundColor(.red)
        }
        
        #expect(sut1.isEqual(to: sut2), "Different modifier orders should produce same result")
    }
    
    @Test("Chaining order with underline and strikethrough")
    func testUnderlineStrikethroughOrder() async throws {
        let sut1 = NSAttributedString {
            RText("Test")
                .underline(.single, color: .red)
                .strikethrough(.double, color: .blue)
        }
        
        let sut2 = NSAttributedString {
            RText("Test")
                .strikethrough(.double, color: .blue)
                .underline(.single, color: .red)
        }
        
        #expect(sut1.isEqual(to: sut2), "Underline and strikethrough order should not matter")
    }
}

#endif // !os(watchOS)
