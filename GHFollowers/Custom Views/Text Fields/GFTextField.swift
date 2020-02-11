//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Vatsal Kulshreshtha on 10/02/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .headline)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 20
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        
        
        placeholder = "Enter Username"
        returnKeyType = .go
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
}
