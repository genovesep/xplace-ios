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
    
    var cart: Cart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        let cart = try! UserDefaults.standard.get(objectType: Cart.self, forKey: DefaultsIDs.cartIdentifier)
        self.cart = cart
        tableView.reloadData()
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cartCell) as! CartCell
        cell.customInit(forItem: cart.products[indexPath.row])
        cell.delegate = self
        return cell
    }
}
