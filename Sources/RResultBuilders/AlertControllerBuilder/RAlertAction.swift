//
//  RAlertAction.swift
//  RResultBuilders
//

#if os(iOS)
import UIKit

public typealias RAlertActionHandler = () -> Void

// MARK: - Actions
public protocol RAlertAction {
    var title: String { get }
    var style: UIAlertAction.Style { get }
    var action: RAlertActionHandler { get }
}

public struct DefaultAction: RAlertAction {
    public let title: String
    public let style: UIAlertAction.Style
    public let action: RAlertActionHandler
    
    public init(_ title: String, action: @escaping RAlertActionHandler = {}) {
        self.title = title
        self.style = .default
        self.action = action
    }
}

public struct CancelAction: RAlertAction {
    public let title: String
    public let style: UIAlertAction.Style
    public let action: RAlertActionHandler
    
    public init(_ title: String, action: @escaping RAlertActionHandler = {}) {
        self.title = title
        self.style = .cancel
        self.action = action
    }
}

public struct DestructiveAction: RAlertAction {
    public let title: String
    public let style: UIAlertAction.Style
    public let action: RAlertActionHandler
    
    public init(_ title: String, action: @escaping RAlertActionHandler = {}) {
        self.title = title
        self.style = .destructive
        self.action = action
    }
}
#endif
