//
//  CheckCell.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 03/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class CheckCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func customInit(withColor color: ProductColors) {
        titleLabel.text = color.name
    }

}
