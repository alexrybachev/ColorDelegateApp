//
//  StartViewController.swift
//  ColorDelegateApp
//
//  Created by Aleksandr Rybachev on 18.03.2022.
//

import UIKit

class StartViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.colorPreviewView = view.backgroundColor
    }

}

