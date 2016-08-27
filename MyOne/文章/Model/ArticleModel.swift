//
//  ArticleModel.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/27.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class ArticleModel: NSObject {
    
    var strContMarketTime: String = "暂无数据"  // 时间
    var strContTitle: String = "暂无数据"       // 标题
    var strContAuthor: String = "暂无数据"      // 作者
    var strContent: String = "暂无数据"         // 内容
    var sAuth: String = "暂无数据"              // 作者简介
    var sWbN: String = "暂无数据"               // 艾特
    var contentHeight: CGFloat = 0
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
        self.contentHeight = self.calculatorContentHeight(self.strContent)
        self.strContent = self.strContent.stringByReplacingOccurrencesOfString("<br>", withString: "")
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    private func calculatorContentHeight(content: String) -> CGFloat {
        let string: NSString = content as NSString
        let para: NSMutableParagraphStyle = NSMutableParagraphStyle()
        para.lineBreakMode = .ByWordWrapping
        
        let contentRect: CGRect = string.boundingRectWithSize(CGSize(width: ScreenWidth - 20, height: 0), options: Utils.combine(), attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14), NSParagraphStyleAttributeName: para], context: nil)
        let contentHeight: CGFloat = contentRect.height
        
        return contentHeight
    }

}
