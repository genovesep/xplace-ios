//
//  NumberExt.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 23/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    func toLocalCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_br")
        return formatter.string(from: self as NSNumber)!
    }
}

extension Int {
    func toDouble() -> Double {
        return Double(exactly: self)!
    }
}
