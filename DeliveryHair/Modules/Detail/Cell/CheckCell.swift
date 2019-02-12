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
    
    weak var delegate: SelectionVC?
    var productColor: ProductColors!
    var myIndexPath: IndexPath!
    
    func customInit(withColor color: ProductColors) {
        titleLabel.text = color.name
        productColor = color
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        productColor.selected = selected
        if selected {
            delegate?.updateProductColors(withProductColor: productColor, andIndexPath: myIndexPath)
        }
    }

}
