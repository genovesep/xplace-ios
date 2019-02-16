//
//  DeliveryHairTextField.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 27/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class DeliveryHairTextField: UITextField {
    
    var textRect = CGRect()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @IBInspectable var borderColor: UIColor = Colors.darkPink {
        didSet {
            setupView()
        }
    }
    
    private func setupView() {
        tintColor = Colors.darkPink
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 8
        
        
        rightViewMode = .always
        switch tag {
        case 0:
            rightView = UIImageView(image: UIImage.Icons.icon_phone)
        case 1:
            rightView = createTogglePasswordButton()
        case 2:
            rightView = UIImageView(image: UIImage.Icons.icon_username)
        case 3:
            rightView = UIImageView(image: UIImage.Icons.icon_mail)
        default:
            break
        }
    }
    
    func createTogglePasswordButton() -> UIButton {
        let button = UIButton()
        var imageView = UIImageView()
        switch isSecureTextEntry {
        case true:
            imageView = UIImageView(image: UIImage.Icons.icon_vision_off)
            button.setImage(UIImage.Icons.icon_vision_off, for: .normal)
            button.addTarget(self, action: #selector(toggleSecureTextEntry), for: .touchUpInside)
            
        case false:
            imageView = UIImageView(image: UIImage.Icons.icon_vision_on)
            button.setImage(UIImage.Icons.icon_vision_on, for: .normal)
            button.addTarget(self, action: #selector(toggleSecureTextEntry), for: .touchUpInside)
        }
        button.frame = imageView.frame
        return button
    }
    
    @objc func toggleSecureTextEntry() {
        isSecureTextEntry = !isSecureTextEntry
        switch isSecureTextEntry {
        case false:
            rightView = createTogglePasswordButton()
            isSecureTextEntry = false
        case true:
            rightView = createTogglePasswordButton()
            isSecureTextEntry = true
        }
        
        if let existingText = text, isSecureTextEntry {
            /* When toggling to secure text, all text will be purged if the user
             continues typing unless we intervene. This is prevented by first
             deleting the existing text and then recovering the original text. */
            deleteBackward()
            
            if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                replace(textRange, withText: existingText)
            }
        }
        
        /* Reset the selected text range since the cursor can end up in the wrong
         position after a toggle because the text might vary in width */
        if let existingSelectedTextRange = selectedTextRange {
            selectedTextRange = nil
            selectedTextRange = existingSelectedTextRange
        }
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= 10
        return textRect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0.0,
                                   left: 10.0,
                                   bottom: 0.0,
                                   right: rightView?.frame.width ?? 0 + 15
        )
        return bounds.inset(by: padding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0.0,
                                   left: 10.0,
                                   bottom: 0.0,
                                   right: rightView?.frame.width ?? 0 + 15
        )
        return bounds.inset(by: padding)
    }
}
