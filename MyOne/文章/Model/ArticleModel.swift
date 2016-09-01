//
//  ArticleDataManager.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/27.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class ArticleModel: NSObject {
    
    var articleModels: [ArticleModel] = []
    var articleDatas: [ArticleData] = []
    private var resultType: NetworkFinishType = .Default
    private dynamic var resultTypeString: String = "Default"
    var networkError: NSError?
    
    func startNetwork(day: Int) {
        let parameters: [String: AnyObject] = ["strDate": GetTime.getBeforeDay(day), "strRow": "1"]
        
        Networking.get(ArticleURLString, parameters: parameters, headers: nil, successAction: { (respondsToSuccessAction) in
            dispatch_async(dispatch_get_global_queue(0, 0), { 
                let data: [String: String] = respondsToSuccessAction["contentEntity"] as! [String: String]
                let model: ArticleData = ArticleData(dict: data)
                self.articleDatas.append(model)
                
                self.resultType = .NetworkSuccess
                self.resultTypeString = self.resultType.rawValue
            })
        }) { (respondsToErrorAction) in
            debugPrint(respondsToErrorAction)
            
            self.resultType = .NetworkFaile
            self.resultTypeString = self.resultType.rawValue
        }
    }
    
    func resultKeyPath() -> String {
        return "resultTypeString"
    }

}

struct ArticleData {
    var strContMarketTime: String = "暂无数据"  // 时间
    var strContTitle: String = "暂无数据"       // 标题
    var strContAuthor: String = "暂无数据"      // 作者
    var strContent: String = "暂无数据"         // 内容
    var sAuth: String = "暂无数据"              // 作者简介
    var sWbN: String = "暂无数据"               // 艾特
    var contentHeight: CGFloat = 0
    var briefHeight: CGFloat = 0
    
    init(dict: [String: String]) {
        strContMarketTime = dict["strContMarketTime"]!
        strContTitle = dict["strContTitle"]!
        strContAuthor = dict["strContAuthor"]!
        strContent = dict["strContent"]!
        sAuth = dict["sAuth"]!
        sWbN = dict["sWbN"]!
        
        self.strContent = self.strContent.stringByReplacingOccurrencesOfString("<br>", withString: "")
        self.contentHeight = self.calculatorContentHeight(self.strContent)
        briefHeight = calculatorBreifHeight(sAuth)
    }
    
    private func calculatorContentHeight(content: String) -> CGFloat {
        let string: NSString = content as NSString
        let para: NSMutableParagraphStyle = NSMutableParagraphStyle()
        para.lineBreakMode = .ByWordWrapping
        
        let contentRect: CGRect = string.boundingRectWithSize(CGSize(width: ScreenWidth - 20, height: 0), options: Utils.combine(), attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14), NSParagraphStyleAttributeName: para], context: nil)
        let contentHeight: CGFloat = contentRect.height
        
        return contentHeight
    }
    
    private func calculatorBreifHeight(content: String) -> CGFloat {
        let string: NSString = content as NSString
        let para: NSMutableParagraphStyle = NSMutableParagraphStyle()
        para.lineBreakMode = .ByWordWrapping
        
        let contentRect: CGRect = string.boundingRectWithSize(CGSize(width: ScreenWidth - 20, height: 0), options: Utils.combine(), attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14), NSParagraphStyleAttributeName: para], context: nil)
        let contentHeight: CGFloat = contentRect.height + 10
        
        return contentHeight
    }
}
