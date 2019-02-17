//
//  ProfileVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 13/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, Storyboarded {

    @IBOutlet weak var addButton: DeliveryHairButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentControl: CustomSegmentedControl!
    
    var myProfileVC: MyProfileVC    = MyProfileVC.instantiateFromProfileStoryboard()
    var myAddressVC: MyAddressVC    = MyAddressVC.instantiateFromProfileStoryboard()
    var myCardVC: MyCardVC          = MyCardVC.instantiateFromProfileStoryboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setDefault()
    }
    
    func initSetup() {
        add(viewControllerToContainer: myProfileVC)
        addButton.isHidden = true
    }
    
    func add(viewControllerToContainer viewController: UIViewController) {
        children.forEach({ $0.removeFromParent() })
        containerView.subviews.forEach({ $0.removeFromSuperview() })
        containerView.addSubview(viewController.view)
        addChild(viewController)
    }
    
}

extension ProfileVC {
    @IBAction func customSegmentValueChanged(_ sender: CustomSegmentedControl) {
        containerView.subviews.forEach({ $0.removeFromSuperview() })
        switch sender.selectedSegmentIndex {
        case 0:
            add(viewControllerToContainer: myProfileVC)
            addButton.isHidden = true
        case 1:
            add(viewControllerToContainer: myAddressVC)
            addButton.setTitle("Adicionar Endereço", for: .normal)
            addButton.isHidden = false
        case 2:
            add(viewControllerToContainer: myCardVC)
            addButton.setTitle("Adicionar Cartão", for: .normal)
            addButton.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let child = children[0]
        switch child {
        case myAddressVC:
            let vc = RegisterAddressVC.instantiateFromLoginStoryboard()
            navigationController?.pushViewController(vc, animated: true)
        case myCardVC:
            let vc = CardVC.instantiateFromCardStoryboard()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
