//
//  LoginVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 27/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class LoginVC: LoginBaseVC, Storyboarded {
    
    @IBOutlet weak var titleLabel:              UILabel!
    @IBOutlet weak var containerView:           UIView!
    @IBOutlet weak var usernameTextField:       DeliveryHairTextField!
    @IBOutlet weak var passwordTextField:       DeliveryHairTextField!
    @IBOutlet weak var titleLeadConstraint:     NSLayoutConstraint!
    @IBOutlet weak var dhLoginButton:           DeliveryHairButton!
    
    var username: String {
        get { return (usernameTextField?.text)! }
        set { }
    }
    
    var password: String {
        get { return (passwordTextField?.text)! }
        set { }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        usernameTextField.delegate = self
        
        let attributedString           = NSMutableAttributedString(string: "DeliveryHair")
        attributedString.addAttributes([
            NSMutableAttributedString.Key.font : UIFont(name: "Roboto-Medium", size: 50.0)!],
                                       range: NSRange(location: 0, length: 8))
        attributedString.addAttributes([
            NSMutableAttributedString.Key.font : UIFont(name: "GrapeDragon", size: 70.0)!],
                                       range: NSRange(location: 8, length: 4))
        titleLabel.attributedText      = attributedString
        titleLeadConstraint.constant   = returnDeviceType() == .iPhone_SE ? 40 : 50
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(togglePasswordView(_:)))
        tap.numberOfTapsRequired = 1
        passwordTextField.rightView?.addGestureRecognizer(tap)
        passwordTextField.rightView?.isUserInteractionEnabled = true
    }
    
    func returnDeviceType() -> Device? {
        let screen = UIScreen.main.bounds
        return Device(rawValue: screen.size.height)
    }
    
    @objc func togglePasswordView(_ sender: UITapGestureRecognizer) {
        passwordTextField.toggleSecureTextEntry()
    }
}

extension LoginVC {
    @IBAction func didPressRegisterButton(_ sender: UIButton) {
        let vc = RegisterVC.instantiateFromLoginStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didPressForgotPasswordButton(_ sender: UIButton) {
        let vc = ForgotPasswordVC.instantiateFromLoginStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        LoadingVC.sharedInstance.show()
        let loginData = PayloadLogin(celNumber: username, password: password, token: "?")
        PostRequest.sharedInstance.post(url: Services.login, payload: loginData.payload(), onSuccess: { (response: SuccessObject<ResponseLogin>) in
            LoadingVC.sharedInstance.hide()
            let status = response.object.status
            if status {
                let object = response.object
                try! UserDefaults.standard.set(object: object, forKey: DefaultsIds.loginData)
                UserDefaults.standard.set(true, forKey: DefaultsIds.isLoggedIn)
                NotificationCenter.default.post(name: NSNotification.Name(kIsLoggedIn), object: nil)
                
                DispatchQueue.main.async {
                    self.navigationController?.viewControllers.forEach({ (controller) in
                        if controller.isKind(of: MainVC.self) {
                            self.navigationController?.popToViewController(controller, animated: true)
                            self.navigationController?.setNavigationBarHidden(false, animated: true)
                        }
                    })
                }
            } else {
                LoadingVC.sharedInstance.hide()
                // TODO - Error
            }
        }) { (response) in
            LoadingVC.sharedInstance.hide()
            // TODO - Error
        }
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
