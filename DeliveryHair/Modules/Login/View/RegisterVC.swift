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
        titleLabel.attributedText = NSAttributedString.loginTitle
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
            PostRequest.sharedInstance.post(url: String.Services.POST.regisiterUser, payload: user.payload(), onSuccess: { (response: SuccessObject<RegisterUserResponse>) in
                LoadingVC.sharedInstance.hide()
                print(response)
                let status = response.object.status
                if status {
                    DispatchQueue.main.async {
                        let userId = response.object.user?.id
                        let vc = UIStoryboard.ViewController.registerAddressVC
                        vc.registerdUserId = userId
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    
                }
            }) { (response) in
                // TODO - ERROR
            }
        } else {
            // TODO - ERROR
        }
    }
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
