//
//  Services.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 13/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct Services {
    static var cep                  = "https://viacep.com.br/ws/"
    static var allProducts          = kHost + "/api/products"
    static var regisiterUser        = kHost + "/api/register"
    static var registerAddress      = kHost + "/api/address"
    static var login                = kHost + "/api/login"
    static var resetPassword        = kHost + "/api/password"
    static var getAddressList       = kHost + "/api/address/"
    static var getCardList          = kHost + "/api/payment/credcard/"
}
