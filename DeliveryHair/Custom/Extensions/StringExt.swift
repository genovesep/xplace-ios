//
//  StringExt.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 16/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation
import UIKit

extension String {
    enum Services {
        
        static var host: String {
            return "https://xplace.xsistemas.com.br"
        }
        
        enum GET {
            static var allProducts: String {
                return host + "/api/products"
            }
        }
    }
}

extension NSAttributedString {
    
    static var loginTitle: NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "DeliveryHair")
        attributedString.addAttributes([NSMutableAttributedString.Key.font : UIFont(name: "Roboto-Medium", size: 50.0)!], range: NSRange(location: 0, length: 8))
        attributedString.addAttributes([NSMutableAttributedString.Key.font : UIFont(name: "GrapeDragon", size: 70.0)!], range: NSRange(location: 8, length: 4))
        return attributedString
    }
}
