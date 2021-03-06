//
//  ViewExt.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 21/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    let imageCache = NSCache<NSString, UIImage>()
    
    func loadImageFrom(urlString: String) {
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                guard let img = UIImage(data: data) else { return }
                let imageToCache = img
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                self.imageCache.setObject(imageToCache, forKey: NSString(string: urlString))
            }
        }.resume()
    }
}
