//
//  QuestionCell.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/27.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class QuestionCell: UICollectionViewCell {
    
    @IBOutlet weak var bottomScrollView: UIScrollView!
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionContentLabel: UILabel!
    @IBOutlet weak var answerTitleLabel: UILabel!
    @IBOutlet weak var answerContentLabel: UILabel!
    
    @IBOutlet weak var containHeight: NSLayoutConstraint!
    @IBOutlet weak var questionContentHeight: NSLayoutConstraint!
    @IBOutlet weak var answerContentHeight: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setModel(model: QuestionModel) {
        timeLabel.text = model.strQuestionMarketTime
        questionTitleLabel.text = model.strQuestionTitle
        questionContentLabel.text = model.strQuestionContent
        answerTitleLabel.text = model.strAnswerTitle
        answerContentLabel.text = model.strAnswerContent
        
        questionContentHeight.constant = model.questionHeight
        answerContentHeight.constant = model.answerHeight
        containHeight.constant = model.questionHeight + model.answerHeight + ScreenHeightWithoutNavBar * 0.5
//        answerContentLabel.text = answerContentLabel.text!.stringByReplacingOccurrencesOfString("<br>", withString: "")
    }
    
    private func calculatorContentHeight(content: String, label: UILabel, constant: NSLayoutConstraint) -> CGFloat {
        let string: NSString = content as NSString
        let para: NSMutableParagraphStyle = NSMutableParagraphStyle()
        para.lineBreakMode = .ByWordWrapping
        
        let contentRect: CGRect = string.boundingRectWithSize(CGSize(width: ScreenWidth - 40, height: 0), options: Utils.combine(), attributes: [NSFontAttributeName: label.font, NSParagraphStyleAttributeName: para], context: nil)
        var contentHeight: CGFloat = contentRect.height
        if label == questionContentLabel {
            contentHeight += 10
        }
        
        constant.constant = contentHeight
        
        return contentHeight
    }

}
