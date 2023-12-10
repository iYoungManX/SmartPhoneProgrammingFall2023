//
//  SeattleTableViewCell.swift
//  SeattleImage
//
//  Created by Zonghui Yao on 12/9/23.
//

import UIKit

class SeattleTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSeattle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
