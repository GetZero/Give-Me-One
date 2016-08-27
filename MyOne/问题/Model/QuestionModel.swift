//
//  QuestionModel.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/27.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class QuestionModel: NSObject {
    
    var strQuestionContent: String = "暂无数据"
    var strAnswerTitle: String = "暂无数据"
    var strQuestionTitle: String = "暂无数据"
    var strQuestionMarketTime: String = "暂无数据"
    var strAnswerContent: String = "暂无数据"
    var questionHeight: CGFloat = 0
    var answerHeight: CGFloat = 0
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
        questionHeight = calculatorContentHeight(strQuestionContent, font: UIFont.systemFontOfSize(14)) + 10
        answerHeight = calculatorContentHeight(strAnswerContent, font: UIFont.systemFontOfSize(14))
        
        strAnswerContent = strAnswerContent.stringByReplacingOccurrencesOfString("<br>", withString: "")
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    private func calculatorContentHeight(content: String, font: UIFont) -> CGFloat {
        let string: NSString = content as NSString
        let para: NSMutableParagraphStyle = NSMutableParagraphStyle()
        para.lineBreakMode = .ByWordWrapping
        
        let contentRect: CGRect = string.boundingRectWithSize(CGSize(width: ScreenWidth - 40, height: 0), options: Utils.combine(), attributes: [NSFontAttributeName: font, NSParagraphStyleAttributeName: para], context: nil)
        let contentHeight: CGFloat = contentRect.height
        
        return contentHeight
    }
    
}
