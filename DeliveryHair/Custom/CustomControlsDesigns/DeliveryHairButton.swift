//
//  DeliveryHairButton.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 27/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class DeliveryHairButton: CustomButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {        
        setTitleColor(UIColor.white, for: .normal)
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 1
        layer.insertSublayer(applyGradient(colours: [UIColor.VisualIdentity.lightPink, UIColor.VisualIdentity.purple]), below: titleLabel?.layer)
    }
}
