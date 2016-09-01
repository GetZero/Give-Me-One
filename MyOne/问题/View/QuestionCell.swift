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
    
    func setModel(model: QuestionData) {
        timeLabel.text = model.strQuestionMarketTime
        questionTitleLabel.text = model.strQuestionTitle
        questionContentLabel.text = model.strQuestionContent
        answerTitleLabel.text = model.strAnswerTitle
        answerContentLabel.text = model.strAnswerContent
        
        questionContentHeight.constant = model.questionHeight
        answerContentHeight.constant = model.answerHeight
        containHeight.constant = model.questionHeight + model.answerHeight + questionTitleLabel.bounds.height * 2 + 115
    }

}
