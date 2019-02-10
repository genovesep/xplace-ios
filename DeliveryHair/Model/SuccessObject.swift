//
//  SuccessObject.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 09/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct SuccessObject<T:Codable> {
    let statusCode: Int
    let object: T
}
