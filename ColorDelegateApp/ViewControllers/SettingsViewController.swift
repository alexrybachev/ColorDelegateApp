//
//  SettingsViewController.swift
//  ColorDelegateApp
//
//  Created by Aleksandr Rybachev on 18.03.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var previewColorView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redColorTextFlied: UITextField!
    @IBOutlet var greenColorTextField: UITextField!
    @IBOutlet var blueColorTextField: UITextField!
    
    // MARK: View Properties
    var colorPreviewView: UIColor!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewColorView.backgroundColor = colorPreviewView
    }
    
    override func viewWillLayoutSubviews() {
        previewColorView.layer.cornerRadius = 10
    }
    
    // MARK: - IBActions
    @IBAction func changeColorSlider(_ sender: UISlider) {
    }
    

}

// MARK: - AlertController
extension SettingsViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = self.string(for: Double(0))
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Convert to String
extension SettingsViewController {
    private func string(for float: Double) -> String {
        String(format: "%.2f", float)
    }
}


extension SettingsViewController {
    
}
