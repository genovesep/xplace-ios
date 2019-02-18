//
//  CheckoutVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 18/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class CheckoutVC: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: DeliveryHairButton!
    
    private var cellObjectArray = [CellObject<Any>]()
    
    var cart: Cart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        cellObjectArray.append(CellObject(cellType: .addressCell, object: nil))
    }
    
    // MARK: delegates    
    func presentAddressSelectorDelegate() {
        let vc = MyAddressVC.instantiateFromProfileStoryboard()
        vc.fromCell = true
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentCardSelectorDelegate() {
        let vc = MyCardVC.instantiateFromProfileStoryboard()
        vc.fromCell = true
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelectDelegate(address: Address) {
        cellObjectArray[0].object = address
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        
        cellObjectArray.append(CellObject(cellType: .cardCell, object: nil))
        tableView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .right)
    }
    
    func didSelectDelegate(card: ResponseCard) {
        cellObjectArray[1].object = card
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        
        
        cellObjectArray.append(CellObject(cellType: .orderCell, object: cart))
        tableView.insertRows(at: [IndexPath(row: 2, section: 0)], with: .right)
    }
    
}

extension CheckoutVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellObjectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.checkoutCell) as? CheckoutCell else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            let obj = cellObjectArray[indexPath.row]
            cell.delegate = self
            cell.customInit(object: obj)
        case 1:
            let obj = cellObjectArray[indexPath.row]
            cell.delegate = self
            cell.customInit(object: obj)
        case 2:
            let obj = cellObjectArray[indexPath.row]
            cell.customInit(object: obj)
        default:
            break
        }
        
        return cell
    }
}
