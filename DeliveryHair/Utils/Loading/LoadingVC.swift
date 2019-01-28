//
//  LoadingVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 21/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class LoadingVC: UIView {
    static let sharedInstance = LoadingVC()
    
    lazy var transparentView: UIView = {
        let transparentView = UIView(frame: UIScreen.main.bounds)
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.isUserInteractionEnabled = true
        return transparentView
    }()
    
//    lazy var activityIndicator: UIActivityIndicatorView = {
//
//    }()
    
    func show() {
        self.addSubview(transparentView)
        UIApplication.shared.keyWindow?.addSubview(transparentView)
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.transparentView.removeFromSuperview()
        }
    }
    
}
