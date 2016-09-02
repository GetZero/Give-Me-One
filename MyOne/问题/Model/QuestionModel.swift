//
//  QuestionDataManager.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/27.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class QuestionModel: NSObject {
    
    var questionDatas: [QuestionData] = []
    private var resultType: NetworkFinishType = .Default
    private dynamic var resultTypeString: String = "Default"
    var networkError: NSError?
    
    func startNetwork(day: Int) {
        let parameters: [String: AnyObject] = ["strDate": GetTime.getBeforeDay(day), "strRow": "1"]
        
        Networking.get(QuestionURLString, parameters: parameters, headers: nil, successAction: { (respondsToSuccessAction) in
            dispatch_async(dispatch_get_global_queue(0, 0), {
                self.dealWithData(respondsToSuccessAction["questionAdEntity"] as! [String: String])
            })
            }) { (respondsToErrorAction) in
                self.dealWithError(respondsToErrorAction)
        }
    }
    
    private func dealWithData(data: [String: String]) {
        let model: QuestionData = QuestionData(dict: data)
        questionDatas.append(model)
        
        resultType = NetworkFinishType.NetworkSuccess
        resultTypeString = resultType.rawValue
    }
    
    private func dealWithError(errorInfo: NSError) {
        debugPrint(errorInfo)
        
        resultType = NetworkFinishType.NetworkFaile
        resultTypeString = resultType.rawValue
    }
    
    func resultKeyPath() -> String {
        return "resultTypeString"
    }
    
}

struct QuestionData {
    
    var strQuestionContent: String = "暂无数据"
    var strAnswerTitle: String = "暂无数据"
    var strQuestionTitle: String = "暂无数据"
    var strQuestionMarketTime: String = "暂无数据"
    var strAnswerContent: String = "暂无数据"
    var questionHeight: CGFloat = 0
    var answerHeight: CGFloat = 0
    
    init(dict: [String: String]) {
        strQuestionContent = dict["strQuestionContent"]!
        strQuestionTitle = dict["strQuestionTitle"]!
        strQuestionMarketTime = dict["strQuestionMarketTime"]!
        strAnswerTitle = dict["strAnswerTitle"]!
        strAnswerContent = dict["strAnswerContent"]!
        
        strAnswerContent = strAnswerContent.stringByReplacingOccurrencesOfString("<br>", withString: "")
        questionHeight = calculatorContentHeight(strQuestionContent, font: UIFont.systemFontOfSize(14)) + 10
        answerHeight = calculatorContentHeight(strAnswerContent, font: UIFont.systemFontOfSize(14)) + 20
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
