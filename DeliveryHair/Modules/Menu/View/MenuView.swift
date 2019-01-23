//
//  MenuView.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 21/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

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
        
        loginStack1Buttons.forEach { (button) in
            guard let text = button.titleLabel?.text else { return }
            if text == "Home" {
                button.setTitle("Entrar/Cadastrar", for: .normal)
            } else {
                button.setTitle("", for: .normal)
            }
        }
        
        middleView.isHidden = true
        loginStack2.isHidden = true
    }
    
}
