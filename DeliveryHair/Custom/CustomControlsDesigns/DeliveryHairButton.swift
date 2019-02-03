//
//  DeliveryHairButton.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 27/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class DeliveryHairButton: CustomButton {
    
    var gradientLayer: [UIColor] = [UIColor.black, UIColor.white] {
        didSet {
            setGradient(colors: [gradientLayer[0], gradientLayer[1]])
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        gradientLayer = [Colors.lightPink, Colors.darkPink]
        layer.cornerRadius = frame.size.height/2
        layer.masksToBounds = true
        layer.opacity = 1.0
        isEnabled = true
    }
    
    func disableButton() {
        gradientLayer = [Colors.lightGray, Colors.darkGray]
        layer.opacity = 0.6
        isEnabled = false
    }
}
