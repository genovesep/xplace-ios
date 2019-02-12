//
//  MenuView.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 21/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

protocol MenuViewDelegate {
    func didPress(homeLoginButton button: Int)
}

class MenuView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!    
    @IBOutlet weak var loginStack1: UIStackView!
    @IBOutlet var loginStack1Buttons: [UIButton]!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var loginStack2: UIStackView!
    
    var username: String? {
        get { return usernameLabel.text }
        set { usernameLabel.text = newValue }
    }
    
    var email: String? {
        get { return emailLabel.text }
        set { emailLabel.text = newValue }
    }
    
    var delegate: MenuViewDelegate?
    var isLoggedIn = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "MenuView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        NotificationCenter.default.addObserver(self, selector: #selector(checkIfIsLoggedIn), name: NSNotification.Name(kIsLoggedIn), object: nil)
    }
    
    @objc func checkIfIsLoggedIn() {
        if let isLoggedIn = UserDefaults.standard.value(forKey: DefaultsIDs.isLoggedIn) as? Bool {
            self.isLoggedIn = isLoggedIn
            if isLoggedIn {
                loadForProfile()
            } else {
                loadForNoProfile()
            }
        } else {
            loadForNoProfile()
        }
    }
    
    func loadForProfile() {
        do {
            let data = try UserDefaults.standard.get(objectType: ResponseLogin.self, forKey: DefaultsIDs.loginData)
            guard let user = data else { return }
            
            DispatchQueue.main.async {
                self.usernameLabel.text = user.getFirstName().capitalized
                self.emailLabel.text = user.email
                
                for (index, button) in self.loginStack1Buttons.enumerated() {
                    switch index {
                    case 0:
                        button.setTitle("Home", for: .normal)
                    case 1:
                        button.setTitle("Minhas compras", for: .normal)
                    case 2:
                        button.setTitle("Carrinho", for: .normal)
                    default:
                        break
                    }
                }
                
                self.middleView.isHidden = false
                self.loginStack2.isHidden = false
            }
        } catch {
            
        }
        
    }
    
    func loadForNoProfile() {
        DispatchQueue.main.async {
            self.usernameLabel.text = "Olá, usuário"
            self.emailLabel.text = "Bem vindo"
            
            for (index, button) in self.loginStack1Buttons.enumerated() {
                switch index {
                case 0:
                    button.setTitle("Entrar/Cadastrar", for: .normal)
                case 1:
                    button.setTitle("", for: .normal)
                case 2:
                    button.setTitle("", for: .normal)
                default:
                    break
                }
            }
            
            self.middleView.isHidden = true
            self.loginStack2.isHidden = true
        }
    }
}

extension MenuView {
    @IBAction func didPressLoginHomeButton(_ sender: UIButton) {
        if isLoggedIn {
            delegate?.didPress(homeLoginButton: 0)
        } else {
            delegate?.didPress(homeLoginButton: 1)
        }
    }
    
    @IBAction func myListButtonTapped(_ sender: UIButton) {
        // TODO - go to list viewController
    }
    
    @IBAction func cartButtonTapped(_ sender: UIButton) {
        delegate?.didPress(homeLoginButton: 2)
    }
    
    @IBAction func myProfileButtonTapped(_ sender: UIButton) {
        // TODO - go to myProfile viewController
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: DefaultsIDs.isLoggedIn)
        UserDefaults.standard.set(nil, forKey: DefaultsIDs.cartIdentifier)
        NotificationCenter.default.post(name: NSNotification.Name(kIsLoggedIn), object: nil)
        delegate?.didPress(homeLoginButton: 0)
    }
}
