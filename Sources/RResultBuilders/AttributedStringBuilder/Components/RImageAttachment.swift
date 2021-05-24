//
//  RImageAttachment.swift
//  RResultBuilders
//

#if !os(watchOS)

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif


/// Component to insert image in attributed string
public struct RImageAttachment: RAttributedComponent {
    public let attributedString: NSAttributedString
    
    // MARK:- Initializer
    public init(image: RImage, size: CGSize? = nil) {
        let attachment = NSTextAttachment()
        attachment.image = image
        
        if let size = size {
            let aspectRatio = image.size.width / image.size.height
            var newSize = size
            if size.width > size.height {
                newSize.height = size.width / aspectRatio
            } else {
                newSize.width = size.height * aspectRatio
            }
            
            attachment.bounds.size = newSize
        }
        
        attributedString = NSAttributedString(attachment: attachment)
    }
}

#endif
