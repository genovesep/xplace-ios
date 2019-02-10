//
//  ResponseLogin.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 10/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct ResponseLogin: Codable {
    let status: Bool
    let msg: String?
    let userId: Int
    let username, email, celNumber, profilePhoto: String
    let addresses: [Address]
    let userRole: UserRole
    let userCards: [UserCard]
    
    enum CodingKeys: String, CodingKey {
        case status, username, email, addresses, msg
        case userId         = "user_id"
        case celNumber      = "cel_number"
        case profilePhoto   = "profile_photo"
        case userRole       = "user_role"
        case userCards      = "user_cards"
    }
}

struct Address: Codable {
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
}

struct UserRole: Codable {
    let
        roleName,
        slug
    : String
    
    enum CodingKeys: String, CodingKey {
        case roleName = "role_name"
        case slug
    }
}

struct UserCard: Codable {
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
