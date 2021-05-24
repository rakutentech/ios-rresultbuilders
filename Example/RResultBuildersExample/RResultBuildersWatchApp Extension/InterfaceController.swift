//
//  InterfaceController.swift
//  RResultBuildersWatchApp Extension
//

import WatchKit
import Foundation
import RResultBuilders


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var sampleLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
                
        let text = NSAttributedString {
            RText("This ")
            RText("is a ")
                .foregroundColor(.darkGray)
            RText("colorful ")
                .foregroundColor(.purple)
                .font(.systemFont(ofSize: 28))
            RText("attributed ")
                .foregroundColor(.blue)
            RText("string")
                .foregroundColor(.orange)
        }
        .font(.systemFont(ofSize: 30))
        
        
        sampleLabel.setAttributedText(text)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    

}
