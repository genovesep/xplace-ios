//
//  CardVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 16/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class CardVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var cardNameTextField: DeliveryHairTextField!
    @IBOutlet weak var cardNumberTextField: DeliveryHairTextField!
    @IBOutlet weak var cardVencDateTextField: DeliveryHairTextField!
    @IBOutlet weak var addCardButton: DeliveryHairButton!
    
    private var dispatchGroup = DispatchGroup()
    private var responseCard: Card?
    
    private var cardName: String {
        get { return cardNameTextField.text ?? "" }
        set { }
    }
    
    private var cardNumber: String {
        get { return cardNumberTextField.text ?? "" }
        set { }
    }
    
    private var cardVencDate: String {
        get { return cardVencDateTextField.text ?? "" }
        set { }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        cardNameTextField.delegate          = self
        cardNumberTextField.delegate        = self
        cardVencDateTextField.delegate      = self
        addCardButton.disableButton()
    }
    
    private func checkRequired() {
        guard
            let _ = cardNameTextField.text, cardNameTextField.text != "",
            let _ = cardNumberTextField.text, cardNumberTextField.text != "",
            let _ = cardVencDateTextField.text, cardVencDateTextField.text != "", cardVencDateTextField.text?.count == 5 else {
                addCardButton.disableButton()
                return
        }
        addCardButton.setupView()
    }
}

extension CardVC {
    @IBAction func addCardButtonTapped(_ sender: UIButton) {
        dispatchGroup.enter()
        LoadingVC.sharedInstance.show()
        guard let userData = try! UserDefaults.standard.get(objectType: ResponseLogin.self, forKey: DefaultsIds.loginData) else { return }
        let cardToRegister = Card(userId: userData.userId, cardName: cardName, cardNumber: cardNumber, cardVencDate: cardVencDate)
        PostRequest.sharedInstance.post(url: Services.addCard, payload: cardToRegister.generatePayload(), onSuccess: { (response: SuccessObject<Card>) in
            LoadingVC.sharedInstance.hide()
            self.responseCard = response.object
            self.dispatchGroup.leave()
        }) { (response) in
            LoadingVC.sharedInstance.hide()
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            if let card = self.responseCard {
                guard let genericResponse = card.genericResponse else { return }
                if genericResponse.status {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    // TODO - Error
                }
            } else {
                // TODO - error (could not parse codable object or system error)
            }
        }
    }
}

extension CardVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checkRequired()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkRequired()
        if textField == cardNameTextField {
            textField.text = textField.text?.uppercased()
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
            case (self.cardVencDateTextField, 4):
                self.cardVencDateTextField.text?.append(string)
            default:
                break
            }
        }
        
        // Card Number
        if textField == cardNumberTextField {
            let noDigits = CharacterSet.decimalDigits.inverted
            if (string.rangeOfCharacter(from: noDigits) != nil) {
                return false
            }
            
            guard let number = cardNumberTextField.text else { return true }
            let txtLength = number.count + string.count - range.length
            
            guard let char = number.first else { return true }
            let fChar = String(char)
            if fChar != "1" && fChar != "7" && fChar != "9" && fChar != "0" {
                switch CardType(rawValue: Int(fChar)!)! {
                case .mastercard, .discover, .visa:
                    if txtLength == 5 {
                        textField.text?.append(" ")
                    } else if txtLength == 10 {
                        textField.text?.append(" ")
                    } else if txtLength == 15 {
                        textField.text?.append(" ")
                    }
                    return txtLength <= 19
                case .americanExpress:
                    if txtLength == 5 {
                        textField.text?.append(" ")
                    } else if txtLength == 12 {
                        textField.text?.append(" ")
                    }
                    return txtLength <= 16
                case .enRoute:
                    if txtLength == 5 {
                        textField.text?.append(" ")
                    } else if txtLength == 13 {
                        textField.text?.append(" ")
                    }
                    return txtLength <= 17
                case .voyager:
                    if txtLength == 6 {
                        textField.text?.append(" ")
                    } else if txtLength == 11 {
                        textField.text?.append(" ")
                    } else if txtLength == 17 {
                        textField.text?.append(" ")
                    }
                    return txtLength <= 18
                }
            } else {
                return false
            }
        }
        
        // Expire Date
        if textField == cardVencDateTextField {
            let noDigits = CharacterSet.decimalDigits.inverted
            if (string.rangeOfCharacter(from: noDigits) != nil) {
                return false
            }
            
            guard let date = cardVencDateTextField.text else { return true }
            let txtLength = date.count + string.count - range.length
            
            if txtLength == 3 {
                textField.text?.append("/")
            }
            
            //checkFields()
            return txtLength <= 5
        }
        
        return true
    }
}
