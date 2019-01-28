//
//  LoginVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 27/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class LoginVC: LoginBaseVC {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var usernameTextField: DeliveryHairTextField!
    @IBOutlet weak var passwordTextField: DeliveryHairTextField!
    @IBOutlet weak var titleLeadConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        usernameTextField.delegate = self
        
        let attributedString = NSMutableAttributedString(string: "DeliveryHair")
        attributedString.addAttributes([NSMutableAttributedString.Key.font : UIFont(name: "Roboto-Medium", size: 50.0)!], range: NSRange(location: 0, length: 8))
        attributedString.addAttributes([NSMutableAttributedString.Key.font : UIFont(name: "GrapeDragon", size: 70.0)!], range: NSRange(location: 8, length: 4))
        titleLabel.attributedText = attributedString
        
        titleLeadConstraint.constant = returnDeviceType() == .iPhone_SE ? 40 : 100
    }
    
    func returnDeviceType() -> Device? {
        let screen = UIScreen.main.bounds
        return Device(rawValue: screen.size.height)
    }
}

extension LoginVC {
    @IBAction func didPressRegisterButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: kSegueToRegisterVC, sender: self)
    }
    
    @IBAction func didPressForgotPasswordButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: kSegueToForgetPasswordVC, sender: self)
    }
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        navigationController?.isNavigationBarHidden = false
    }
}

extension LoginVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        if (isBackSpace == -92) {
            return true
        } else {
            let currentCharacterCount = ((textField.text?.count)! + string.count) - 1
            
            switch (textField, currentCharacterCount) {
            case (self.usernameTextField, 13):
                self.usernameTextField.text?.append(string)
            default:
                break
            }
        }
        
        
        //// TELEFONE CELULAR
        if textField == usernameTextField {
            let noDigits = CharacterSet.decimalDigits.inverted
            if (string.rangeOfCharacter(from: noDigits) != nil) {
                return false
            }
            
            /// Verificar se o campo já atingiu o limite de caracteres
            guard let telefone = usernameTextField.text else { return true }
            let txtLength = telefone.count + string.count - range.length
            
            if txtLength == 1 {
                textField.text?.append("(")
            } else if txtLength == 4 {
                textField.text?.append(")")
            } else if txtLength == 10 {
                textField.text?.append("-")
            }
            
            
            //checkFields()
            return txtLength <= 14
        }
        
        return true
    }
}
