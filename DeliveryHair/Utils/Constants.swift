//
//  Constants.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 21/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation

// NOTIFICATION NAMES
let kNSNotificationName_productLoad = "didFinishLoadingProducts"
let kIsLoggedIn = "UserIsLoggedIn"

// CELL IDENTIFIER
let kMainCell = "MainCell"
let kItemMainCell = "ItemMainCell"

// ENUMS
enum RequestHttpMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum CustomError: Error {
    case couldNotParseUrl
    case couldNotParseCodable
    case couldNotSetCodableObjectInUserDefaults
    case couldNotGetCodableObjectInUserDefaults
}


