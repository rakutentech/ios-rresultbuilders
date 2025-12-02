//
//  RFixedComponentsTests.swift
//
//  Migrated to Swift Testing
//

#if !os(watchOS)
import Testing
import Foundation
@testable import RResultBuilders

@Suite("NSAttributedString Component Tests")
struct ComponentsTests {
    
    @Test("Empty component produces empty attributed string")
    func testEmpty() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "")
            return mas
        }()
        
        let sut = NSAttributedString {
            REmpty()
        }
        
        #expect(sut.isEqual(to: testData), "Empty component should produce empty attributed string")
        #expect(sut.string.isEmpty, "String content should be empty")
    }
    
    @Test("Space component produces single space")
    func testSpace() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: " ")
            return mas
        }()
        
        let sut = NSAttributedString {
            RSpace()
        }
        
        #expect(sut.isEqual(to: testData), "Space component should produce single space")
        #expect(sut.string == " ", "String should contain exactly one space")
    }
    
    @Test("Space component with count produces multiple spaces", arguments: [1, 2, 4, 10])
    func testSpaceByCount(count: Int) async throws {
        let expectedString = String(repeating: " ", count: count)
        let testData = NSMutableAttributedString(string: expectedString)
        
        let sut = NSAttributedString {
            RSpace(count: count)
        }
        
        #expect(sut.isEqual(to: testData), "Space component should produce \(count) spaces")
        #expect(sut.string == expectedString, "String should contain exactly \(count) spaces")
        #expect(sut.string.count == count, "String length should be \(count)")
    }
    
    @Test("LineBreak component produces single newline")
    func testLineBreak() async throws {
        let testData: NSAttributedString = {
            let mas = NSMutableAttributedString(string: "")
            mas.append(NSAttributedString(string: "\n"))
            mas.append(NSAttributedString(string: ""))
            return mas
        }()
        
        let sut = NSAttributedString {
            RLineBreak()
        }
        
        #expect(sut.isEqual(to: testData), "LineBreak component should produce single newline")
        #expect(sut.string == "\n", "String should contain exactly one newline")
    }
    
    @Test("LineBreak component with count produces multiple newlines", arguments: [1, 2, 4, 10])
    func testLineBreakByCount(count: Int) async throws {
        let expectedString = String(repeating: "\n", count: count)
        let testData = NSMutableAttributedString(string: expectedString)
        
        let sut = NSAttributedString {
            RLineBreak(count: count)
        }
        
        #expect(sut.isEqual(to: testData), "LineBreak component should produce \(count) newlines")
        #expect(sut.string == expectedString, "String should contain exactly \(count) newlines")
        #expect(sut.string.count == count, "String length should be \(count)")
    }
    
    @Test("Multiple components can be combined")
    func testCombinedComponents() async throws {
        let sut = NSAttributedString {
            RSpace()
            RLineBreak()
            RSpace(count: 2)
        }
        
        #expect(sut.string == " \n  ", "Combined components should produce ' \\n  '")
        #expect(sut.string.count == 4, "Combined string length should be 4")
    }
}

// MARK: - Edge Cases and Additional Tests
@Suite("NSAttributedString Component Edge Cases")
struct ComponentsEdgeCaseTests {
    
    @Test("Zero count space produces empty string")
    func testZeroSpaces() async throws {
        let sut = NSAttributedString {
            RSpace(count: 0)
        }
        
        #expect(sut.string.isEmpty, "Zero spaces should produce empty string")
    }
    
    @Test("Zero count line break produces empty string")
    func testZeroLineBreaks() async throws {
        let sut = NSAttributedString {
            RLineBreak(count: 0)
        }
        
        #expect(sut.string.isEmpty, "Zero line breaks should produce empty string")
    }
    
    @Test("Large count space component", arguments: [100, 500, 1000])
    func testLargeSpaceCount(count: Int) async throws {
        let sut = NSAttributedString {
            RSpace(count: count)
        }
        
        #expect(sut.string.count == count, "Should produce \(count) spaces")
        #expect(sut.string.allSatisfy { $0 == " " }, "All characters should be spaces")
    }
    
    @Test("Large count line break component", arguments: [100, 500, 1000])
    func testLargeLineBreakCount(count: Int) async throws {
        let sut = NSAttributedString {
            RLineBreak(count: count)
        }
        
        #expect(sut.string.count == count, "Should produce \(count) newlines")
        #expect(sut.string.allSatisfy { $0 == "\n" }, "All characters should be newlines")
    }
    
    @Test("Empty component is truly empty")
    func testEmptyIsEmpty() async throws {
        let sut = NSAttributedString {
            REmpty()
        }
        
        #expect(sut.string.isEmpty, "Empty component should have empty string")
        #expect(sut.length == 0, "Empty component should have zero length")
    }
    
    @Test("Mixing empty with other components")
    func testEmptyWithOtherComponents() async throws {
        let sut = NSAttributedString {
            REmpty()
            RSpace()
            REmpty()
            RLineBreak()
            REmpty()
        }
        
        #expect(sut.string == " \n", "Empty components should not affect output")
        #expect(sut.string.count == 2, "Should only count non-empty components")
    }
    
    @Test("Component equality", arguments: [
        (1, 1, true),
        (5, 5, true),
        (1, 2, false),
        (10, 5, false)
    ])
    func testComponentEquality(count1: Int, count2: Int, shouldBeEqual: Bool) async throws {
        let sut1 = NSAttributedString {
            RSpace(count: count1)
        }
        
        let sut2 = NSAttributedString {
            RSpace(count: count2)
        }
        
        if shouldBeEqual {
            #expect(sut1.isEqual(to: sut2), "Spaces with count \(count1) and \(count2) should be equal")
        } else {
            #expect(!sut1.isEqual(to: sut2), "Spaces with count \(count1) and \(count2) should not be equal")
        }
    }
}

// MARK: - Performance Tests (Optional)
@Suite("NSAttributedString Component Performance")
struct ComponentsPerformanceTests {
    
    @Test("Creating large space component is efficient")
    func testLargeSpacePerformance() async throws {
        // This will help identify any performance regressions
        let largeCount = 10000
        
        let sut = NSAttributedString {
            RSpace(count: largeCount)
        }
        
        #expect(sut.string.count == largeCount, "Should handle large counts efficiently")
    }
    
    @Test("Creating large line break component is efficient")
    func testLargeLineBreakPerformance() async throws {
        let largeCount = 10000
        
        let sut = NSAttributedString {
            RLineBreak(count: largeCount)
        }
        
        #expect(sut.string.count == largeCount, "Should handle large counts efficiently")
    }
}

#endif // !os(watchOS)
