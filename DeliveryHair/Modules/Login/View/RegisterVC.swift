//
//  RegisterVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 28/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class RegisterVC: LoginBaseVC {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        titleLabel.attributedText = NSAttributedString.loginTitle
    }
}

extension RegisterVC {
    @IBAction func didPressRegisterButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: kSegueToRegisterAddressVC, sender: self)
    }
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
