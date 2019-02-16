//
//  Address.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 13/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct Address: Codable {
    let addressId: Int?
    let
    cep,
    endereco,
    numero,
    complemento,
    referencia,
    bairro,
    cidade,
    uf
    : String
    
    enum CodingKeys: String, CodingKey {
        case addressId = "address_id"
        case cep, endereco, numero, complemento,
        referencia, bairro, cidade, uf
    }
}
