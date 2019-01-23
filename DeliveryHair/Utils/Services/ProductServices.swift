//
//  ProductServices.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 16/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

class ProductServices {
    static var shared = ProductServices()
    
    private init() {}
    
    func getAllProducts(completionHandler: @escaping(_ response: [Product]?)->()) {
        guard let url = URL(string: String.Services.GET.allProducts) else { return }
        
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 20.0)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if let error = error {
                print("getAllProducts - ERROR: " + error.localizedDescription)
                completionHandler(nil)
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let parsedData = try decoder.decode([Product].self, from: data)
                    completionHandler(parsedData)
                } catch let e {
                    print("getAllProducts - PARSE ERROR: " + e.localizedDescription)
                    completionHandler(nil)
                }
            } else {
                completionHandler(nil)
            }
            
        }.resume()
    }
    
    
}
