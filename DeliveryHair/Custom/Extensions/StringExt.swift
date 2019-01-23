//
//  StringExt.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 16/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

extension String {
    enum Services {
        
        static var host: String {
            return "https://xplace.xsistemas.com.br"
        }
        
        enum GET {
            static var allProducts: String {
                return host + "/api/products"
            }
        }
    }
}
