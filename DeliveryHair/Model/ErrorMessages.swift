//
//  ErrorMessages.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 09/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct ErrorMessages {
    static let couldNotParseUrl                         = "Não foi possível fazer o parse da URL!"
    static let couldNotGeneratePayload                  = "Não foi possível gerar payload a partir do objeto passado como parâmetro!"
    static let responseError                            = "Erro ao receber resposta do servidor!"
    static let dataError                                = "Erro ao receber dados do servidor!"
    static let codableParseError                        = "Erro ao fazer o parse do objeto!"
    static let couldNotSetCodableObjectInUserDefaults   = "Não foi possível 'setar' o objeto codable no UserDefaults"
    static let couldNotGetCodableObjectInUserDefaults   = "Não foi possível recuperar o objeto codable do UserDefaults"
}
