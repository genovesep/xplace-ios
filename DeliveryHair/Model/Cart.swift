//
//  Cart.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 04/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

struct Cart: Codable {
    var products: [CartItem]
    
    func getTotal() -> Double {
        var finalPrice = 0.0
        products.forEach { (item) in
            let val = Double(item.product.productPrice)!
            let qtt = Double(item.qtt)
            finalPrice+=(val*qtt)
        }
        return finalPrice
    }
    
    func generateOrderPayload(forUser userId: Int, withAddress addressId: Int, andTransactionId transactionId: String) -> [String:Any] {
        var orderProducts = [[String:Any]]()
        products.forEach { (item) in
            if item.product.productSizes.count > 0 {
                let sizes = item.product.productSizes
                var productOptions = [[String:Any]]()
                sizes.forEach({ (size) in
                    guard let qtt = size.quantity else { return }
                    if qtt > 0 {
                        productOptions.append([
                            "term_id": size.termId,
                            "quantity": qtt
                        ])
                    }
                })
                orderProducts.append([
                    "product_id": item.product.productId,
                    "product_options": productOptions
                ])
            } else if item.product.productColors.count > 0 {
                let colors = item.product.productColors
                var productOptions = [[String:Any]]()
                colors.forEach({ (color) in
                    guard let isSelected = color.selected else { return }
                    if isSelected {
                        productOptions.append([
                            "term_id": color.termId,
                            "quantity": 1
                        ])
                    }
                })
                orderProducts.append([
                    "product_id": item.product.productId,
                    "product_options": productOptions
                ])
            } else {
                orderProducts.append([
                    "product_id": item.product.productId,
                    "product_options": []
                ])
            }
        }
        
        
        return [
            "user_id": userId,
            "address_id": addressId,
            "transaction_id": transactionId,
            "comment": "comentários do pedido", // todo
            "store_id": 0,
            "products": orderProducts
        ]
    }
}

struct CartItem: Codable {
    var qtt: Int
    var product: Product
    
    func getTotal() -> Double {
        let price = Double(product.productPrice)!
        return Double(price * Double(qtt))
    }
}
