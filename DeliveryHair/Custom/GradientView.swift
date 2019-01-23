//
//  GradientView.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 21/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

@IBDesignable
final class GradientView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
}
