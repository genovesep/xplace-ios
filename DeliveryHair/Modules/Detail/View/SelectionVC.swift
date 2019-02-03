//
//  SelectionVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 01/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class SelectionVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dhAddToCartButton: DeliveryHairButton!
    
    var product: Product?
    var hasSizes = false
    var hasColors = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        dhAddToCartButton.disableButton()
    }
    
    func checkProductQuantity(forCounter counter: Int) {
        guard let product = product else { return }
        product.setProdQtt(withCount: counter)
        if (hasSizes || hasColors) && product.productQtt == 0 {
            dhAddToCartButton.disableButton()
        } else {
            dhAddToCartButton.setupView()
        }
    }
}

extension SelectionVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let product = product {
            if hasColors {
                return product.productColors.count
            } else if hasSizes {
                return product.productSizes.count
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let product = product {
            if hasSizes {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.volumesCell) as? VolumesCell else { return UITableViewCell() }
                cell.customInit(withVolume: product.productSizes[indexPath.row], andProductQtt: product.productManageStockQty)
                cell.delegate = self
                return cell
            } else if hasColors {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.checkCell) as? CheckCell else { return UITableViewCell() }
                cell.customInit(withColor: product.productColors[indexPath.row])
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension SelectionVC {
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        for controller in (navigationController?.viewControllers)! {
            if controller.isKind(of: MainVC.self) {
                navigationController?.setNavigationBarHidden(false, animated: false)
                navigationController?.popToViewController(controller, animated: true)
            }
        }
    }
}
