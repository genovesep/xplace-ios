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
    private var cvv: String = ""
    private var dispatchGroup = DispatchGroup()
    
    var cart: Cart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        cellObjectArray = [
            CellObject(cellType: .addressCell, object: nil),
            CellObject(cellType: nil, object: nil),
            CellObject(cellType: nil, object: nil)
        ]
        checkoutButton.disableButton()
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
        
        if cellObjectArray[1].object == nil {
            cellObjectArray[1] = CellObject(cellType: .cardCell, object: nil)
            tableView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .right)
        }
    }
    
    func didSelectDelegate(card: ResponseCard) {
        cellObjectArray[1].object = card
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        
        
        if cellObjectArray[2].object == nil {
            cellObjectArray[2] = CellObject(cellType: .orderCell, object: cart)
            tableView.insertRows(at: [IndexPath(row: 2, section: 0)], with: .right)
            
            checkoutButton.setupView()
        }
    }
    
    func checkAllRequired() -> Bool {
        var count = 0
        cellObjectArray.forEach { (cellObject) in
            if cellObject.object != nil && cellObject.cellType != nil {
                count+=1
            }
        }
        return count == 3 ? true : false
    }
    
    func executeZoopPayment() {
        guard let card = cellObjectArray[1].object as? ResponseCard else { return }
        guard let cart = cellObjectArray[2].object as? Cart else { return }
        let totalAmount = cart.getTotal()
        let zoopPaymentPayload = card.generatePayloadForPayment(with: totalAmount, cardSafeCode: Int(cvv)!)
        PostRequest.sharedInstance.post(url: Services.payWithZoop, payload: zoopPaymentPayload, onSuccess: { (response: SuccessObject<ResponseZoopPayment>) in
            guard let transactionId = response.object.transactionId else {
                LoadingVC.sharedInstance.hide()
                return
            }
            
            self.placeOrder(with: transactionId)
        }) { (response) in
            // TODO - error
        }
    }
    
    func placeOrder(with transactionId: String) {
        var responseStatus: Bool?
        
        guard let userData = try! UserDefaults.standard.get(objectType: ResponseLogin.self, forKey: DefaultsIds.loginData) else { return }
        guard let addressId = (cellObjectArray[0].object as? Address)?.addressId else { return }
        guard let cart = cellObjectArray[2].object as? Cart else { return }
        let placeOrderPayload = cart.generateOrderPayload(forUser: userData.userId, withAddress: addressId, andTransactionId: transactionId)
        PostRequest.sharedInstance.post(url: Services.placeOrder, payload: placeOrderPayload, onSuccess: { (response: SuccessObject<GenericMessageResponse>) in
            let status = response.object.status
            responseStatus = status
            self.dispatchGroup.leave()
        }) { (response) in
            self.dispatchGroup.leave()
            // TODO - Error
        }
        
        dispatchGroup.notify(queue: .main) {
            LoadingVC.sharedInstance.hide()
            if let status = responseStatus {
                if status {
                    self.resetShopping()
                } else {
                    // TODO
                }
            } else {
                // TODO
            }
        }
    }
    
    func resetShopping() {
        UserDefaults.standard.set(nil, forKey: DefaultsIds.cartIdentifier)
        guard let controllers = navigationController?.viewControllers else { return }
        for controller in controllers {
            if controller.isKind(of: MainVC.self) {
                self.navigationController?.popToViewController(controller, animated: true)
            }
        }
    }
}

extension CheckoutVC {
    @IBAction func checkoutButtonTapped(_ sender: UIButton) {
        if checkAllRequired() {
            guard let vc = initPopup(from: .cardCvv) as? CardCvvVC else { return }
            vc.confirmButtonCompletion = { text in
                self.cvv = text
                LoadingVC.sharedInstance.show()
                self.dispatchGroup.enter()
                self.executeZoopPayment()
            }
            vc.cancelButtonCompletion = {
                self.cvv = ""
            }
            present(vc, animated: true, completion: nil)
        }
    }
}

extension CheckoutVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var counter = 0
        cellObjectArray.forEach { (cellObject) in
            if cellObject.cellType != nil {
                counter+=1
            }
        }
        return counter
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
