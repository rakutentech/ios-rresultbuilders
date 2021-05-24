//
//  RFixedComponentsTests.swift
//  
//
//

#if !os(watchOS)
import XCTest
@testable import RResultBuilders

final class ComponentsTests: XCTestCase {
    func testEmpty() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "")
            return mas
        }()
        
        let sut = NSAttributedString {
            REmpty()
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testSpace() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: " ")
            return mas
        }()
        
        let sut = NSAttributedString {
            RSpace()
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testSpaceByCount() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "    ")
            return mas
        }()
        
        let sut = NSAttributedString {
            RSpace(count: 4)
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testLineBreak() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "")
            mas.append(NSAttributedString(string: "\n"))
            mas.append(NSAttributedString(string: ""))
            return mas
        }()
        
        let sut = NSAttributedString {
            RLineBreak()            
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
    
    func testLineBreakByCount() {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "\n\n\n\n")
            return mas
        }()
        
        let sut = NSAttributedString {
            RLineBreak(count: 4)
        }
        
        XCTAssertTrue(sut.isEqual(testData))
    }
}

#endif
