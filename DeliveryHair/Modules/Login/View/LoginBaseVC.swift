//
//  LoginBaseVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 28/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class LoginBaseVC: UIViewController {

    var topView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func setBackground() {
        topView.backgroundColor = Colors.darkPink
        view.addSubview(topView)
        view.sendSubviewToBack(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        topView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
    }
}
