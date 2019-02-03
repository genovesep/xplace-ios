//
//  RegisterAddressVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 28/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class RegisterAddressVC: LoginBaseVC {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dhRegisterButton: DeliveryHairButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillLayoutSubviews() {
        //dhRegisterButton.enableButton()
    }
    
    func setupView() {
        titleLabel.attributedText = NSAttributedString.loginTitle
    }
}

extension RegisterAddressVC {
    @IBAction func didPressBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
