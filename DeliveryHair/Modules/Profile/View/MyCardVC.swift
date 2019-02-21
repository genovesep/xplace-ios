//
//  MyCardVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 13/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class MyCardVC: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    
    private var dispatchGroup = DispatchGroup()
    private var cardArr: [ResponseCard]?
    private var refreshControl = UIRefreshControl()
    weak var delegate: CheckoutVC?
    var fromCell: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        if let _ = fromCell {
            self.title = "Cartões"
        }
        
        LoadingVC.sharedInstance.show()
        
        refreshControl.tintColor = Colors.darkPink
        refreshControl.attributedTitle = NSAttributedString(string: "Verificando novos cartões cadastrados...", attributes: [
            NSAttributedString.Key.font : Fonts.robotoMedium_10pt!,
            NSAttributedString.Key.foregroundColor : Colors.lightPink])
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)

        tableView.refreshControl = refreshControl
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
            self.refreshControl.endRefreshing()
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
        GetRequest.sharedInstance.get(url: Services.getCardList + "\(userId)", onSuccess: { (response: SuccessObject<[ResponseCard]>) in
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
    
    //MARK: delegates
    func addCardCellTapped() {
        let vc = CardVC.instantiateFromCardStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyCardVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cardArr = cardArr else {
            return 1
        }
        
        if cardArr.count == 0 {
            return 1
        }
        
        return cardArr.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == cardArr?.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.addItemCell) else { return UITableViewCell() }
            cell.textLabel?.text = "Adicione um cartão +"
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell") else { return UITableViewCell() }
            guard let cardArr = self.cardArr else { return UITableViewCell() }
            cell.textLabel?.text = cardArr[indexPath.row].getCardNumber()
            cell.detailTextLabel?.text = cardArr[indexPath.row].cardVencDate
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == cardArr?.count {
            self.addCardCellTapped()
        } else {
            if let _ = fromCell {
                navigationController?.popViewController(animated: true)
                guard let card = cardArr?[indexPath.row] else { return }
                delegate?.didSelectDelegate(card: card)
            }
        }
    }
}
