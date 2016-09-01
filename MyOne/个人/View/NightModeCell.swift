//
//  NightModeCell.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/30.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class NightModeCell: UITableViewCell {

    
    @IBOutlet weak var nightModeSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func nightModeSwitchAction(sender: AnyObject) {
//        sender.setOn(!sender.on, animated: true)
        let isOn: Bool = sender.on
        
        if isOn {
            dk_manager.nightFalling()
        } else {
            UIColor.nightModeCloseColor()
        }
    }
    
    
}
