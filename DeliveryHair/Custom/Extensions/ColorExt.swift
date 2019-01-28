//
//  ColorExt.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 16/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    enum VisualIdentity {
        
        static var purple: UIColor {
            return UIColor(hex: "6A3093")
        }
        
        static var lightPink: UIColor {
            return UIColor(hex: "D04ED6")
        }
        
        static var darkPink: UIColor {
            return UIColor(hex: "A828B1")
        }
        
        static var hotPink: UIColor {
            return UIColor(hex: "FF0084")
        }
    }
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
