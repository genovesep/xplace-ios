//
//  ProfileVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 13/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, Storyboarded {

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
        case 1:
            add(viewControllerToContainer: myAddressVC)
        case 2:
            add(viewControllerToContainer: myCardVC)
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
        default:
            break
        }
    }
}
