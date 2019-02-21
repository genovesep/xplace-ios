//
//  ResponseZoopPayment.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 20/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct ResponseZoopPayment: Codable {
    let genericResponse: GenericMessageResponse?
    let transactionId: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case msg
        case transactionId = "transaction_id"
    }
    
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        let status          = try container.decode(Bool.self, forKey: .status)
        let msg             = try container.decode(String.self, forKey: .msg)
        genericResponse     = GenericMessageResponse(status: status, msg: msg)
        if container.contains(.transactionId) {
            transactionId   = try container.decode(String.self, forKey: .transactionId)
        } else {
            transactionId = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(genericResponse?.status, forKey: .status)
        try container.encode(genericResponse?.msg, forKey: .msg)
        try container.encode(transactionId, forKey: .transactionId)
    }
}
