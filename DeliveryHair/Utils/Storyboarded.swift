//
//  Storyboarded.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 13/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

protocol Storyboarded {}

extension Storyboarded where Self: UIViewController {
    static func instantiateFromMainStoryboard() -> Self {
        let storyboardId = String(describing: self)
        let storyboard = UIStoryboard(name: StoryboardName.Main.rawValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardId) as! Self
    }
    
    static func instantiateFromDetailStoryboard() -> Self {
        let storyboardId = String(describing: self)
        let storyboard = UIStoryboard(name: StoryboardName.ProductDetail.rawValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardId) as! Self
    }
    
    static func instantiateFromLoginStoryboard() -> Self {
        let storyboardId = String(describing: self)
        let storyboard = UIStoryboard(name: StoryboardName.Login.rawValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardId) as! Self
    }
    
    static func instantiateFromCartStoryboard() -> Self {
        let storyboardId = String(describing: self)
        let storyboard = UIStoryboard(name: StoryboardName.Cart.rawValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardId) as! Self
    }
    
    static func instantiateFromProfileStoryboard() -> Self {
        let storyboardId = String(describing: self)
        let storyboard = UIStoryboard(name: StoryboardName.Profile.rawValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardId) as! Self
    }
}
