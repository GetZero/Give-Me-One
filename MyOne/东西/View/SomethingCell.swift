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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calculatorContentHeight(contentLabel.text!)
    }
    
    func setModel(model: SomethingModel) {
        timeLabel.text = model.strTm
        thingImage.af_setImageWithURL(NSURL(string: model.strBu)!)
        titleLabel.text = model.strTt
        contentLabel.text = model.strTc
    }
    
    private func calculatorContentHeight(content: String) {
        let string: NSString = content as NSString
        let contentRect: CGRect = string.boundingRectWithSize(CGSize(width: contentLabel.bounds.width, height: 0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(13.5)], context: nil)
        let contentHeight: CGFloat = contentRect.height
        
        UIView.animateWithDuration(0.3) {
            self.contentHeight.constant = contentHeight
        }
        
        layoutIfNeeded()
        containHeight.constant = CGRectGetMaxY(contentLabel.frame) + 20
    }

}
