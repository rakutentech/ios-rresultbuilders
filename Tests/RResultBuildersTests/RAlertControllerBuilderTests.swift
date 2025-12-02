//
//  RAlertControllerBuilderTests.swift
//  
//


//
//  RAlertControllerBuilderTests.swift
//
//  Migrated to Swift Testing
//

#if os(iOS)
import Testing
import UIKit
@testable import RResultBuilders

@Suite("UIAlertController Builder Tests")
@MainActor
struct RAlertControllerBuilderTests {
    
    @Test("Alert controller with DSL matches traditional alert controller")
    func testAlertControllerWithDSL() async throws {
        let testAlert: UIAlertController = {
            let alert = UIAlertController(
                title: "Delete all data?",
                message: "All your data will be deleted!",
                preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Yes, Delete it All", style: .destructive) { (_) in
                debugPrint("Deleting all data")
            }
            
            let moreOptionsAction = UIAlertAction(title: "Show More Options", style: .default) { (_) in
                debugPrint("Show more options")
            }
            
            let cancelAction = UIAlertAction(title: "No, Don't Delete Anything", style: .cancel, handler: nil)
            
            alert.addAction(deleteAction)
            alert.addAction(moreOptionsAction)
            alert.addAction(cancelAction)
            return alert
        }()
        
        let dslAlert = UIAlertController(
            title: "Delete all data?",
            message: "All your data will be deleted!") {
            DestructiveAction("Yes, Delete it All") {
                debugPrint("Deleting all data")
            }
            
            DefaultAction("Show More Options") {
                debugPrint("showing more options")
            }
            
            CancelAction("No, Don't Delete Anything")
        }
        
        // Verify actions count
        #expect(dslAlert.actions.count == testAlert.actions.count,
                "DSL alert should have same number of actions as traditional alert")
        
        // Verify each action
        for (i, dslAlertAction) in dslAlert.actions.enumerated() {
            #expect(dslAlertAction.title == testAlert.actions[i].title,
                   "DSL alert action title should match traditional alert action title at index \(i)")
            #expect(dslAlertAction.style == testAlert.actions[i].style,
                   "DSL alert action style should match traditional alert action style at index \(i)")
            #expect(dslAlertAction.isEnabled == testAlert.actions[i].isEnabled,
                   "DSL alert action enabled state should match traditional alert action at index \(i)")
        }
    }
    
    @Test("Action sheet with DSL matches traditional action sheet")
    func testActionSheetWithDSL() async throws {
        let testAlert: UIAlertController = {
            let alert = UIAlertController(
                title: "Delete all data?",
                message: "All your data will be deleted!",
                preferredStyle: .actionSheet)
            
            let deleteAction = UIAlertAction(title: "Yes, Delete it All", style: .destructive) { (_) in
                debugPrint("Deleting all data")
            }
            
            let moreOptionsAction = UIAlertAction(title: "Show More Options", style: .default) { (_) in
                debugPrint("Show more options")
            }
            
            let cancelAction = UIAlertAction(title: "No, Don't Delete Anything", style: .cancel, handler: nil)
            
            alert.addAction(deleteAction)
            alert.addAction(moreOptionsAction)
            alert.addAction(cancelAction)
            return alert
        }()
        
        let dslAlert = UIAlertController(
            title: "Delete all data?",
            message: "All your data will be deleted!",
            style: .actionSheet) {
            DestructiveAction("Yes, Delete it All") {
                debugPrint("Deleting all data")
            }
            
            DefaultAction("Show More Options") {
                debugPrint("showing more options")
            }
            
            CancelAction("No, Don't Delete Anything")
        }
        
        // Verify actions count
        #expect(dslAlert.actions.count == testAlert.actions.count,
                "DSL action sheet should have same number of actions as traditional action sheet")
        
        // Verify each action
        for (i, dslAlertAction) in dslAlert.actions.enumerated() {
            #expect(dslAlertAction.title == testAlert.actions[i].title,
                   "DSL action sheet action title should match traditional action sheet action title at index \(i)")
            #expect(dslAlertAction.style == testAlert.actions[i].style,
                   "DSL action sheet action style should match traditional action sheet action style at index \(i)")
            #expect(dslAlertAction.isEnabled == testAlert.actions[i].isEnabled,
                   "DSL action sheet action enabled state should match traditional action sheet at index \(i)")
        }
    }
    
    @Test("DSL alert has correct title and message")
    func testAlertTitleAndMessage() async throws {
        let expectedTitle = "Delete all data?"
        let expectedMessage = "All your data will be deleted!"
        
        let dslAlert = UIAlertController(
            title: expectedTitle,
            message: expectedMessage) {
            DestructiveAction("Delete") { }
            CancelAction("Cancel")
        }
        
        #expect(dslAlert.title == expectedTitle, "Alert title should match")
        #expect(dslAlert.message == expectedMessage, "Alert message should match")
        #expect(dslAlert.preferredStyle == .alert, "Preferred style should be alert")
    }
    
    @Test("DSL action sheet has correct style")
    func testActionSheetStyle() async throws {
        let dslAlert = UIAlertController(
            title: "Options",
            message: "Select an option",
            style: .actionSheet) {
            DefaultAction("Option 1") { }
            CancelAction("Cancel")
        }
        
        #expect(dslAlert.preferredStyle == .actionSheet, "Preferred style should be action sheet")
    }
    
    @Test("DSL supports different action styles", arguments: [
        ("Destructive", UIAlertAction.Style.destructive),
        ("Default", UIAlertAction.Style.default),
        ("Cancel", UIAlertAction.Style.cancel)
    ])
    func testActionStyles(title: String, expectedStyle: UIAlertAction.Style) async throws {
        let dslAlert = UIAlertController(
            title: "Test",
            message: "Testing action styles") {
            if expectedStyle == .destructive {
                DestructiveAction(title) { }
            } else if expectedStyle == .default {
                DefaultAction(title) { }
            } else {
                CancelAction(title)
            }
        }
        
        #expect(dslAlert.actions.count == 1, "Should have one action")
        #expect(dslAlert.actions.first?.style == expectedStyle,
               "Action style should be \(expectedStyle)")
        #expect(dslAlert.actions.first?.title == title,
               "Action title should be '\(title)'")
    }
}

// MARK: - Additional Test Suite for Edge Cases
@Suite("UIAlertController Edge Cases")
@MainActor
struct RAlertControllerEdgeCaseTests {
    
    @Test("Empty alert with no actions")
    func testEmptyAlert() async throws {
        let dslAlert = UIAlertController(
            title: "Empty Alert",
            message: "No actions") {
            // No actions
        }
        
        #expect(dslAlert.actions.isEmpty, "Alert should have no actions")
    }
    
    @Test("Alert with single action")
    func testSingleAction() async throws {
        let dslAlert = UIAlertController(
            title: "Single Action",
            message: "Only one action") {
            DefaultAction("OK") { }
        }
        
        #expect(dslAlert.actions.count == 1, "Should have exactly one action")
    }
    
    @Test("Alert with multiple actions of same type")
    func testMultipleSameTypeActions() async throws {
        let dslAlert = UIAlertController(
            title: "Multiple Options",
            message: "Choose one") {
            DefaultAction("Option 1") { }
            DefaultAction("Option 2") { }
            DefaultAction("Option 3") { }
        }
        
        #expect(dslAlert.actions.count == 3, "Should have three actions")
        #expect(dslAlert.actions.allSatisfy { $0.style == .default },
               "All actions should be default style")
    }
}
#endif // os(iOS)
