//
//  RegisterUserResponse.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 09/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct RegisterUserResponse: Codable {
    let status: Bool
    let msg: String
    let user: RegisterUserResponseData?
}

struct RegisterUserResponseData: Codable {
    let id: Int
    let name: String
    let email: String
    let celNumber: String
    
    enum CodingKeys: String, CodingKey {
        case id,name,email
        case celNumber = "cel_number"
    }
}
