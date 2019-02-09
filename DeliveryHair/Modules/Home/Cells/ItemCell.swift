//
//  ItemCell.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 16/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit
import Kingfisher

class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func customInit(withProduct product: Product) {
        self.titleLabel.text = product.productName
        self.priceLabel.text = Double(product.productPrice)?.toLocalCurrency()
        
        cellContainer.layer.shadowOpacity = 1
        cellContainer.layer.cornerRadius = 8
        cellContainer.layer.shadowRadius = 2
        cellContainer.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        if let pImage = product.productImages {
            imageView.downloadImage(fromStringUrl: pImage.productImage)
        }
    }
}




