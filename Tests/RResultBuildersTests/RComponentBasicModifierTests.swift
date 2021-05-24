//
//  RComponentBasicModifierTests.swift
//  
//
//

#if !os(watchOS)
import XCTest
@testable import RResultBuilders

final class RComponentBasicModifierTests: XCTestCase {
    func testModifyWithSingleAttribute() {
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
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyBackgroundColor() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.backgroundColor: RColor.red])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .backgroundColor(.red)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyBaselineOffset() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.baselineOffset: 10])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .baselineOffset(10)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyFontAndColor() {
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
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyExpansion() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.expansion: 1])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .expansion(1)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyKerning() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.kern: 3])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .kerning(3)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyLigature() {
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
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyObliqueness() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.obliqueness: 0.5])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .obliqueness(0.5)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyShadow() {
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
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyStrikethrough() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.strikethroughStyle: NSUnderlineStyle.double.rawValue])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .strikethrough(.double)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyStrikethroughWithColor() {
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
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyStroke() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.strokeWidth: -2])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .stroke(width: -2)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyStrokeWithColor() {
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
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyTextEffect() {
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
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyUnderline() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.underlineStyle: NSUnderlineStyle.patternDashDotDot.rawValue])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .underline(.patternDashDotDot)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyUnderlineWithColor() {
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
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyWritingDirection() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.writingDirection: NSWritingDirection.rightToLeft.rawValue])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .writingDirection(.rightToLeft)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    #if canImport(AppKit)
    func testModifyVertical() {
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
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    #endif
    
    func testChaining() {
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
        
        XCTAssertTrue(sut.isEqual(testData))
    }
}
#endif
