//
//  CartCell.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 04/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var subButton: UIButton!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addSubContainerView: UIView!
    
    weak var delegate: CartVC?
    
    func customInit(forItem item: CartItem) {
        let product = item.product
        priceLabel.text = Double(product.productPrice)?.toLocalCurrency()
        
        let qtt = item.qtt
        countLabel.text = "\(qtt)"
        
        let total = Double(qtt) * Double(product.productPrice)!
        totalLabel.text = total.toLocalCurrency()
    }

    override func layoutSubviews() {
        addSubContainerView.layer.cornerRadius = addSubContainerView.frame.height/2
    }
}
