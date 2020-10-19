//
//  Constants.swift
//  FlashChat
//
//  Created by Tarokh on 10/11/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation

struct Constants {
    
    // define some variables
    static let appName = "⚡️FlashChat"
    static let cellIdentifier = "messageCell"
    static let cellNibName = "MessageCell"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
}
