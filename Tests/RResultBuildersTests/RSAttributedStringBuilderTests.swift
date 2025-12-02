//
//  RSAttributedStringBuilderTests.swift
//
//  Migrated to Swift Testing
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

@Suite("NSAttributedString Builder Tests")
struct RAttributedStringBuilderTests {
    
    @Test("Two text components can be combined")
    func testInitWithTwoAText() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world")
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let dslData = NSAttributedString {
            RText("Hello world")
            RText(" with Swift")
        }
        
        #expect(dslData == testData, "DSL string should be same as test data")
        #expect(dslData.string == "Hello world with Swift", "Combined text should match")
    }
    
    @Test("Bold font and color can be applied to ranges")
    func testInitWithBoldFontAndColor() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello Swift world!")
            mas.addAttribute(.font, value: RFont.boldSystemFont(ofSize: 10), range: NSMakeRange(0, 10))
            mas.addAttribute(.foregroundColor, value: RColor.red, range: NSMakeRange(10, 5))
            return mas
        }()
        
        let dslData = NSAttributedString {
            RText("Hello Swift world!")
                .font(.boldSystemFont(ofSize: 10), range: NSMakeRange(0, 10))
                .foregroundColor(.red, range: NSMakeRange(10, 5))
        }
        
        #expect(dslData == testData, "DSL string should be same as test data")
    }
    
    @Test("Multiple font ranges can be applied")
    func testInitWithFont() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello Swift world!")
            mas.addAttribute(.font, value: RFont.boldSystemFont(ofSize: 10), range: NSMakeRange(0, 10))
            mas.addAttribute(.font, value: RFont.systemFont(ofSize: 40), range: NSMakeRange(10, 5))
            return mas
        }()
        
        let dslData = NSAttributedString {
            RText("Hello Swift world!")
                .font(.boldSystemFont(ofSize: 10), range: NSMakeRange(0, 10))
                .font(.systemFont(ofSize: 40), range: NSMakeRange(10, 5))
        }
        
        #expect(dslData == testData, "DSL string should be same as test data")
    }
    
    @Test("Multiple color ranges can be applied")
    func testInitWithColor() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello Swift world!")
            mas.addAttribute(.foregroundColor, value: RColor.red, range: NSMakeRange(0, 10))
            mas.addAttribute(.foregroundColor, value: RColor.blue, range: NSMakeRange(10, 5))
            return mas
        }()
        
        let dslData = NSAttributedString {
            RText("Hello Swift world!")
                .foregroundColor(.red, range: NSMakeRange(0, 10))
                .foregroundColor(.blue, range: NSMakeRange(10, 5))
        }
        
        #expect(dslData == testData, "DSL string should be same as test data")
    }
    
    @Test("Text and link can be combined")
    func testInitWithTextAndLink() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "")
            mas.append(NSAttributedString(string: "Here is a link to ",
                                          attributes: [.foregroundColor: RColor.brown]))
            mas.append(NSAttributedString(string: "Apple",
                                          attributes: [.link: URL(string: "https://www.apple.com")!]))
            return mas
        }()
        
        let dslData = NSAttributedString {
            RText("Here is a link to ")
                .foregroundColor(RColor.brown)
            RLink("Apple", url: URL(string: "https://www.apple.com")!)
        }
        
        #expect(dslData == testData, "DSL string should be same as test data")
    }
    
    @Test("Strikethrough and underline can be applied")
    func testStrikeAndUnderline() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "")
            mas.append(NSAttributedString(string: "This is a strike and",
                                          attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]))
            mas.append(NSAttributedString(string: " underline",
                                          attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue]))
            return mas.font(.systemFont(ofSize: 40))
        }()
        
        let dslData = NSAttributedString {
            RText("This is a strike and")
                .strikethrough(.single)
            RText(" underline")
                .underline(.single)
        }
        .font(.systemFont(ofSize: 40))
        
        #expect(dslData == testData, "DSL string should be same as test data")
    }
    
    @Test("Strikethrough and underline can be applied to ranges")
    func testStrikeAndUnderlinePartially() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "This is a strike and  underline")
            mas.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, 10))
            mas.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(10, 5))
            return mas.font(.systemFont(ofSize: 40))
        }()
        
        let dslData = NSAttributedString {
            RText("This is a strike and  underline")
                .strikethrough(.single, range: NSMakeRange(0, 10))
                .underline(.single, range: NSMakeRange(10, 5))
        }
        .font(.systemFont(ofSize: 40))
        
        #expect(dslData == testData, "DSL string should be same as test data")
    }
    
    @Test("Shadow can be applied to text")
    func testInitWithShadow() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "This string is having a shadow")
            let shadow = NSShadow()
            shadow.shadowColor = RColor.gray
            shadow.shadowBlurRadius = 4
            shadow.shadowOffset = .init(width: 4, height: 4)
            mas.addAttributes([.shadow: shadow], range: NSMakeRange(0, mas.length))
            return mas.font(.systemFont(ofSize: 40))
        }()
        
        let dslData = NSAttributedString {
            RText("This string is having a shadow")
                .shadow(color: .gray, radius: 4.0, x: 4.0, y: 4.0)
        }
        .font(.systemFont(ofSize: 40))
        
        #expect(dslData == testData, "DSL string should be same as test data")
    }
    
    @Test("Stroke can be applied to text")
    func testInitWithStroke() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "I love swift and SwiftUI ❤️")
            mas.addAttributes([.strokeWidth: 2, .strokeColor: RColor.red], range: NSMakeRange(0, mas.length))
            return mas.font(.systemFont(ofSize: 50))
        }()
        
        let dslData = NSAttributedString {
            RText("I love swift and SwiftUI ❤️")
                .stroke(width: 2, color: .red)
        }
        .font(.systemFont(ofSize: 50))
        
        #expect(dslData == testData, "DSL string should be same as test data")
    }
    
    #if !os(watchOS)
    @Test("Text and icon can be combined")
    func testInitWithTextAndIcon() async throws {
        let folderIcon = RImage()
        
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Folder ")
            
            let attachment = NSTextAttachment()
            attachment.image = folderIcon
            
            let size = CGSize(width: 50, height: 50)
            attachment.bounds.size = size
            let attachmentString = NSAttributedString(attachment: attachment)
            
            mas.append(attachmentString)
            mas.addAttribute(.foregroundColor, value: RColor.blue, range: NSRange(location: 0, length: mas.length))
            mas.addAttribute(.font, value: RFont.systemFont(ofSize: 50), range: NSRange(location: 0, length: mas.length))
            
            return mas
        }()
        
        let dslData = NSAttributedString {
            RText("Folder ")
            RImageAttachment(image: folderIcon, size: CGSize(width: 50, height: 50))
        }
        .foregroundColor(.blue)
        .font(.systemFont(ofSize: 50))
        
        // Looks like NSTextAttachment equality does not work hence comparing raw string instead
        #expect(dslData.string == testData.string, "DSL string should be same as test data")
        #expect(dslData.string.contains("Folder"), "Should contain text")
    }
    #endif
    
    @Test("Optional values can be used in builder")
    func testInitWithOptional() async throws {
        let optionalText: String? = "iPhone12 upgrade is optional"
        
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: optionalText!)
            return mas.font(.systemFont(ofSize: 40))
        }()
        
        let dslData = NSAttributedString {
            if let text = optionalText {
                RText(text)
            } else {
                RText("I don't know optionals")
            }
        }
        .font(.systemFont(ofSize: 40))
        
        #expect(dslData == testData, "DSL string should be same as test data")
    }
    
    @Test("Switch statements work in builder")
    func testInitWithSwitchStatements() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "This is iPhone")
            return mas.font(.systemFont(ofSize: 40))
        }()
        
        enum Apple {
            case iPhone
            case mac
            case airpod
        }
        
        let appleDevice = Apple.iPhone
        let dslData = NSAttributedString {
            switch appleDevice {
            case .iPhone:
                RText("This is iPhone")
            default:
                RText("Apple future device")
            }
        }
        .font(.systemFont(ofSize: 40))
        
        #expect(dslData == testData, "DSL string should be same as test data")
    }
    
    @Test("Logical statements work in builder")
    func testInitWithLogicalStatement() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "4 is even number")
            return mas.font(.systemFont(ofSize: 40))
        }()
        
        let dslData = NSAttributedString {
            if 4 % 2 == 0 {
                RText("4 is even number")
            }
        }
        .font(.systemFont(ofSize: 40))
        
        #expect(dslData == testData, "DSL string should be same as test data")
    }
    
    @Test("Raw string values can be used with modifiers")
    func testInitWithRawValues() async throws {
        let testData: NSAttributedString = {
            var mas = NSAttributedString(string: "Function Builder awesome")
            mas = mas.font(.systemFont(ofSize: 40))
            return mas.foregroundColor(.red)
        }()
        
        let dslData = NSAttributedString {
            "Function Builder awesome"
                .font(.systemFont(ofSize: 40))
                .foregroundColor(.red)
        }
        
        #expect(dslData == testData, "DSL string should be same as test data")
    }
}

// MARK: - Control Flow Tests
@Suite("NSAttributedString Builder Control Flow")
struct AttributedStringControlFlowTests {
    
    @Test("Nil optional produces empty result")
    func testNilOptional() async throws {
        let optionalText: String? = nil
        
        let dslData = NSAttributedString {
            if let text = optionalText {
                RText(text)
            } else {
                RText("Fallback text")
            }
        }
        
        #expect(dslData.string == "Fallback text", "Should use fallback text")
    }
    
    @Test("Switch with multiple cases", arguments: [
        ("iPhone", "This is iPhone"),
        ("mac", "This is Mac"),
        ("airpod", "This is AirPod")
    ])
    func testSwitchWithMultipleCases(device: String, expected: String) async throws {
        enum Apple {
            case iPhone
            case mac
            case airpod
        }
        
        let appleDevice: Apple
        switch device {
        case "iPhone": appleDevice = .iPhone
        case "mac": appleDevice = .mac
        default: appleDevice = .airpod
        }
        
        let dslData = NSAttributedString {
            switch appleDevice {
            case .iPhone:
                RText("This is iPhone")
            case .mac:
                RText("This is Mac")
            case .airpod:
                RText("This is AirPod")
            }
        }
        
        #expect(dslData.string == expected, "Should match device text")
    }
    
    @Test("For loop can be used in builder")
    func testForLoop() async throws {
        let items = ["Swift", "Kotlin", "Rust"]
        
        let dslData = NSAttributedString {
            for item in items {
                RText(item)
                RSpace()
            }
        }
        
        #expect(dslData.string.contains("Swift"), "Should contain Swift")
        #expect(dslData.string.contains("Kotlin"), "Should contain Kotlin")
        #expect(dslData.string.contains("Rust"), "Should contain Rust")
    }
    
    @Test("Complex nested conditionals work")
    func testNestedConditionals() async throws {
        let showTitle = true
        let showSubtitle = true
        
        let dslData = NSAttributedString {
            if showTitle {
                RText("Title")
                    .font(.boldSystemFont(ofSize: 20))
                
                if showSubtitle {
                    RLineBreak()
                    RText("Subtitle")
                        .font(.systemFont(ofSize: 14))
                }
            }
        }
        
        #expect(dslData.string.contains("Title"), "Should contain title")
        #expect(dslData.string.contains("Subtitle"), "Should contain subtitle")
    }
}

// MARK: - Range-Based Modifier Tests
@Suite("NSAttributedString Range-Based Modifiers")
struct AttributedStringRangeTests {
    
    @Test("Font can be applied to specific ranges")
    func testFontRanges() async throws {
        let text = "Hello World Swift"
        let dslData = NSAttributedString {
            RText(text)
                .font(.boldSystemFont(ofSize: 20), range: NSMakeRange(0, 5))
                .font(.systemFont(ofSize: 14), range: NSMakeRange(6, 5))
        }
        
        // Verify first range has bold font
        let firstAttr = dslData.attributes(at: 0, effectiveRange: nil)
        let firstFont = firstAttr[.font] as? RFont
        #expect(firstFont != nil, "First range should have font")
        
        // Verify second range has different font
        let secondAttr = dslData.attributes(at: 6, effectiveRange: nil)
        let secondFont = secondAttr[.font] as? RFont
        #expect(secondFont != nil, "Second range should have font")
    }
    
    @Test("Color can be applied to specific ranges")
    func testColorRanges() async throws {
        let text = "Red Green Blue"
        let dslData = NSAttributedString {
            RText(text)
                .foregroundColor(.red, range: NSMakeRange(0, 3))
                .foregroundColor(.green, range: NSMakeRange(4, 5))
                .foregroundColor(.blue, range: NSMakeRange(10, 4))
        }
        
        let firstColor = dslData.attributes(at: 0, effectiveRange: nil)[.foregroundColor] as? RColor
        let secondColor = dslData.attributes(at: 4, effectiveRange: nil)[.foregroundColor] as? RColor
        let thirdColor = dslData.attributes(at: 10, effectiveRange: nil)[.foregroundColor] as? RColor
        
        #expect(firstColor == .red, "First range should be red")
        #expect(secondColor == .green, "Second range should be green")
        #expect(thirdColor == .blue, "Third range should be blue")
    }
    
    @Test("Multiple attributes can be applied to overlapping ranges")
    func testOverlappingRanges() async throws {
        let text = "Hello World"
        let dslData = NSAttributedString {
            RText(text)
                .font(.boldSystemFont(ofSize: 20), range: NSMakeRange(0, 5))
                .foregroundColor(.red, range: NSMakeRange(0, 11))
                .underline(.single, range: NSMakeRange(6, 5))
        }
        
        // First range should have both font and color
        let firstAttr = dslData.attributes(at: 0, effectiveRange: nil)
        #expect(firstAttr[.font] != nil, "Should have font")
        #expect(firstAttr[.foregroundColor] != nil, "Should have color")
        
        // Second range should have color and underline
        let secondAttr = dslData.attributes(at: 6, effectiveRange: nil)
        #expect(secondAttr[.foregroundColor] != nil, "Should have color")
        #expect(secondAttr[.underlineStyle] != nil, "Should have underline")
    }
}

// MARK: - Link and Attachment Tests
@Suite("NSAttributedString Links and Attachments")
struct AttributedStringLinksTests {
    
    @Test("Multiple links can be created")
    func testMultipleLinks() async throws {
        let dslData = NSAttributedString {
            RLink("Apple", url: URL(string: "https://apple.com")!)
            RSpace()
            RLink("Google", url: URL(string: "https://google.com")!)
        }
        
        #expect(dslData.string.contains("Apple"), "Should contain Apple")
        #expect(dslData.string.contains("Google"), "Should contain Google")
        
        // Verify first link
        let firstAttr = dslData.attributes(at: 0, effectiveRange: nil)
        let firstLink = firstAttr[.link] as? URL
        #expect(firstLink?.absoluteString == "https://apple.com", "First link should be Apple")
    }
}

// MARK: - String Literal Tests
@Suite("NSAttributedString String Literals")
struct AttributedStringLiteralsTests {
    
    @Test("String literals work as components")
    func testStringLiteral() async throws {
        let dslData = NSAttributedString {
            "Hello"
            " "
            "World"
        }
        
        #expect(dslData.string == "Hello World", "String literals should concatenate")
    }
    
    @Test("String literals can have modifiers")
    func testStringLiteralWithModifiers() async throws {
        let dslData = NSAttributedString {
            "Styled Text"
                .font(.boldSystemFont(ofSize: 20))
                .foregroundColor(.red)
        }
        
        #expect(dslData.string == "Styled Text", "Should contain text")
        
        let attributes = dslData.attributes(at: 0, effectiveRange: nil)
        #expect(attributes[.font] != nil, "Should have font")
        #expect(attributes[.foregroundColor] != nil, "Should have color")
    }
}

#endif // !os(watchOS)
