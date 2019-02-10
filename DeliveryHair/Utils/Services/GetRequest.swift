//
//  GetRequest.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 09/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

class GetRequest {
    static let sharedInstance = GetRequest()
    
    private init() {}
    
    private var url: String!
    
    func createGetRequest() throws -> URLRequest? {
        guard let url = URL(string: url) else {
            throw CustomError.couldNotParseUrl
        }
        
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 20.0)
        
        request.httpMethod = .get
        return request
    }
    
    func get<T: Codable>(url stringUrl: String, onSuccess: @escaping(_ response: SuccessObject<T>) -> (), onFailure: @escaping(_ response: ErrorObject) -> ()) {
        
        var request: URLRequest!
        do {
            url = stringUrl
            request = try createGetRequest()
        } catch CustomError.couldNotParseUrl {
            onFailure(ErrorObject(statusCode: nil, message: ErrorMessages.couldNotParseUrl))
        } catch let err {
            onFailure(ErrorObject(statusCode: nil, message: err.localizedDescription))
        }
        
        URLSession.shared.dataTask(with: request) { (data, res, err) in
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
            } catch CustomError.couldNotParseCodable {
                onFailure(ErrorObject(statusCode: sCode, message: ErrorMessages.codableParseError))
            } catch let err{
                onFailure(ErrorObject(statusCode: sCode, message: err.localizedDescription))
            }
        }.resume()
    }
}
