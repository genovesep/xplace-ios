//
//  MyAddressVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 13/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class MyAddressVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dispatchGroup = DispatchGroup()
    private var addressArr: [Address]?
    private var refreshControl = UIRefreshControl()
    weak var delegate: CheckoutVC?
    var fromCell: Bool?
    
    var addressArray: [Address] {
        get { return addressArr ?? [] }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        if let _ = fromCell {
            self.title = "Endereços"
        }
        
        LoadingVC.sharedInstance.show()
        
        refreshControl.tintColor = Colors.darkPink
        refreshControl.attributedTitle = NSAttributedString(string: "Verificando novos endereços cadastrados...", attributes: [
            NSAttributedString.Key.font : Fonts.robotoMedium_10pt!,
            NSAttributedString.Key.foregroundColor : Colors.lightPink])
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
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
            self.refreshControl.endRefreshing()
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
    
    func addAddressCellTapped() {
        let vc = RegisterAddressVC.instantiateFromLoginStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyAddressVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let adArr = addressArr else { return 1 }
        if adArr.count == 0 {
            return 1
        }
        return adArr.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == addressArr?.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.addItemCell) else { return UITableViewCell() }
            cell.textLabel?.text = "Adicione um endereço +"
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.addressCell) else { return UITableViewCell() }
            guard let addArr = self.addressArr else { return UITableViewCell() }
            cell.textLabel?.text = addArr[indexPath.row].endereco
            cell.detailTextLabel?.text = addArr[indexPath.row].bairro
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == addressArr?.count {
            self.addAddressCellTapped()
        } else {
            if let _ = fromCell {
                navigationController?.popViewController(animated: true)
                guard let address = addressArr?[indexPath.row] else { return }
                delegate?.didSelectDelegate(address: address)
            }
        }
    }
}
