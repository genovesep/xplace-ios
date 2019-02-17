//
//  Constants.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 21/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

// NETWORK
let kHost = "https://xplace.xsistemas.com.br"

// NOTIFICATION NAMES
let kNSNotificationName_productLoad     = "didFinishLoadingProducts"
let kIsLoggedIn                         = "UserIsLoggedIn"

// CELL IDENTIFIER
let kMainCell       = "MainCell"
let kItemMainCell   = "ItemMainCell"

// ENUMS
enum RequestHttpMethod: String {
    case get        = "GET"
    case put        = "PUT"
    case post       = "POST"
    case delete     = "DELETE"
}

enum CustomError: Error {
    case couldNotParseUrl
    case couldNotParseCodable
    case couldNotSetCodableObjectInUserDefaults
    case couldNotGetCodableObjectInUserDefaults
}

enum StoryboardName: String {
    case Main
    case ProductDetail
    case Login
    case Cart
    case Profile
    case Card
}

enum MenuOption {
    case home
    case login
    case myShoppingList
    case cart
    case myProfile
    case logout
}

enum CardType: Int {
    case mastercard = 5
    case visa = 4
    case americanExpress = 3
    case discover = 6
    case enRoute = 2
    case voyager = 8
}

// TWO-CASED ENUMS
