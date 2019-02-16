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
