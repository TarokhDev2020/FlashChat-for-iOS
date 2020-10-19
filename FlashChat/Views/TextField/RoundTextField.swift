//
//  RoundTextField.swift
//  FlashChat
//
//  Created by Tarokh on 10/8/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit

@IBDesignable class RoundTextField: UITextField {
    
    // define some variables
    @IBInspectable var radius: CGFloat = 1.0 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
    
}
