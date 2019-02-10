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
            
            static var cep: String { // completar com <num cep>/json/
                return "https://viacep.com.br/ws/"
            }
        }
        
        enum POST {
            static var regisiterUser: String {
                return host + "/api/register"
            }
            
            static var registerAddress: String {
                return host + "/api/address"
            }
            
            static var login: String {
                return host + "/api/login"
            }
        }
    }
    
    static var get: String { return "GET" }
    static var put: String { return "PUT" }
    static var post: String { return "POST" }
    static var delete: String { return "DELETE" }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
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
