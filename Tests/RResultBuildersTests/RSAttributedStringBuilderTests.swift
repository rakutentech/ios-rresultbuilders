//
//  RSAttributedStringBuilderTests.swift
//  
//
//

#if !os(watchOS)
import XCTest
@testable import RResultBuilders

final class RAttributedStringBuilderTests: XCTestCase {
    func testInitWithTwoAText() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Hello world")
            mas.append(NSAttributedString(string: " with Swift"))
            return mas
        }()
        
        let dslData = NSAttributedString {
            RText("Hello world")
            RText(" with Swift")
        }
        
        XCTAssertTrue(dslData == testData, "DSL string should be same as test data")
    }
    
    func testInitWithBoldFontAndColor() {
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
        
        XCTAssertTrue(dslData == testData, "DSL string should be same as test data")
    }
    
    func testInitWithFont() {
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
        
        XCTAssertTrue(dslData == testData, "DSL string should be same as test data")
    }
    
    func testInitWithColor() {
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
        
        XCTAssertTrue(dslData == testData, "DSL string should be same as test data")
    }
    
    func testInitWithTextAndLink() {
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
        
        XCTAssertTrue(dslData == testData, "DSL string should be same as test data")
    }
    
    func testStrikeAndUnderline() {
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
        
        XCTAssertTrue(dslData == testData, "DSL string should be same as test data")
    }
    
    func testStrikeAndUnderlinePartially() {
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
        
        XCTAssertTrue(dslData == testData, "DSL string should be same as test data")
    }
    
    func testInitWithShadow() {
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
        
        XCTAssertTrue(dslData == testData, "DSL string should be same as test data")
    }
    
    func testInitWithStroke() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "I love swift and SwiftUI ???")
            mas.addAttributes([.strokeWidth: 2, .strokeColor: RColor.red], range: NSMakeRange(0, mas.length))
            return mas.font(.systemFont(ofSize: 50))
        }()
        
        let dslData = NSAttributedString {
            RText("I love swift and SwiftUI ???")
                .stroke(width: 2, color: .red)
        }
        .font(.systemFont(ofSize: 50))
        
        XCTAssertTrue(dslData == testData, "DSL string should be same as test data")
    }
    
    #if !os(watchOS)
    func testInitWithTextAndIcon() {
        let folderIcon = RImage()
        
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "Folder ")
            
            let attachment = NSTextAttachment()
            attachment.image = folderIcon
            
            let size = CGSize(width: 50, height: 50)
            let aspectRatio = folderIcon.size.width / folderIcon.size.height
            var newSize = size
            if size.width > size.height {
                newSize.height = size.width / aspectRatio
            } else {
                newSize.width = size.height * aspectRatio
            }
            
            attachment.bounds.size = newSize
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
        XCTAssertTrue(dslData.string == testData.string, "DSL string should be same as test data")
    }
    #endif
    
    func testInitWithOptional() {
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
        
        XCTAssertTrue(dslData == testData, "DSL string should be same as test data")
    }
    
    func testInitWithSwitchStatements() {
        
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
        
        XCTAssertTrue(dslData == testData, "DSL string should be same as test data")
    }
    
    func testInitWithLogicalStatement() {
        
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
        
        XCTAssertTrue(dslData == testData, "DSL string should be same as test data")
    }
    
    func testInitWithRawValues() {
        
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
        
        XCTAssertTrue(dslData == testData, "DSL string should be same as test data")
    }
}

#endif
