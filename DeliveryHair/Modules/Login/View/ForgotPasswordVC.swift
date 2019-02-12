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
    @IBOutlet weak var phoneTextField: DeliveryHairTextField!
    @IBOutlet weak var dhResetPasswordButton: DeliveryHairButton!
    
    var phone: String {
        get { return (phoneTextField.text)! }
        set { }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        titleLabel.attributedText       = NSAttributedString.loginTitle
        phoneTextField.delegate         = self
    }
}

extension ForgotPasswordVC {
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        LoadingVC.sharedInstance.show()
        guard let phone = phoneTextField.text, phoneTextField.text != "" else { return }
        let flatPhone = GenericMethods.sharedInstance.flatFormat(phoneNumber: phone)
        PostRequest.sharedInstance.post(url: String.Services.POST.resetPassword, payload: ["cel_number":flatPhone], onSuccess: { (response: SuccessObject<GenericMessageResponse>) in
            LoadingVC.sharedInstance.hide()
            let status = response.object.status
            if status {
                print(response.object)
            } else {
                // TODO - ERROR
            }
        }) { (response) in
            LoadingVC.sharedInstance.hide()
            // TODO - ERROR
        }
    }
}

extension ForgotPasswordVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        if (isBackSpace == -92) {
            return true
        } else {
            let currentCharacterCount = ((textField.text?.count)! + string.count) - 1
            
            switch (textField, currentCharacterCount) {
            case (self.phoneTextField, 13):
                self.phoneTextField.text?.append(string)
            default:
                break
            }
        }
        
        if textField == phoneTextField {
            let noDigits = CharacterSet.decimalDigits.inverted
            if (string.rangeOfCharacter(from: noDigits) != nil) {
                return false
            }
            
            guard let telefone = phoneTextField.text else { return true }
            let txtLength = telefone.count + string.count - range.length
            
            if txtLength == 1 {
                textField.text?.append("(")
            } else if txtLength == 4 {
                textField.text?.append(")")
            } else if txtLength == 10 {
                textField.text?.append("-")
            }
            
            return txtLength <= 14
        }
        
        return true
    }
}
