//
//  MessageCell.swift
//  FlashChat
//
//  Created by Tarokh on 10/7/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    //MARK: - @IBOutlets
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
