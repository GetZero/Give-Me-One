//
//  OtherSettingCell.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/30.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class OtherSettingCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
