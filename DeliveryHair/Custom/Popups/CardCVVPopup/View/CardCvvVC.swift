//
//  CardCvvVC.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 20/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class CardCvvVC: UIViewController {

    @IBOutlet weak var cvvTextField: DeliveryHairTextField!
    
    var confirmButtonCompletion: ((String) -> Void)?
    var cancelButtonCompletion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CardCvvVC {
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        dismiss(animated: true) {
            guard let text = self.cvvTextField.text, self.cvvTextField.text != "" else { return }
            self.confirmButtonCompletion?(text)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true) {
            self.cancelButtonCompletion?()
        }
    }
}
