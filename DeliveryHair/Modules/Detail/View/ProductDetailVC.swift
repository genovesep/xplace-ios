//
//  ProductDetailVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 01/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit
import Kingfisher

class ProductDetailVC: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var dhAddToCartButton: DeliveryHairButton!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {        
        UIApplication.shared.statusBarView?.backgroundColor = Colors.darkPink
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        guard let product = product else { return }
        productNameLabel.text = product.productName
        productPriceLabel.text = Double(product.productPrice)?.toLocalCurrency()
        productDescriptionLabel.text = product.productDescription.htmlToString
        
        if let pImage = product.productImages {
            let urlString = String.Services.host + pImage.productImage
            guard let url = URL(string: urlString) else { return }
            let resource = ImageResource(downloadURL: url)
            productImageView.kf.setImage(with: resource)
        }
    }
    
}

extension ProductDetailVC {
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        if let product = product {
            if product.productColors.count > 0 {
                let vc = UIStoryboard.ViewController.SelectionVC
                vc.hasColors = true
                vc.product = product
                navigationController?.pushViewController(vc, animated: true)
            } else if product.productSizes.count > 0 {
                let vc = UIStoryboard.ViewController.SelectionVC
                vc.hasSizes = true
                vc.product = product
                navigationController?.pushViewController(vc, animated: true)
            } else {
                // todo - no option left just add the product
            }
        }
    }
}
