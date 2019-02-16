//
//  MyCardVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 13/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class MyCardVC: UITableViewController, Storyboarded {

    private var dispatchGroup = DispatchGroup()
    private var cardArr: [Card]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        LoadingVC.sharedInstance.show()
        
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = Colors.darkPink
        refreshControl?.attributedTitle = NSAttributedString(string: "Verificando novos cartões cadastrados...", attributes: [
            NSAttributedString.Key.font : Fonts.robotoMedium_10pt!,
            NSAttributedString.Key.foregroundColor : Colors.lightPink])
        refreshControl?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        loadCardData()
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
        loadCardData()
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    func loadCardData() {
        dispatchGroup.enter()
        guard let userData = try! UserDefaults.standard.get(objectType: ResponseLogin.self, forKey: DefaultsIds.loginData) else { return }
        let userId = userData.userId
        GetRequest.sharedInstance.get(url: Services.getCardList + "\(userId)", onSuccess: { (response: SuccessObject<[Card]>) in
            LoadingVC.sharedInstance.hide()
            let object = response.object
            self.cardArr = object
            self.dispatchGroup.leave()
            self.endRefreshControl()
        }) { (response) in
            LoadingVC.sharedInstance.hide()
            self.dispatchGroup.leave()
            self.endRefreshControl()
            // TODO - Error
        }
    }
}

extension MyCardVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cardArr = cardArr else {
            return 0
        }
        
        if cardArr.count == 0 {
            return 0
        }
        
        return cardArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
