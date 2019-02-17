//
//  Card.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 14/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct Card: Codable {
    let genericResponse: GenericMessageResponse?
    let userId: Int?
    let cardId: Int?
    let
        cardName,
        cardNumber,
        cardVencDate
    : String
    
    enum CodingKeys: String, CodingKey {
        case status
        case msg
        case userId         = "user_id"
        case cardId         = "card_id"
        case cardName       = "card_name"
        case cardNumber     = "card_number"
        case cardVencDate   = "card_venc_date"
    }
    
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        let status          = try container.decode(Bool.self, forKey: .status)
        let msg             = try container.decode(String.self, forKey: .msg)
        genericResponse     = GenericMessageResponse(status: status, msg: msg)
        userId              = try container.decode(Int.self, forKey: .userId)
        cardId              = try container.decode(Int.self, forKey: .cardId)
        cardName            = try container.decode(String.self, forKey: .cardName)
        cardNumber          = try container.decode(String.self, forKey: .cardNumber)
        cardVencDate        = try container.decode(String.self, forKey: .cardVencDate)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(genericResponse?.status, forKey: .status)
        try container.encode(genericResponse?.msg, forKey: .msg)
        try container.encode(userId, forKey: .userId)
        try container.encode(cardId, forKey: .cardId)
        try container.encode(cardName, forKey: .cardName)
        try container.encode(cardNumber, forKey: .cardNumber)
        try container.encode(cardVencDate, forKey: .cardVencDate)
    }
    
}

extension Card {
    init(userId: Int, cardName: String, cardNumber: String, cardVencDate: String) {
        self.genericResponse = nil
        self.cardId = nil
        self.userId = userId
        self.cardName = cardName
        self.cardNumber = cardNumber
        self.cardVencDate = cardVencDate
    }
    
    func generatePayload() -> [String:Any] {
        return [
            "user_id": self.userId ?? "",
            "card_name": self.cardName,
            "card_number": self.cardNumber.replacingOccurrences(of: " ", with: ""),
            "card_venc_date": self.cardVencDate
        ]
    }
}
