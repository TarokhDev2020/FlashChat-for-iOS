//
//  RoundButton.swift
//  FlashChat
//
//  Created by Tarokh on 10/7/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundButton: UIButton {
    
    // define some variables
    @IBInspectable var radius: CGFloat = 1.0 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
    
}
