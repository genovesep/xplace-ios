//
//  CartVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 04/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: MainVC?
    var cart: Cart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        loadCart()
    }
    
    @objc func loadCart() {
        let cart = try! UserDefaults.standard.get(objectType: Cart.self, forKey: DefaultsIDs.cartIdentifier)
        self.cart = cart
        tableView.reloadData()
    }
    
    
    // MAKR: Delegates
    func updateCartItemQtt(withNewQtt qtt: Int, andProdIndexPath indexPath: IndexPath) {
        self.cart?.products[indexPath.row].qtt = qtt
    }
    
    func remove(cell indexPath: IndexPath) {
        self.cart?.products.remove(at: indexPath.row)
        guard let cart = self.cart else { return }
        try! UserDefaults.standard.set(object: cart, forKey: DefaultsIDs.cartIdentifier)
        tableView.deleteRows(at: [indexPath], with: .left)
        perform(#selector(loadCart), with: nil, afterDelay: 0.5)
    }
}

extension CartVC {
    @IBAction func keepShoppingButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        
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
}
