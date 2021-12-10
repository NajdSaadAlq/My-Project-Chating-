//
//  ChatCell.swift
//  My Project (Chating)
//
//  Created by Najd Alquarishi on 05/12/2021.
//

import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var chatTitleLabel: UILabel!
    @IBOutlet weak var chatReactionTitleLabel: UILabel!
    @IBOutlet weak var chatImageView: UIImageView!
    @IBOutlet weak var chatRectionTimeLabel: UILabel!
    @IBOutlet weak var chatRactionCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
