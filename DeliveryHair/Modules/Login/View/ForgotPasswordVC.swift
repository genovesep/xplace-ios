//
//  ForgotPasswordVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 28/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class ForgotPasswordVC: LoginBaseVC {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dhResetPasswordButton: DeliveryHairButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillLayoutSubviews() {
        //dhResetPasswordButton.enableButton()
    }
    
    func setupView() {
        titleLabel.attributedText = NSAttributedString.loginTitle
    }
}

extension ForgotPasswordVC {
    @IBAction func didPressBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
