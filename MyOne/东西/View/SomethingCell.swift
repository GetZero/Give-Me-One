//
//  SomethingCell.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/27.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class SomethingCell: UICollectionViewCell {
    
    @IBOutlet weak var bottomScrollView: UIScrollView!
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var thingImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    @IBOutlet weak var containHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setModel(model: SomethingData) {
        timeLabel.text = model.strTm
        thingImage.af_setImageWithURL(NSURL(string: model.strBu)!)
        titleLabel.text = model.strTt
        contentLabel.text = model.strTc
        contentHeight.constant = model.contentHeight
        containHeight.constant = ScreenWidth + 60 + model.contentHeight
    }

}
