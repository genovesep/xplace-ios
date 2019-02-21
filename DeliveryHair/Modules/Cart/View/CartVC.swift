//
//  CartVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 04/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class CartVC: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buyButton: DeliveryHairButton!
    
    weak var delegate: MainVC?
    var cart: Cart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        loadCart()
    }
    
    @objc func loadCart() {
        let cart = try! UserDefaults.standard.get(objectType: Cart.self, forKey: DefaultsIds.cartIdentifier)
        self.cart = cart
        tableView.reloadData()
        validateCartForButton()
    }
    
    func validateCartForButton() {
        guard let cart = self.cart else {
            buyButton.disableButton()
            return
        }
        
        if cart.products.count == 0 {
            buyButton.disableButton()
        }
    }
    
    // MAKR: Delegates
    func updateCartItemQtt(withNewQtt qtt: Int, andProdIndexPath indexPath: IndexPath) {
        self.cart?.products[indexPath.row].qtt = qtt
        try! UserDefaults.standard.set(object: self.cart, forKey: DefaultsIds.cartIdentifier)
    }
}

extension CartVC {
    @IBAction func keepShoppingButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        let vc = CheckoutVC.instantiateFromCheckoutStoryboard()
        vc.cart = cart
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cart = cart else { return 0 }
        if GenericMethods.sharedInstance.checkIf(cartHasDummyProduct: cart) {
            return 0
        }        
        return cart.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cart = cart else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cartCell) as! CartCell
        cell.myIndexPath = indexPath
        cell.customInit(forItem: cart.products[indexPath.row])
        cell.delegate = self
        return cell        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.cart?.products.remove(at: indexPath.row)
            guard let cart = self.cart else { return }
            try! UserDefaults.standard.set(object: cart, forKey: DefaultsIds.cartIdentifier)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remover"
    }
}
