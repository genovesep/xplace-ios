//
//  VolumesCell.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 03/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class VolumesCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var subButton: UIButton!
    
    weak var delegate: SelectionVC?
    
    var prodQtt: Int?
    var counter = 0
    var productSize: ProductSize!
    var myIndexPath: IndexPath!
    
    func customInit(withVolume volume: ProductSize, andProductQtt productQtt: String) {
        productSize =  volume
        titleLabel.text = volume.name
        prodQtt = Int(productQtt)
    }
    
    func updateCountLabel() {
        DispatchQueue.main.async {
            self.productSize.quantity = self.counter
            self.countLabel.text = "\(self.counter)"
            self.delegate?.checkProductQuantity(forCounter: self.counter)
            self.delegate?.updateProductSize(withProductSize: self.productSize, andIndexPath: self.myIndexPath)
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        counter+=1
        updateCountLabel()
    }
    
    @IBAction func subButtonTapped(_ sender: Any) {
        counter-=1
        if counter >= 0 {
            updateCountLabel()
        } else {
            counter = 0
        }
    }
}
