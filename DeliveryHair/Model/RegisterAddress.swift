//
//  RegisterAddress.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 09/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct RegisterAddress: Codable {
    let userId: Int
    let cep,
        logradouro,
        numero,
        complemento,
        referencia,
        bairro,
        cidade,
        uf
    : String
    
    func payload() -> [String:Any] {
        return [
            "user_id": userId,
            "cep": cep,
            "endereco": logradouro,
            "numero": numero,
            "complemento": complemento,
            "referencia": referencia,
            "bairro": bairro,
            "cidade": cidade,
            "uf": uf
        ]
    }
}
