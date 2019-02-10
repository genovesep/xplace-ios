//
//  RegisterUser.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 09/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct RegisterUser: Codable {
    let name: String
    let email: String
    let celNumber: String
    let password: String
    
    func celWithoutFormat() -> String {
        return celNumber.replacingOccurrences(of: "(", with: "")
                        .replacingOccurrences(of: ")", with: "")
                        .replacingOccurrences(of: "-", with: "")
    }
    
    func payload() -> [String:Any] {
        return [
            "name": name,
            "email": email,
            "cel_number": celWithoutFormat(),
            "password": password,
            "secret_key": "padrão",
            "user_photo_url": "/",
            "user_status": 0,
            "user_role": "cliente"
        ] as [String:Any]
    }
}
