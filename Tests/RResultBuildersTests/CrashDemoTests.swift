//
//  CrashDemoTests.swift
//  RResultBuilders
//
//  Live demo of the security-scan finding: empty components crash paragraph-style
//  modifiers via allAttributes -> attributes(at: 0) on a zero-length string.
//
//  Run with:  swift test --filter CrashDemoTests
//

#if !os(watchOS)
import Testing
import Foundation
@testable import RResultBuilders

import UIKit

@Suite("🔴 SECURITY SCAN FINDING — Empty Component Crash Demo")
struct CrashDemoTests {

    // MARK: - The crash cases (each one terminates the process with NSRangeException)

    @Test("CRASH 1: RText(\"\") + alignment (scan's exact scenario)")
    func crashEmptyRTextAlignment() {
        // RAttributedComponent+Basic.swift:25 — attributes(at: 0) on length-0 string
        let result = RText("").alignment(.center)
        print("survived: \(result.attributedString)")
    }

    @Test("CRASH 2: Empty String component + alignment")
    func crashEmptyStringComponent() {
        let result = "".alignment(.center)
        print("survived: \(result.attributedString)")
    }

    @Test("CRASH 3: RLink with empty anchor + alignment")
    func crashEmptyRLink() {
        let result = RLink("", url: URL(string: "https://example.com")!)
            .alignment(.center)
        print("survived: \(result.attributedString)")
    }

    @Test("CRASH 4: Empty RText + lineSpacing (any paragraph modifier)")
    func crashEmptyRTextLineSpacing() {
        let result = RText("").lineSpacing(4)
        print("survived: \(result.attributedString)")
    }

    // MARK: - The safe cases (these pass)

    @Test("SAFE 1: Whitespace RText + alignment (length > 0)")
    func safeWhitespaceRText() {
        let result = RText(" ").alignment(.center)
        print("survived: \(result.attributedString)")
    }

    @Test("SAFE 2: Normal RText + alignment")
    func safeNormalRText() {
        let result = RText("Hello").alignment(.center)
        print("survived: \(result.attributedString)")
    }

    @Test("SAFE 3: Empty RText + font (non-paragraph modifier does not crash)")
    func safeEmptyRTextFont() {
        let result = RText("").font(.systemFont(ofSize: 12))
        print("survived: \(result.attributedString)")
    }
}
#endif
