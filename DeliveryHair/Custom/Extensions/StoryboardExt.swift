//
//  StoryboardExt.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 27/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    // storyboards
    private static var LoginStb: UIStoryboard {
        return UIStoryboard(name: "Login", bundle: Bundle.main)
    }
    
    enum ViewController {
        
        static var loginVC: LoginVC {
            return UIStoryboard.LoginStb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        }
        
    }
}
