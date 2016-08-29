//
//  NightModeCell.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/30.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class NightModeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
