//
//  Product.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 16/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct Product: Codable {
    public private(set) var productId: Int
    public private(set) var productName, productDescription: String
    public private(set) var productVendorId: Int
    public private(set) var productImages: ProductImages?
    public private(set) var productPrice: String
    public private(set) var productManageStockQty: String
    public private(set) var productCategorys: [ProductCategorys]
    public private(set) var productSizes: [ProductSize]
    public private(set) var productColors: [ProductColors]
    public private(set) var productQtt: Int?
    
    init() {
        productId = 0
        productName = ""
        productDescription = ""
        productVendorId = 0
        productImages = nil
        productPrice = ""
        productManageStockQty = ""
        productCategorys = []
        productSizes = []
        productColors = []
        productQtt = 0
    }
    
    mutating func setProduct<T>(productIndex index: Int, newProduct: T) {
        if T.self == ProductSize.self {
            productSizes[index] = newProduct as! ProductSize
        } else {
            productColors[index] = newProduct as! ProductColors
        }
    }
    
    mutating func addToQtt(add count: Int) {
        if let _ = productQtt {
            productQtt!+=count
        } else {
            productQtt = count
        }
    }
    
    mutating func subToQtt(sub count: Int) {
        if let _ = productQtt {
            productQtt!-=count
        } else {
            productQtt = 0
        }
    }
}

struct ProductImages: Codable {
    let productImage,shopBannerImage: String
}

struct ProductCategorys: Codable {
    let termId: Int
    let name, slug: String
}

struct ProductSize: Codable {
    let termId: Int
    let name: String
    var quantity: Int? = 0
}

struct ProductColors: Codable {
    let termId: Int
    let name: String
    var selected: Bool? = false
}
