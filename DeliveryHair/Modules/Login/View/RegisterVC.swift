//
//  RegisterVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 28/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class RegisterVC: LoginBaseVC, Storyboarded {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: DeliveryHairTextField!
    @IBOutlet weak var phoneTextField: DeliveryHairTextField!
    @IBOutlet weak var emailTextField: DeliveryHairTextField!
    @IBOutlet weak var passwordTextField: DeliveryHairTextField!
    @IBOutlet weak var dhRegisterButton: DeliveryHairButton!
    
    private var name: String? {
        get { return usernameTextField?.text }
        set { }
    }
    
    private var email: String? {
        get { return emailTextField?.text }
        set { }
    }
    
    private var phone: String? {
        get { return phoneTextField?.text }
        set { }
    }
    
    private var password: String? {
        get { return passwordTextField?.text }
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
    
    func checkTextFieldCompletion() -> Bool {
        guard let _ = usernameTextField.text, usernameTextField.text != "" else { return false}
        guard let _ = phoneTextField.text, phoneTextField.text != "" else { return false}
        guard let _ = emailTextField.text, emailTextField.text != "" else { return false}
        guard let _ = passwordTextField.text, passwordTextField.text != "" else { return false }
        return true
    }
}

extension RegisterVC {
    @IBAction func didPressRegisterButton(_ sender: UIButton) {
        LoadingVC.sharedInstance.show()
        
        if checkTextFieldCompletion() {
            guard let name = name, let email = email, let phone = phone, let password = password else { return }
            let user = RegisterUser(name: name, email: email, celNumber: phone, password: password)
            PostRequest.sharedInstance.post(url: Services.regisiterUser, payload: user.payload(), onSuccess: { (response: SuccessObject<RegisterUserResponse>) in
                LoadingVC.sharedInstance.hide()
                print(response)
                let status = response.object.status
                if status {
                    DispatchQueue.main.async {
                        let userId = response.object.user?.id
                        let vc = RegisterAddressVC.instantiateFromLoginStoryboard()
                        vc.registerdUserId = userId
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    LoadingVC.sharedInstance.hide()
                    // TODO - ERROR
                }
            }) { (response) in
                LoadingVC.sharedInstance.hide()
                // TODO - ERROR
            }
        } else {
            LoadingVC.sharedInstance.hide()
            // TODO - ERROR
        }
    }
}

extension RegisterVC: UITextFieldDelegate {
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
        
        
        //// TELEFONE CELULAR
        if textField == phoneTextField {
            let noDigits = CharacterSet.decimalDigits.inverted
            if (string.rangeOfCharacter(from: noDigits) != nil) {
                return false
            }
            
            /// Verificar se o campo já atingiu o limite de caracteres
            guard let telefone = phoneTextField.text else { return true }
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
