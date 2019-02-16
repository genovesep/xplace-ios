//
//  UIImage+Ext.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 28/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImage {
    enum Icons {
        static var icon_username: UIImage? {
            return UIImage(named: "icon-username")
        }
        
        static var icon_phone: UIImage? {
            return UIImage(named: "icon-phone")
        }
        
        static var icon_mail: UIImage? {
            return UIImage(named: "icon-mail")
        }
        
        static var icon_vision_on: UIImage? {
            return UIImage(named: "icon-vision-on")
        }
        
        static var icon_vision_off: UIImage? {
            return UIImage(named: "icon-vision-off")
        }
        
        static var icon_arrow_back: UIImage? {
            return UIImage(named: "icon-arrow-back")
        }
        
        static var icon_detail_arrow_left: UIImage? {
            return UIImage(named: "icon-detail-arrow-left")
        }
    }
}

extension UIImageView {
    func downloadImage(fromStringUrl stringUrl: String) {
        let stringURL = kHost + stringUrl
        guard let url = URL(string: stringURL) else { return }        
        let resource = ImageResource(downloadURL: url, cacheKey: stringUrl)
        self.kf.setImage(with: resource)
    }
}
