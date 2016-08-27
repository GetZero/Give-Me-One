//
//  ArticleCell.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/27.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class ArticleCell: UICollectionViewCell {
    
    @IBOutlet weak var bottomScrollView: UIScrollView!
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UITextView!
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var authorBreifLabel: UILabel!
    
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    @IBOutlet weak var breifHeight: NSLayoutConstraint!
    @IBOutlet weak var containHeight: NSLayoutConstraint!
    @IBOutlet weak var authorTitleWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomScrollView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeightWithoutNavBar)
    }
    
    func setModel(model: ArticleModel) {
        timeLabel.text = model.strContMarketTime
        authorLabel.text = model.strContAuthor
        titleLabel.text = model.strContTitle
        contentLabel.text = model.strContent
        authorTitleLabel.text = model.strContAuthor
        authorBreifLabel.text = model.sAuth
        
        contentHeight.constant = model.contentHeight
        containHeight.constant = model.contentHeight + calculatorBreifHeight(authorBreifLabel.text!, label: authorBreifLabel, constant: breifHeight) + ScreenHeightWithoutNavBar * 0.5
    }
    
    private func calculatorBreifHeight(content: String, label: UILabel, constant: NSLayoutConstraint) -> CGFloat {
        let string: NSString = content as NSString
        let para: NSMutableParagraphStyle = NSMutableParagraphStyle()
        para.lineBreakMode = .ByWordWrapping
        
        let contentRect: CGRect = string.boundingRectWithSize(CGSize(width: ScreenWidth - 20, height: 0), options: Utils.combine(), attributes: [NSFontAttributeName: label.font, NSParagraphStyleAttributeName: para], context: nil)
        let contentHeight: CGFloat = contentRect.height
        
        constant.constant = contentHeight
        
        return contentHeight
    }

}
