//
//  Product.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 16/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

class Product: Decodable {
    let productId: Int
    let productName, productDescription: String
    let productVendorId: Int
    let productImages: ProductImages
    let productPrice, productManageStockQty: String
    let productCategorys: [ProductCategorys]
}

struct ProductImages: Decodable {
    let productImage,shopBannerImage: String
}

struct ProductCategorys: Decodable {
    let termId: Int
    let name, slug: String
}
