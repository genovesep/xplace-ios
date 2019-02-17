//
//  ResponseCard.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 16/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct ResponseCard: Codable {
    let cardId: Int
    let cardName, cardNumber, cardVencDate: String
    
    enum CodingKeys: String, CodingKey {
        case cardId             = "card_id"
        case cardName           = "card_name"
        case cardNumber         = "card_number"
        case cardVencDate       = "card_venc_date"
    }
    
    func getCardNumber() -> String {
        guard let fChar = cardNumber.first else { return "" }
        let char = String(fChar)
        let number = NSString(string: cardNumber)
        switch CardType(rawValue: Int(char)!)! {
        case .mastercard, .discover, .visa:
            let oneF        = number.substring(to: 4)
            let twoF        = number.substring(with: NSRange(location: 4, length: 4))
            let threeF      = number.substring(with: NSRange(location: 8, length: 4))
            let fourF       = number.substring(with: NSRange(location: 12, length: 4))
            return "\(oneF) \(twoF) \(threeF) \(fourF)"
        case .americanExpress:
            let oneF        = number.substring(to: 4)
            let twoF        = number.substring(with: NSRange(location: 4, length: 6))
            let threeF      = number.substring(with: NSRange(location: 10, length: 4))
            return "\(oneF) \(twoF) \(threeF)"
        case .enRoute:
            let oneF        = number.substring(to: 4)
            let twoF        = number.substring(with: NSRange(location: 4, length: 7))
            let threeF      = number.substring(with: NSRange(location: 11, length: 4))
            return "\(oneF) \(twoF) \(threeF)"
        case .voyager:
            let oneF        = number.substring(to: 5)
            let twoF        = number.substring(with: NSRange(location: 5, length: 4))
            let threeF      = number.substring(with: NSRange(location: 9, length: 5))
            let fourF       = number.substring(from: 14)
            return "\(oneF) \(twoF) \(threeF) \(fourF)"
        }
    }
}
