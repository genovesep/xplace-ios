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
    
    private static var ProductDetailStb: UIStoryboard {
        return UIStoryboard(name: "ProductDetail", bundle: Bundle.main)
    }
    
    private static var CartStb: UIStoryboard {
        return UIStoryboard(name: "Cart", bundle: Bundle.main)
    }
    
    enum ViewController {
        
        static var loginVC: LoginVC {
            return UIStoryboard.LoginStb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        }
        
        static var ProductDetailVC: ProductDetailVC {
            return UIStoryboard.ProductDetailStb.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        }
        
        static var SelectionVC: SelectionVC {
            return UIStoryboard.ProductDetailStb.instantiateViewController(withIdentifier: "SelectionVC") as! SelectionVC
        }
        
        static var cartVC: CartVC {
            return UIStoryboard.CartStb.instantiateViewController(withIdentifier: "CartVC") as! CartVC
        }
    }
}
