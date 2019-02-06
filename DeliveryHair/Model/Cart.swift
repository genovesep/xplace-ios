//
//  Cart.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 04/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct Cart: Codable {
    var products: [CartItem]
}

struct CartItem: Codable {
    var qtt: Int
    var product: Product
}
