//
//  MyProfileVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 13/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class MyProfileVC: UIViewController, Storyboarded {

    @IBOutlet weak var profileImageView:    UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var containerTopConstraint: NSLayoutConstraint!
    
    private var username: String {
        get { return usernameLabel.text ?? ""}
        set { usernameLabel.text = newValue }
    }
    
    private var phone: String {
        get { return phoneLabel.text ?? ""}
        set { phoneLabel.text = newValue }
    }
    
    private var email: String {
        get { return emailLabel.text ?? "" }
        set { emailLabel.text = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        switch GenericMethods.sharedInstance.getDevice() {
        case .iPhone_8:
            containerTopConstraint.constant = 50
        case .iPhone_8_Plus:
            containerTopConstraint.constant = 50
        case .iPhone_SE:
            containerTopConstraint.constant = 50
        case .iPhone_X:
            containerTopConstraint.constant = 100
        }
        
        do {
            guard let userData = try UserDefaults.standard.get(objectType: ResponseLogin.self, forKey: DefaultsIds.loginData) else { return }
            username = userData.username
            phone = userData.getFormattedNumber()
            email = userData.email
        } catch CustomError.couldNotGetCodableObjectInUserDefaults {
            print(ErrorMessages.couldNotGetCodableObjectInUserDefaults)
        } catch let err {
            print("SYSTEM: ",err.localizedDescription)
        }
    }
}
