//
//  RoundContainerView.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 27/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

@IBDesignable
class RoundContainerView: UIView {

    @IBInspectable var _cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = _cornerRadius
        }
    }
    
    @IBInspectable var _shadowOpacity: Float = 0.0 {
        didSet {
            self.layer.shadowOpacity = _shadowOpacity
        }
    }
    
    @IBInspectable var _shadowRadius : CGFloat = 0.0 {
        didSet {
            self.layer.shadowRadius = _shadowRadius
        }
    }
    
    @IBInspectable var _shadowOffset : CGSize = CGSize(width: 0, height: 0) {
        didSet {
            self.layer.shadowOffset = _shadowOffset
        }
    }
}
