//
//  StartViewController.swift
//  ColorDelegateApp
//
//  Created by Aleksandr Rybachev on 18.03.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColor(for color: UIColor)
}

class StartViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.colorPreview = view.backgroundColor
        settingsVC.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        view.backgroundColor = setRandomColor()
    }
}

// MARK: - Random Color
extension StartViewController {
    private func setRandomColor() -> UIColor {
        UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1
        )
    }
}

// MARK: - SettingsViewControllerDelegate
extension StartViewController: SettingsViewControllerDelegate {
    func setColor(for color: UIColor) {
        view.backgroundColor = color
    }
}

