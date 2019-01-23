//
//  ViewController.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 16/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    private enum CellIdentifier: String {
        case MainCell
        case ItemMainCell
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuContainerView: MenuView!
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    
    var localProductArr: [Product] = []
    var filteredProductArr: [Product] = []
    var isShowingMenu = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        MenuView.initialize()
        loadProducts()
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func loadProducts() {
        LoadingVC.sharedInstance.show()
        ProductServices.shared.getAllProducts { (response) in
            LoadingVC.sharedInstance.hide()
            self.localProductArr = []
            if let productArr = response {
                DispatchQueue.main.async {                    
                    self.localProductArr = productArr
                    NotificationCenter.default.post(name: NSNotification.Name(kNSNotificationName_productLoad), object: nil)
                    self.tableView.reloadData()
                }
            } else {
                /// todo - treat error
            }
        }
    }
    
    
    /// ACTIONS
    @IBAction func didPressMenuButton(_ sender: Any) {
        menuLeadingConstraint.constant = isShowingMenu ? -250 : 0
        tableView.isScrollEnabled = isShowingMenu ? true : false
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        isShowingMenu = !isShowingMenu
    }
    
}

extension MainVC: MainCellDelegate {
    func reloadItemCollectionView(forIndex index: Int) {
        filteredProductArr = []
        switch index {
        case 0:
            filteredProductArr = []
        case 1:
            localProductArr.forEach { (product) in
                let category = product.productCategorys
                if !category.isEmpty {
                    let slug = product.productCategorys[0].slug.lowercased()
                    if slug.contains("profissional") {
                        self.filteredProductArr.append(product)
                    }
                }
            }
        case 2:
            localProductArr.forEach { (product) in
                let category = product.productCategorys
                if !category.isEmpty {
                    let slug = product.productCategorys[0].slug.lowercased()
                    if slug.contains("cliente") {
                        self.filteredProductArr.append(product)
                    }
                }
            }
        default:
            break
        }
        
        let rowToReload = NSIndexPath(row: 1, section: 0)
//        self.tableView.reloadRows(at: [rowToReload as IndexPath], with: .fade)
        self.tableView.reloadData()
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 222
        } else {
            if !filteredProductArr.isEmpty {
                switch UIScreen.main.bounds.height {
                case 568:
                    return CGFloat(230*(filteredProductArr.count % 2 == 0 ? Double(filteredProductArr.count/2) : Double(filteredProductArr.count)/1.99))
                case 736:
                    return CGFloat(278*(filteredProductArr.count % 2 == 0 ? Double(filteredProductArr.count/2) : Double(filteredProductArr.count)/1.99))
                case 896:
                    return CGFloat(286*(filteredProductArr.count % 2 == 0 ? Double(filteredProductArr.count/2) : Double(filteredProductArr.count)/1.99))
                default:
                    return CGFloat(268*(filteredProductArr.count % 2 == 0 ? Double(filteredProductArr.count/2) : Double(filteredProductArr.count)/1.99))
                }
            } else {
                switch UIScreen.main.bounds.height {
                case 568:
                    return CGFloat(230*(localProductArr.count % 2 == 0 ? Double(localProductArr.count/2) : Double(localProductArr.count)/1.99))
                case 736:
                    return CGFloat(278*(localProductArr.count % 2 == 0 ? Double(localProductArr.count/2) : Double(localProductArr.count)/1.99))
                case 896:
                    return CGFloat(286*(localProductArr.count % 2 == 0 ? Double(localProductArr.count/2) : Double(localProductArr.count)/1.99))
                default:
                    return CGFloat(268*(localProductArr.count % 2 == 0 ? Double(localProductArr.count/2) : Double(localProductArr.count)/1.99))
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.MainCell.rawValue) as! MainCell
            cell.delegate = self
            cell.customInit()
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ItemMainCell.rawValue) as! ItemMainCell
            if !filteredProductArr.isEmpty {
                cell.localProductArr = self.filteredProductArr
            } else {
                cell.localProductArr = self.localProductArr
            }
            cell.customInit()
            return cell
        }
    }
}

