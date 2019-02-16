//
//  Card.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 14/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct Card: Codable {
    let cardId: Int
    let
        cardName,
        cardNumber,
        cardVencDate
    : String
    
    enum CodingKeys: String, CodingKey {
        case cardId         = "card_id"
        case cardName       = "card_name"
        case cardNumber     = "card_number"
        case cardVencDate   = "card_venc_date"
    }
}
