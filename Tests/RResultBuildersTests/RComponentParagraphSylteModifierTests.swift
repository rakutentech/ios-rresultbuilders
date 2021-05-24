//
//  RComponentParagraphSylteModifierTests.swift
//  
//
//

#if !os(watchOS)
import XCTest
@testable import RResultBuilders

#if canImport(UIKit)
import UIKit
import Foundation
#elseif canImport(AppKit)
import AppKit
#endif

final class RAttributedComponentParagraphModifierTests: XCTestCase {
    func testSetEmptyParagraphStyle() {
        let testData: NSAttributedString = {
            let ps = NSParagraphStyle()
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.paragraphStyle: ps])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let ps = NSParagraphStyle()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .paragraphStyle(ps)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyMutableParagraphStyle() {
        let testData: NSAttributedString = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .right
            
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.paragraphStyle: paragraphStyle])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let mps = NSMutableParagraphStyle()
        mps.alignment = .right
        
        let sut = NSAttributedString {
            RText("Hello world")
                .paragraphStyle(mps)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyAlignment() {
        let testData: NSAttributedString = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .right
            
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.paragraphStyle: paragraphStyle])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .alignment(.right)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyFirstHeadIndent() {
        let testData: NSAttributedString = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.firstLineHeadIndent = 16
            
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.paragraphStyle: paragraphStyle])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .firstLineHeadIndent(16)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyHeadIndent() {
        let testData: NSAttributedString = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.headIndent = 13
            
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.paragraphStyle: paragraphStyle])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .headIndent(13)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyTailIndent() {
        let testData: NSAttributedString = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.tailIndent = 19
            
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.paragraphStyle: paragraphStyle])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .tailIndent(19)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyLinebreakMode() {
        let testData: NSAttributedString = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byWordWrapping
            
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.paragraphStyle: paragraphStyle])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .lineBreakeMode(.byWordWrapping)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyLineHeight() {
        let testData: NSAttributedString = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1
            paragraphStyle.maximumLineHeight = 22
            paragraphStyle.minimumLineHeight = 18
            
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.paragraphStyle: paragraphStyle])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .lineHeight(multiple: 1, maximum: 22, minimum: 18)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyLineSpacing() {
        let testData: NSAttributedString = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 7
            
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.paragraphStyle: paragraphStyle])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .lineSpacing(7)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyParagraphSpacing() {
        let testData: NSAttributedString = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.paragraphSpacing = 9.3
            paragraphStyle.paragraphSpacingBefore = 17.2
            
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.paragraphStyle: paragraphStyle])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .paragraphSpacing(9.3, before: 17.2)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyBaseWritingDirection() {
        let testData: NSAttributedString = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.baseWritingDirection = .rightToLeft
            
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.paragraphStyle: paragraphStyle])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .baseWritingDirection(.rightToLeft)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testModifyHyphenationFactor() {
        let testData: NSAttributedString = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.hyphenationFactor = 0.3
            
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.paragraphStyle: paragraphStyle])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .hyphenationFactor(0.3)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    @available(iOS 9.0, OSX 10.11, *)
    func testChaining() {
        let testData: NSAttributedString = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .right
            paragraphStyle.firstLineHeadIndent = 16
            paragraphStyle.headIndent = 13
            paragraphStyle.tailIndent = 19
            paragraphStyle.lineBreakMode = .byWordWrapping
            paragraphStyle.lineHeightMultiple = 1
            paragraphStyle.maximumLineHeight = 22
            paragraphStyle.minimumLineHeight = 18
            paragraphStyle.lineSpacing = 7
            paragraphStyle.paragraphSpacing = 9.3
            paragraphStyle.paragraphSpacingBefore = 17.2
            paragraphStyle.baseWritingDirection = .rightToLeft
            paragraphStyle.hyphenationFactor = 0.3
            
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.paragraphStyle: paragraphStyle])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
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
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    @available(iOS 9.0, OSX 10.11, *)
    func testRandomChainingOrderEqualness() {
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
        
        XCTAssertTrue(sut.isEqual(sut2))
    }
    
    func testSetEmptyParagraphStyleThenChaining() {
        let testData: NSAttributedString = {
            let mps = NSMutableParagraphStyle()
            mps.alignment = .justified
            let mas = NSMutableAttributedString(string: "Hello world",
                                                attributes: [.paragraphStyle: mps])
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let ps = NSParagraphStyle()
        
        let sut = NSAttributedString {
            RText("Hello world")
                .paragraphStyle(ps)
                .alignment(.justified)
            RText(" with Swift")
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
}

#endif
