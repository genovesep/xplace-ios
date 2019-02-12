//
//  RegisterAddressVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 28/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class RegisterAddressVC: LoginBaseVC {

    @IBOutlet weak var titleLabel:              UILabel!
    @IBOutlet weak var cepTextField:            DeliveryHairTextField!
    @IBOutlet weak var ufTextField:             DeliveryHairTextField!
    @IBOutlet weak var cityTextField:           DeliveryHairTextField!
    @IBOutlet weak var neighTextField:          DeliveryHairTextField!
    @IBOutlet weak var streetTextField:         DeliveryHairTextField!
    @IBOutlet weak var complementTextField:     DeliveryHairTextField!
    @IBOutlet weak var numberTextField:         DeliveryHairTextField!
    @IBOutlet weak var refTextField:            DeliveryHairTextField!
    @IBOutlet weak var dhRegisterButton:        DeliveryHairButton!
    
    var registerdUserId: Int!
    
    var cep: String {
        get { return (cepTextField.text?.replacingOccurrences(of: "-", with: ""))! }
        set { }
    }
    
    var uf: String {
        get { return (ufTextField?.text)! }
        set { }
    }
    
    var city: String {
        get { return (cityTextField?.text)! }
        set { }
    }
    
    var neigh: String {
        get { return (neighTextField?.text)! }
        set { }
    }
    
    var street: String {
        get { return (streetTextField?.text)! }
        set { }
    }
    
    var complement: String {
        get { return (complementTextField?.text)! }
        set { }
    }
    
    var number: String {
        get { return (numberTextField?.text)! }
        set { }
    }
    
    var reference: String {
        get { return (refTextField?.text)! }
        set { }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        titleLabel.attributedText   = NSAttributedString.loginTitle
        cepTextField.delegate       = self
        ufTextField.delegate        = self
    }
    
    func checkRequiredData() -> Bool {
        guard
            let _ = cepTextField.text,        cepTextField.text != "",
            let _ = ufTextField.text,         ufTextField.text != "",
            let _ = cityTextField.text,       cityTextField.text != "",
            let _ = neighTextField.text,      neighTextField.text != "",
            let _ = streetTextField.text,     streetTextField.text != "",
            let _ = complementTextField.text, complementTextField.text != "",
            let _ = numberTextField.text,     numberTextField.text != "",
            let _ = refTextField.text,        refTextField.text != ""
        else { return false }
        return true
    }
    
    func populateTextFields(withAddressInfo info: RegisterCepResponse) {
        DispatchQueue.main.async {
            self.ufTextField.text            = info.uf
            self.cityTextField.text          = info.localidade
            self.neighTextField.text         = info.bairro
            self.streetTextField.text        = info.logradouro
            self.complementTextField.text    = info.complemento
        }
    }
}

extension RegisterAddressVC {
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        if checkRequiredData() {
            LoadingVC.sharedInstance.show()
            let address = RegisterAddress(userId: registerdUserId, cep: cep, logradouro: street, numero: number, complemento: complement, referencia: reference, bairro: neigh, cidade: city, uf: uf)
            PostRequest.sharedInstance.post(url: String.Services.POST.registerAddress, payload: address.payload(), onSuccess: { (response: SuccessObject<GenericMessageResponse>) in
                LoadingVC.sharedInstance.hide()
                print(response.object)
                DispatchQueue.main.async {
                    self.navigationController?.viewControllers.forEach({ (controller) in
                        if controller.isKind(of: LoginVC.self) {
                            self.navigationController?.popToViewController(controller, animated: true)
                        }
                    })
                }
            }) { (response) in
                LoadingVC.sharedInstance.hide()
                // TODO - Error
            }
        } else {
            LoadingVC.sharedInstance.hide()
            // TODO = Error
        }
    }
}

extension RegisterAddressVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == cepTextField {
            guard let cep = textField.text else { return }
            LoadingVC.sharedInstance.show()
            GetRequest.sharedInstance.get(url: String.Services.GET.cep + "\(cep)/json/", onSuccess: { (response: SuccessObject<RegisterCepResponse>) in
                LoadingVC.sharedInstance.hide()
                self.populateTextFields(withAddressInfo: response.object)
            }) { (response) in
                LoadingVC.sharedInstance.hide()
                // TODO - error
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        if (isBackSpace == -92) {
            return true
        } else {
            let currentCharacterCount = ((textField.text?.count)! + string.count) - 1
            
            switch (textField, currentCharacterCount) {
            case (self.cepTextField, 8):
                self.cepTextField.text?.append(string)
            case (self.ufTextField, 1):
                self.ufTextField.text?.append(string)
            default:
                break
            }
        }
        
        if textField == cepTextField {
            let noDigits = CharacterSet.decimalDigits.inverted
            if (string.rangeOfCharacter(from: noDigits) != nil) {
                return false
            }
            
            guard let cep = cepTextField.text else { return true }
            let txtLength = cep.count + string.count - range.length
            
            if txtLength == 6 {
                textField.text?.append("-")
            }
            
            return txtLength <= 9
        }
        
        if textField == ufTextField {
            guard let uf = ufTextField.text else { return true }
            let txtLength = uf.count + string.count - range.length
            return txtLength <= 2
        }
        
        return true
    }
}
