//
//  DeliveryHairTextField.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 27/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class DeliveryHairTextField: UITextField {
    
    var textRect = CGRect()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        tintColor = UIColor.VisualIdentity.darkPink
        layer.borderColor = UIColor.VisualIdentity.darkPink.cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 8
        
        
        rightViewMode = .always
        switch tag {
        case 0:
            rightView = UIImageView(image: UIImage.Icons.icon_phone)
        case 1:
            rightView = UIImageView(image: UIImage.Icons.icon_vision_off)
        case 2:
            rightView = UIImageView(image: UIImage.Icons.icon_username)
        case 3:
            rightView = UIImageView(image: UIImage.Icons.icon_mail)
        default:
            break
        }
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= 10
        return textRect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0.0,
                                   left: 10.0,
                                   bottom: 0.0,
                                   right: rightView!.frame.width + 15
        )
        return bounds.inset(by: padding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0.0,
                                   left: 10.0,
                                   bottom: 0.0,
                                   right: rightView!.frame.width + 15
        )
        return bounds.inset(by: padding)
    }
}
