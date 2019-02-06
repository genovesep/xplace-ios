//
//  MyCustomSegmentedControl.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 04/02/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomSegmentedControl: UIControl {
    
    var selectedSegmentIndex: Int = 0
    var buttons = [UIButton]()
    var selector: UIView!
    
    @IBInspectable var commaSeparatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var textColor: UIColor = .black {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var selectorColor: UIColor = .lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var selectorTextColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        buttons.removeAll()
        subviews.forEach({ $0.removeFromSuperview() })
        
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 12.0)!
            button.addTarget(self, action: #selector(selectorButtonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        //let selectorWidth = frame.width/CGFloat(buttons.count)
        selector = UIView(frame: CGRect(x: 0, y: frame.height - 5, width: buttons[0].frame.width, height: 5))
        selector.backgroundColor = selectorColor
        addSubview(selector)
    }
    
    @objc func selectorButtonTapped(_ sender: UIButton) {
        for (index, button) in buttons.enumerated() {
            button.setTitleColor(textColor, for: .normal)
            if button == sender {
                selectedSegmentIndex = index
                let selectorStartPosition = (frame.width/CGFloat(buttons.count)) * CGFloat(index)
                UIView.animate(withDuration: 0.3) {
                    self.selector.frame = CGRect(x: selectorStartPosition, y: self.frame.height - 5, width: button.frame.width, height: 5)
                }
                button.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }
    
    
}
