//
//  RegisterCepResponse.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 09/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct RegisterCepResponse: Codable {
    let
        cep,
        logradouro,
        complemento,
        bairro,
        localidade,
        uf,
        unidade,
        ibge,
        gia
    : String
}
