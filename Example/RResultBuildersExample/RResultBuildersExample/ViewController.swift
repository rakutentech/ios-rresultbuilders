//
//  ViewController.swift
//  RResultBuildersExample
//

import UIKit
import RResultBuilders

class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RResultBuilders"
        // Do any additional setup after loading the view.        
        stackView.distribution = .equalSpacing
        stackView.alignment = .top
        
        // Render below examples
        example1()
        example2()
        example3()
        example4()
        example5()
        example6()
        example7()
        
        huggingLabel()
    }
    
    // MARK: - Attributed string
    private var displayLabel: UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }
    
    private func example1() {
        let label = displayLabel
        
//-----------------------------------------------------//
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
//-----------------------------------------------------//
        
        
        label.attributedText = text
        stackView.addArrangedSubview(label)
    }
    
    private func example2() {
        let label = displayLabel
        
//-----------------------------------------------------//
        let attributedString = NSAttributedString {
            RText("This")
                .font(.boldSystemFont(ofSize: 30))
            RText(" string")
                .font(.italicSystemFont(ofSize: 25))
            RText(" is")
                .font(UIFont(name: "HelveticaNeue-BoldItalic", size: 40)!)
            RText(" having")
                .font(UIFont(name: "HelveticaNeue-ThinItalic", size: 40)!)
                .foregroundColor(.blue)
            RText(" multiple")
                .font(UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!)
                .foregroundColor(.red)
            RText(" font")
        }
        .font(.systemFont(ofSize: 30))
//-----------------------------------------------------//
        
        label.attributedText = attributedString
        stackView.addArrangedSubview(label)
    }
    
    private func example3() {
        let label = displayLabel
        
//-----------------------------------------------------//
        let attributedString = NSAttributedString {
            RText("I love swift and SwiftUI ???")
                .stroke(width: 2, color: .red)
        }
        .font(.systemFont(ofSize: 40))
        
        label.attributedText = attributedString
        stackView.addArrangedSubview(label)
    }
//-----------------------------------------------------//
    
    private func example4() {
        let label = displayLabel
        
        let folderIcon = UIImage(systemName: "folder")!
            .withRenderingMode(.alwaysTemplate)
//-----------------------------------------------------//
        let text = NSAttributedString {
            RText("Folder ")
            RImageAttachment(image: folderIcon, size: CGSize(width: 30, height: 30))
        }
        .foregroundColor(.red)
        .font(.systemFont(ofSize: 30))
 //-----------------------------------------------------//
        
        label.attributedText = text
        stackView.addArrangedSubview(label)
    }
    
    private func example5() {
        let label = displayLabel
        
        // This is with control statements
        let shouldIDrinkCoffee = true
//-----------------------------------------------------//
        let attributedString = NSAttributedString {
            RText("Is it coffee time?")
            RLineBreak(count: 1)
            if shouldIDrinkCoffee {
                RText("Yes i should drink coffee")
                    .foregroundColor(.magenta)
                    .font(.boldSystemFont(ofSize: 30))
            } else {
                RText("No it's not coffee time")
                    .foregroundColor(.red)
                    .font(.boldSystemFont(ofSize: 30))
            }
        }
        .font(.boldSystemFont(ofSize: 40))
//-----------------------------------------------------//
        
        
        label.attributedText = attributedString
        stackView.addArrangedSubview(label)
    }
    
    private func example6() {
        let label = displayLabel
        
        enum Apple {
            case iPhone
            case mac
            case airpod
        }
        
        let appleDevice = Apple.iPhone
//-----------------------------------------------------//
        let attributedString = NSAttributedString {
            RText("Switch-Case ")
            switch appleDevice {
            case .iPhone:
                RText("is iPhone")
                    .foregroundColor(.blue)
            default:
                RText("is Apple silicon")
            }
        }
        .font(.boldSystemFont(ofSize: 40))
//-----------------------------------------------------//
        
        label.attributedText = attributedString
        stackView.addArrangedSubview(label)
    }
    
    
    private func example7() {
        let label = displayLabel
        
        enum Apple: String, CaseIterable {
            case iPhone
            case mac
            case airpod
            
            var color: UIColor {
                switch self {
                case .iPhone:
                    return .blue
                case .mac:
                    return .gray
                case .airpod:
                    return .magenta
                }
            }
            
            var font: UIFont {
                switch self {
                case .iPhone:
                    return .boldSystemFont(ofSize: 30)
                case .mac:
                    return .systemFont(ofSize: 20)
                case .airpod:
                    return .systemFont(ofSize: 50)
                }
            }
        }
        
        let appleDevices = Apple.allCases
//-----------------------------------------------------//
        let attributedString = NSAttributedString {
            for device in appleDevices {
                RText(device.rawValue)
                    .foregroundColor(device.color)
                    .font(device.font)
                RSpace()
            }
        }
        .font(.boldSystemFont(ofSize: 40))
//-----------------------------------------------------//
        
        label.attributedText = attributedString
        stackView.addArrangedSubview(label)
    }
    
    // Just occupy bottom space
    private func huggingLabel() {
        let label = displayLabel
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        stackView.addArrangedSubview(label)
    }
    
    
    // MARK: - Alert/ActionSheet
    @IBAction func didPressShowAlert(_ sender: Any) {
        /// Toggle commenting one of the method to swtich betwen `alert` and `action sheet`
//        showDSLAlert()
        showDSLAlert1()
//        showDSLActionSheet(sender: sender)
    }
    
    private func showDSLAlert() {
        let optional: Int? = 2
//-----------------------------------------------------//
        let alert = UIAlertController(
            title: "Delete all data?",
            message: "All your data will be deleted!") {
            DestructiveAction("Yes, Delete it All") {
                print("Deleting all data")
            }
            
            DefaultAction("Show More Options") {
                print("showing more options")
            }
            
            CancelAction("No, Don't Delete Anything")
            
            if let opt = optional {
                DefaultAction("Pick optional val: \(opt)") {
                    print("selected optional value: \(opt)")
                }
            }
        }
//-----------------------------------------------------//
        
        present(alert, animated: true)
    }
    
    
    private func showDSLAlert1() {
        let actions: [RAlertAction] = [
            DestructiveAction("Yes, Delete it All") {
                print("Deleting all data")
            },
            DefaultAction("Show More Options") {
                print("showing more options")
            },
            CancelAction("No, Don't Delete Anything")
        ]
//-----------------------------------------------------//
        // Using loop
        let alert = UIAlertController(
            title: "Delete all data?",
            message: "All your data will be deleted!") {
            for action in actions {
                action
            }
        }
//-----------------------------------------------------//
        
        present(alert, animated: true)
    }
    
    private func showDSLActionSheet(sender: Any) {
        let optional: Int? = 100
        
        enum Apple {
            case iPhone
            case mac
            case airpod
        }
        
        let appleDevice = Apple.iPhone
        
//-----------------------------------------------------//
        let alert = UIAlertController(
            title: "Delete all data?",
            message: "All your data will be deleted!",
            style: .actionSheet) {
            DestructiveAction("Yes, Delete it All") {
                print("Deleting all data")
            }
            
            DefaultAction("Show More Options") {
                print("selected more options")
            }
            
            CancelAction("No, Don't Delete Anything")
            
            switch appleDevice {
            case .iPhone:
                DefaultAction("Switch-Case is iPhone") {
                    print("selected iPhone")
                }
            case .mac:
                DefaultAction("Switch-Case is mac") {
                    print("selected mac")
                }
            default:
                DefaultAction("Switch-Case is AR glass") {
                    print("selected AR glass")
                }
            }
            
            if let opt = optional {
                DefaultAction("Pick optional val: \(opt)") {
                    print("selected optional value: \(opt)")
                }
            }
        }
//-----------------------------------------------------//
        
        alert.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        alert.popoverPresentationController?.sourceView = self.view
        present(alert, animated: true)
    }
}

