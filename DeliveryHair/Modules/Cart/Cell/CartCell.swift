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
    var item: CartItem!
    var myIndexPath: IndexPath!
    
    func customInit(forItem item: CartItem) {
        self.item = item
        let product = self.item.product
        productNameLabel.text = product.productName
        priceLabel.text = Double(product.productPrice)?.toLocalCurrency()
        
        let qtt = self.item.qtt
        countLabel.text = "\(qtt)"
        
        let total = Double(qtt) * Double(product.productPrice)!
        totalLabel.text = total.toLocalCurrency()
        
        if let prodImg = product.productImages {
            productImageView.downloadImage(fromStringUrl: prodImg.productImage)
        }
    }
    
    func updateCount() {
        if self.item.qtt <= 0 {
            self.item.qtt = 1
            countLabel.text = "1"
        } else {
            countLabel.text = "\(self.item.qtt)"
        }
        updateTotal()
        delegate?.updateCartItemQtt(withNewQtt: self.item.qtt, andProdIndexPath: myIndexPath)
    }
    
    func updateTotal() {
        let qtt = self.item.qtt
        let product = self.item.product
        let total = Double(qtt) * Double(product.productPrice)!
        totalLabel.text = total.toLocalCurrency()
    }

    override func layoutSubviews() {
        addSubContainerView.layer.cornerRadius = addSubContainerView.frame.height/2
    }
}

extension CartCell {
    @IBAction func addButtonTapped(_ sender: UIButton) {
        item.qtt += 1
        updateCount()
    }
    
    @IBAction func subButtonTapped(_ sender: UIButton) {
        item.qtt -= 1
        updateCount()
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delegate?.remove(cell: myIndexPath)
    }
}
