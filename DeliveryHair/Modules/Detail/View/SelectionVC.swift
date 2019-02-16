//
//  SelectionVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 01/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class SelectionVC: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dhAddToCartButton: DeliveryHairButton!
    
    var product: Product?
    var hasSizes = false
    var hasColors = false
    var selectedColor = false
    var isLoggedIn = false
    
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
        
        if let loggedStatus = UserDefaults.standard.value(forKey: DefaultsIds.isLoggedIn) as? Bool {
            self.isLoggedIn = loggedStatus
        }
    }
    
    func validateButton() {
        if selectedColor {
            dhAddToCartButton.setupView()
        }
    }
    
    // MARK: Delegates
    func updateProductSize(withProductSize productSize: ProductSize, andIndexPath indexPath: IndexPath) {
        self.product?.setProduct(productIndex: indexPath.row, newProduct: productSize)
    }
    
    func updateProductColors(withProductColor productColor: ProductColors, andIndexPath indexPath: IndexPath) {
        self.product?.setProduct(productIndex: indexPath.row, newProduct: productColor)
    }
    
    func checkProductQuantity(forCounter counter: Int) {
        product!.addToQtt(add: counter)
        if (hasSizes || hasColors) && product!.productQtt == 0 {
            dhAddToCartButton.disableButton()
        } else {
            dhAddToCartButton.setupView()
        }
    }
    
    func backToMainVC() {
        for controller in (navigationController?.viewControllers)! {
            if controller.isKind(of: MainVC.self) {
                navigationController?.setNavigationBarHidden(false, animated: true)
                navigationController?.popToViewController(controller, animated: true)
            }
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
                cell.myIndexPath = indexPath
                cell.customInit(withVolume: product.productSizes[indexPath.row], andProductQtt: product.productManageStockQty)
                cell.delegate = self
                return cell
            } else if hasColors {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.checkCell) as? CheckCell else { return UITableViewCell() }
                cell.myIndexPath = indexPath
                cell.delegate = self
                cell.customInit(withColor: product.productColors[indexPath.row])
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if hasColors {
            selectedColor = true
            
            for cell in tableView.visibleCells {
                cell.accessoryType = .none
            }
            
            let selected = tableView.cellForRow(at: indexPath)
            selected?.accessoryType = .checkmark
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            validateButton()
        }
    }
}

extension SelectionVC {
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        guard let product = product else { return }
        let item = CartItem(qtt: 1, product: product)
        
        if isLoggedIn {
            do {
                guard let cart = try UserDefaults.standard.get(objectType: Cart.self, forKey: DefaultsIds.cartIdentifier) else {
                    print("THERE IS NO CART SAVED")
                    let cart = Cart.init(products: [item])
                    try! UserDefaults.standard.set(object: cart, forKey: DefaultsIds.cartIdentifier)
                    backToMainVC()
                    return
                }
                
                var thisCart = cart
                thisCart.products.append(CartItem(qtt: 1, product: product))
                
                try! UserDefaults.standard.set(object: thisCart, forKey: DefaultsIds.cartIdentifier)
            } catch let err {
                print(err.localizedDescription)
            }
            
            backToMainVC()
        } else {
            // TODO - isn't logged in
            backToMainVC()
        }
    }
}
