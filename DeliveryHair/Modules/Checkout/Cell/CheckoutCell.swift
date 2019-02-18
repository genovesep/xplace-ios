//
//  CheckoutCell.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 18/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

struct CellObject<T> {
    var cellType: CellType?
    var object: T?
}

enum CellType {
    case addressCell
    case cardCell
    case orderCell
}

class CheckoutCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var delegate: CheckoutVC?
    private var cellObjectType: CellType!
    
    func customInit<T>(object: CellObject<T>) {
        if let cellType = object.cellType {
            cellObjectType = cellType
            titleLabel.text = "Endereço"
            if cellType == .addressCell {
                if let obj = object.object {
                    let address = obj as! Address
                    descriptionLabel.text = """
                    \(address.endereco) \(address.numero), \(address.complemento), \(address.bairro) - \(address.cidade)
                    \(address.cep) - \(address.uf)
                    \(address.referencia)
                    """
                } else {
                    descriptionLabel.text = "Selecione um endereço"
                }
            } else if cellType == .cardCell {
                titleLabel.text = "Cartão"
                if let obj = object.object {
                    let card = obj as! ResponseCard
                    descriptionLabel.text = """
                    \(card.cardName)
                    \(card.cardNumber)
                    \(card.cardVencDate)
                    """
                } else {
                    descriptionLabel.text = "Selecione um cartão"
                }
            } else if cellType == .orderCell {
                titleLabel.text = "Pedido"
                var descriptionString = ""
                var fPass = true
                if let obj = object.object {
                    let cart = obj as! Cart
                    cart.products.forEach { (item) in
                        let product = item.product
                        descriptionString.append("Produto: \(product.productName.replacingOccurrences(of: "Produto_Teste - ", with: ""))\n")
                        if product.productSizes.count > 0 {
                            let products = item.product.productSizes
                            for (_, product) in products.enumerated() {
                                if let qtt = product.quantity {
                                    if qtt > 0 {
                                        let str = fPass ? "\(qtt)x \(product.slug)" : "\n\(qtt)x \(product.slug)"
                                        descriptionString.append(str)
                                        fPass = false
                                    }
                                }
                            }
                            descriptionString.append("\n\n")
                            descriptionLabel.text = descriptionString
                            fPass = true
                        } else if product.productColors.count > 0 {
                            let products = item.product.productColors
                            products.forEach { (product) in
                                guard let isSelected = product.selected else { return }
                                if isSelected {
                                    let str = "\(product.name)"
                                    descriptionString.append(str)
                                }
                            }
                            descriptionString.append("\n\n")
                            descriptionLabel.text = descriptionString
                        } else {
                            descriptionString.append("---\n\n")
                            descriptionLabel.text = descriptionString
                        }
                    }
                } else {
                    descriptionLabel.text = "Não foi possível carregar o pedido"
                }
            }
        }
        self.addGestureRecognizer(createTapGesture())
    }
    
    func createTapGesture() -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedCell(_:)))
        return tap
    }
    
    @objc func tappedCell(_ sender: UIGestureRecognizer) {        
        switch cellObjectType! {
        case .addressCell:
            delegate?.presentAddressSelectorDelegate()
        case .cardCell:
            delegate?.presentCardSelectorDelegate()
        case .orderCell:
            print("Order cell")
        }
    }
}
