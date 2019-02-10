//
//  PostRequest.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 09/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

class PostRequest {
    static let sharedInstance = PostRequest()
    
    private init() {}
    
    func post<T: Codable>(url stringUrl: String, payload customPayload : [String:Any], onSuccess: @escaping(_ response: SuccessObject<T>) -> (), onFailure: @escaping(_ response: ErrorObject) -> ()) {
        guard let url = URL(string: stringUrl) else {
            onFailure(ErrorObject(statusCode: nil, message: ErrorMessages.couldNotParseUrl))
            return
        }
        
        var payload: Data!
        do {
            let data = try JSONSerialization.data(withJSONObject: customPayload, options: [])
            payload = data
        } catch {
            onFailure(ErrorObject(statusCode: nil, message: ErrorMessages.couldNotGeneratePayload))
        }
        
        let headers = [
            "Content-Type": "application/json"
        ]
        
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 20.0)
        
        request.httpMethod = "POST"
        request.httpBody = payload
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, res, err) in
            if let err = err {
                onFailure(ErrorObject(statusCode: res != nil ? (res as! HTTPURLResponse).statusCode : nil ,
                                      message: ErrorMessages.responseError + "\nSYSTEM MESSAGE: \(err.localizedDescription)"))
            }
            
            guard let response = res as? HTTPURLResponse else { return }
            let sCode = response.statusCode
            
            guard let data = data else {
                onFailure(ErrorObject(statusCode: sCode, message: ErrorMessages.dataError))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                onSuccess(SuccessObject(statusCode: sCode, object: json))
            } catch {
                onFailure(ErrorObject(statusCode: sCode, message: ErrorMessages.codableParseError))
            }
        }.resume()
    }
    
}
