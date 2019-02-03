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
    
    func customInit(withVolume volume: ProductSize, andProductQtt productQtt: String) {
        titleLabel.text = volume.name
        prodQtt = Int(productQtt)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        counter+=1
        DispatchQueue.main.async {
            self.countLabel.text = "\(self.counter)"
            self.delegate?.checkProductQuantity(forCounter: self.counter)
        }
    }
    
    @IBAction func subButtonTapped(_ sender: Any) {
        counter-=1
        if counter >= 0 {
            DispatchQueue.main.async {
                self.countLabel.text = "\(self.counter)"
                self.delegate?.checkProductQuantity(forCounter: self.counter)
            }
        } else {
            counter = 0
        }
    }
}
