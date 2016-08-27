//
//  HomeCell.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/25.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var bottomScrollView: UIScrollView!
    @IBOutlet weak var volLabel: UILabel!
    @IBOutlet weak var todayImage: UIImageView!
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var articleName: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthAndYear: UILabel!
    @IBOutlet weak var containHeight: NSLayoutConstraint!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var contentLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var backgroundImageHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calculatorContentHeight(contentLabel.text!)
    }
    
    func setModel(model: HomeModel) {
        let worksAndAuthor: [String] = model.strAuthor.componentsSeparatedByString("&")
        
        volLabel.text = model.strHpTitle
        todayImage.af_setImageWithURL(NSURL(string: model.strOriginalImgUrl)!)
        articleName.text = worksAndAuthor[1]
        imageName.text = worksAndAuthor[0]
        contentLabel.text = model.strContent
    }
    
    private func calculatorContentHeight(content: String) {
        let string: NSString = content as NSString
        let contentRect: CGRect = string.boundingRectWithSize(CGSize(width: contentLabel.bounds.width, height: 0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(13.5)], context: nil)
        let contentHeight: CGFloat = contentRect.height
        
        UIView.animateWithDuration(0.3) { 
            self.contentLabelHeight.constant = contentHeight
            self.backgroundImageHeight.constant = contentHeight + 10
        }
        
        layoutIfNeeded()
        containHeight.constant = CGRectGetMaxY(backgroundImage.frame) + 20
    }

}
