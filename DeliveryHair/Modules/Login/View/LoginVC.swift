//
//  LoginVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 27/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class LoginVC: LoginBaseVC {
    
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
        titleLeadConstraint.constant   = returnDeviceType() == .iPhone_SE ? 40 : 100
    }
    
    func returnDeviceType() -> Device? {
        let screen = UIScreen.main.bounds
        return Device(rawValue: screen.size.height)
    }
}

extension LoginVC {
    @IBAction func didPressRegisterButton(_ sender: UIButton) {
        let vc = UIStoryboard.ViewController.registerVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didPressForgotPasswordButton(_ sender: UIButton) {
        let vc = UIStoryboard.ViewController.forgotPasswordVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        LoadingVC.sharedInstance.show()
        let loginData = PayloadLogin(celNumber: username, password: password, token: "?")
        PostRequest.sharedInstance.post(url: String.Services.POST.login, payload: loginData.payload(), onSuccess: { (response: SuccessObject<ResponseLogin>) in
            LoadingVC.sharedInstance.hide()
            let status = response.object.status
            if status {
                let object = response.object
                // we always should have an object to code and sabe to UserDefaults
                // that's why I force unwraped it
                try! UserDefaults.standard.set(object: object, forKey: DefaultsIDs.loginData)
                UserDefaults.standard.set(true, forKey: DefaultsIDs.isLoggedIn)
                
                DispatchQueue.main.async {
                    self.navigationController?.viewControllers.forEach({ (controller) in
                        if controller.isKind(of: MainVC.self) {
                            self.navigationController?.popToViewController(controller, animated: true)
                        }
                    })
                }
            } else {
                // TODO - Error
            }
        }) { (response) in
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
