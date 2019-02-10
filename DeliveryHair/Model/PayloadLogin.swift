//
//  PayloadLogin.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 09/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct PayloadLogin: Codable {
    let
        celNumber,
        password,
        token
    : String
    
    func celWithoutFormat() -> String {
        return celNumber.replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
    }
    
    func payload() -> [String:Any] {
        return [
            "cel_number": celWithoutFormat(),
            "password": password,
            "token": "?"
        ]
    }
}
