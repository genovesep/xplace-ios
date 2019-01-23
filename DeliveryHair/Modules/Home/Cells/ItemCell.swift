//
//  ItemCell.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 16/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var imageView: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func customInit(withProduct product: Product) {        
        self.imageView.backgroundColor = UIColor.gray
        self.titleLabel.text = product.productName
        self.priceLabel.text = Double(product.productPrice)?.toLocalCurrency()
        
        cellContainer.layer.shadowOpacity = 1
        cellContainer.layer.cornerRadius = 5
        cellContainer.layer.shadowRadius = 1
        cellContainer.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        let urlString = String.Services.host + product.productImages.productImage
        imageView.loadImageFrom(urlString: urlString)
    }
}




