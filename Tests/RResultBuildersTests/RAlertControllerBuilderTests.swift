//
//  RAlertControllerBuilderTests.swift
//  
//


#if os(iOS)
import XCTest
@testable import RResultBuilders

final class RAlertControllerBuilderTests: XCTestCase {
    func testInitWithAlertController() {
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
        
        for (i, dslAlertAction) in dslAlert.actions.enumerated() {
            XCTAssertTrue(dslAlertAction.title == testAlert.actions[i].title, "DSL alert action title should be same as default alert action title")
            XCTAssertTrue(dslAlertAction.style == testAlert.actions[i].style, "DSL alert action style should be same as default alert action style")
            XCTAssertTrue(dslAlertAction.isEnabled == testAlert.actions[i].isEnabled, "DSL alert action enable should be same as default alert action enable")
        }
    }
    func testInitWithActionSheet() {
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
        
        for (i, dslAlertAction) in dslAlert.actions.enumerated() {
            XCTAssertTrue(dslAlertAction.title == testAlert.actions[i].title, "DSL alert action title should be same as default alert action title")
            XCTAssertTrue(dslAlertAction.style == testAlert.actions[i].style, "DSL alert action style should be same as default alert action style")
            XCTAssertTrue(dslAlertAction.isEnabled == testAlert.actions[i].isEnabled, "DSL alert action enable should be same as default alert action enable")
        }
    }
}
#endif
