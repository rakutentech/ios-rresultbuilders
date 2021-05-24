//
//  Constants.swift
//  

#if canImport(UIKit)
import UIKit
public typealias RFont = UIFont
public typealias RColor = UIColor
public typealias RImage = UIImage
#elseif canImport(AppKit)
import AppKit

public typealias RFont = NSFont
public typealias RColor = NSColor
public typealias RImage = NSImage
#endif
