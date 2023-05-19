//
//  CustomTextField.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 10.05.23.

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String,isSecure:Bool? = nil) {
        super.init(frame: .zero)
        
        borderStyle = .none
        self.placeholder = placeholder
        self.textColor = .black
        self.isSecureTextEntry = isSecure ?? false

        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 10)
        leftView = spacer
        leftViewMode = .always

        backgroundColor = UIColor(white: 1, alpha: 0.2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
