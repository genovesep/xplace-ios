//
//  GenericMethods.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 01/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation
import UIKit

enum Device: CGFloat {
    case iPhone_SE = 568.0
    case iPhone_8 = 667.0
    case iPhone_8_Plus = 736.0
    case iPhone_X = 812.0
}

class GenericMethods {
    static let sharedInstance = GenericMethods()
    
    private init() {}
    
    // Generic function to get the Device name
    func getDevice() -> Device {
        let height = UIScreen.main.bounds.height
        return Device(rawValue: height)!
    }
    
    // Func to get the value for cell height in MainVC
    func getCellHeight(forDevice device: Device) -> Double {
        switch device {
        case .iPhone_SE:
            return 236
        case .iPhone_8:
            return 286
        case .iPhone_8_Plus:
            return 309
        case .iPhone_X:
            return 286
        }
    }
    
    func save(cart: Cart) {
        do {
            let encoder = try JSONEncoder().encode(cart)
            UserDefaults.standard.set(encoder, forKey: DefaultsIDs.cartIdentifier)
        } catch let err {
            print("FAILED TO ENCODE: ", err.localizedDescription)
        }
    }
    
    func flatFormat(phoneNumber number: String) -> String {
        return number.replacingOccurrences(of: "(", with: "")
                     .replacingOccurrences(of: ")", with: "")
                     .replacingOccurrences(of: "-", with: "")
    }
    
    func checkIf(cartHasDummyProduct cart: Cart) -> Bool {
        if cart.products.count == 1 {
            let product = cart.products[0]
            if product.qtt == 0 {
                return true
            }
        }
        return false
    }
}
