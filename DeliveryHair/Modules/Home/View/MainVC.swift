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
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    
    var localProductArr: [Product] = []
    var filteredProductArr: [Product] = []
    var isShowingMenu = false
    var segmentedControlSelectedIndex = 0
    var itemIndexPath: IndexPath!
    var codeSegmented: CustomSegmentedControl?
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        menuContainerView.delegate = self
        
        // REMOVER 
        let cart = try! UserDefaults.standard.get(objectType: Cart.self, forKey: DefaultsIDs.cartIdentifier)
        print("CART ITEMS: ", cart ?? 0)
    }
    
    func setupView() {
        loadProducts()
        navigationController?.navigationBar.backgroundColor = Colors.darkPink
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
                    self.tableView.reloadData()
                }
            } else {
                // TODO - treat error
            }
        }
    }
    
    func toggleMenuShowHide() {
        menuLeadingConstraint.constant = isShowingMenu ? -250 : 0
        tableView.isScrollEnabled = isShowingMenu ? true : false
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        isShowingMenu ? view.removeBlurView() : view.addBlurView()
        isShowingMenu = !isShowingMenu
    }
    
    func reloadData() {
        let rowToReload = NSIndexPath(row: 0, section: 0)
        tableView.reloadRows(at: [rowToReload as IndexPath], with: .fade)
        
        let topIndex = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: topIndex, at: .top, animated: true)
    }
    
    // from delegate
    func goToDetail(forProduct product: Product) {
        let vc = UIStoryboard.ViewController.ProductDetailVC
        vc.product = product
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // actions
    @IBAction func didPressMenuButton(_ sender: Any) {
        toggleMenuShowHide()
    }
    
    @IBAction func cartButtonTapped(_ sender: UIButton) {
        let vc = UIStoryboard.ViewController.cartVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func customSegmentValueChanged(_ sender: CustomSegmentedControl) {
        selectedIndex = sender.selectedSegmentIndex
        filteredProductArr = []
        switch sender.selectedSegmentIndex {
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
        
        reloadData()
    }
}

extension MainVC: MenuViewDelegate {
    func didPress(homeLoginButton button: Int) {
        if button == 0 {
            // TODO - is logged in
        } else {
            let vc = UIStoryboard.ViewController.loginVC
            toggleMenuShowHide()
            tableView.setContentOffset(.zero, animated: true)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let device = GenericMethods.sharedInstance.getDevice()
        if !filteredProductArr.isEmpty {
            let cellHeight = GenericMethods.sharedInstance.getCellHeight(forDevice: device)
            return CGFloat(cellHeight*(filteredProductArr.count % 2 == 0 ? Double(filteredProductArr.count/2) : Double(filteredProductArr.count)/1.99))
        } else {
            let cellHeight = GenericMethods.sharedInstance.getCellHeight(forDevice: device)
            return CGFloat(cellHeight*(localProductArr.count % 2 == 0 ? Double(localProductArr.count/2) : Double(localProductArr.count)/1.99))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ItemMainCell.rawValue) as! ItemMainCell
        cell.delegate = self
        if !filteredProductArr.isEmpty {
            cell.localProductArr = self.filteredProductArr
        } else {
            cell.localProductArr = self.localProductArr
        }
        cell.customInit()
        return cell
    }
    
    override func viewDidLayoutSubviews() {
        tableViewHeightConstraint.constant = tableView.visibleCells[0].frame.size.height
    }
}

