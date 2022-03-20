//
//  SettingsViewController.swift
//  ColorDelegateApp
//
//  Created by Aleksandr Rybachev on 18.03.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var settingColorView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    @IBOutlet var redColorTextField: UITextField!
    @IBOutlet var greenColorTextField: UITextField!
    @IBOutlet var blueColorTextField: UITextField!
    
    // MARK: View Properties
    var colorPreview: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settingColorView.layer.cornerRadius = 10
        
        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self
        
        settingColorView.backgroundColor = colorPreview
        setSliders(colorPreview)
        setLabels()
        setTextFields()
        
        addToolBar(redColorTextField, greenColorTextField, blueColorTextField)
    }
    
    // MARK: - IBActions
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
        
        switch sender {
        case redColorSlider:
            redColorLabel.text = string(redColorSlider.value)
            redColorTextField.text = string(redColorSlider.value)
        case greenColorSlider:
            greenColorLabel.text = string(greenColorSlider.value)
            greenColorTextField.text = string(greenColorSlider.value)
        default:
            blueColorLabel.text = string(blueColorSlider.value)
            blueColorTextField.text = string(blueColorSlider.value)
        }
    }
    
    @IBAction func doneButtonPressed() {
        dismiss(animated: true)
    }
}

// MARK: - Setup Color
extension SettingsViewController {
    /// Set color of view
    private func setColor() {
        settingColorView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
    
    /// Extract color components from uicolor
    private func setSliders(_ colorView: UIColor) {
        let ciColor = CIColor(color: colorView)

        redColorSlider.value = Float(ciColor.red)
        greenColorSlider.value = Float(ciColor.green)
        blueColorSlider.value = Float(ciColor.blue)
    }
    
    /// Update values of labels from sliders
    private func setLabels() {
        redColorLabel.text = string(redColorSlider.value)
        greenColorLabel.text = string(greenColorSlider.value)
        blueColorLabel.text = string(blueColorSlider.value)
    }
    
    /// Update values of textfields from sliders
    private func setTextFields() {
        redColorTextField.text = string(redColorSlider.value)
        greenColorTextField.text = string(greenColorSlider.value)
        blueColorTextField.text = string(blueColorSlider.value)
    }
}

// MARK: - Convert to String
extension SettingsViewController {
    private func string(_ float: Float) -> String {
        String(format: "%.2f", float)
    }
}

// MARK: - UITextFiledDelegate
extension SettingsViewController: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text, !newValue.isEmpty else {
            showAlert(title: "Error!", message: "Input some number from 0.0 to 1.0", textField: textField)
            
            return
        }
        
        guard let number = Float(newValue), (0...1).contains(number) else {
            showAlert(title: "Error!", message: "Input correct number from 0.0 to 1.0", textField: textField)
            return
        }
        
        switch textField {
        case redColorTextField:
            redColorSlider.value = number
            redColorLabel.text = string(number)
        case greenColorTextField:
            greenColorSlider.value = number
            greenColorLabel.text = string(number)
        default:
            blueColorSlider.value = number
            blueColorLabel.text = string(number)
        }
        
        setColor()
    }
}

// MARK: - AlertController
extension SettingsViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = "0"
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UIToolbarDelegate
extension SettingsViewController {
    /// Add buttons on toolbar
    private func addToolBar(_ textfields: UITextField...) {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        let nextButton = UIBarButtonItem(title: "Next",
                                         style: .plain,
                                         target: self,
                                         action: #selector(nextPressed))
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(donePressed))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                         target: nil,
                                         action: nil)
        
        let items = [nextButton, flexButton, doneButton]
        toolBar.setItems(items, animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        for textField in textfields {
            textField.inputAccessoryView = toolBar
        }
    }
    
    @objc private func nextPressed() {
        if redColorTextField.isEditing {
            greenColorTextField.becomeFirstResponder()
        } else if greenColorTextField.isEditing {
            blueColorTextField.becomeFirstResponder()
        } else {
            redColorTextField.becomeFirstResponder()
        }
    }
    
    @objc private func donePressed() {
        guard let color = settingColorView.backgroundColor else { return }
        view.endEditing(true)
        delegate.setColor(for: color)
        dismiss(animated: true)
        
    }
}
