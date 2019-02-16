//
//  MyAddressVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 13/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class MyAddressVC: UITableViewController, Storyboarded {
    
    private var dispatchGroup = DispatchGroup()
    private var addressArr: [Address]?
    
    var addressArray: [Address] {
        get { return addressArr ?? [] }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        LoadingVC.sharedInstance.show()
        
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = Colors.darkPink
        refreshControl?.attributedTitle = NSAttributedString(string: "Verificando novos endereços cadastrados...", attributes: [
            NSAttributedString.Key.font : Fonts.robotoMedium_10pt!,
            NSAttributedString.Key.foregroundColor : Colors.lightPink])
        refreshControl?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        loadAddressData()
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    func endRefreshControl() {
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
        }
    }
    
    @objc func refreshData(_ sender: Any) {
        loadAddressData()
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    func loadAddressData() {
        dispatchGroup.enter()
        guard let userData = try! UserDefaults.standard.get(objectType: ResponseLogin.self, forKey: DefaultsIds.loginData) else { return }
        let userId = userData.userId
        GetRequest.sharedInstance.get(url: Services.getAddressList + "\(userId)", onSuccess: { (response: SuccessObject<[Address]>) in
            LoadingVC.sharedInstance.hide()
            
            let object = response.object
            self.addressArr = object
            
            self.dispatchGroup.leave()
            self.endRefreshControl()
        }) { (response) in
            
            // TODO - Error
            self.addressArr = []
            self.dispatchGroup.leave()
            self.endRefreshControl()
        }
    }
}

extension MyAddressVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let adArr = addressArr else { return 0 }
        return adArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.addressCell) as! AddressCell
        
        cell.textLabel?.text = addressArray[indexPath.row].endereco
        cell.detailTextLabel?.text = addressArray[indexPath.row].bairro
        
        return cell
    }
}
