//
//  SomethingDataManager.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/27.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class SomethingModel: NSObject {
    
    var somethingDatas: [SomethingData] = []
    private var resultType: NetworkFinishType = .Default
    private dynamic var resultTypeString: String = "Default"

    func startNetwork(day: Int) {
        let parameters: [String: AnyObject] = ["strDate": GetTime.getBeforeDay(day), "strRow": "\(1)"]
        
        Networking.get(SomethingURLString, parameters: parameters, headers: nil, successAction: { (respondsToSuccessAction) in
            let data: [String: String] = respondsToSuccessAction["entTg"] as! [String: String]
            let model: SomethingData = SomethingData(dict: data)
            self.somethingDatas.append(model)
            
            self.resultType = NetworkFinishType.NetworkSuccess
            self.resultTypeString = self.resultType.rawValue
        }) { (respondsToErrorAction) in
            debugPrint(respondsToErrorAction)
            
            self.resultType = NetworkFinishType.NetworkFaile
            self.resultTypeString = self.resultType.rawValue
        }
    }
    
    func resultKeyPath() -> String {
        return "resultTypeString"
    }
}

struct SomethingData {
    
    var strTm: String = "暂无数据"
    var strBu: String = "暂无数据"
    var strTt: String = "暂无数据"
    var strTc: String = "暂无数据"
    var contentHeight: CGFloat = 0
    
    init(dict: [String: String]) {
        strTm = dict["strTm"]!
        strBu = dict["strBu"]!
        strTt = dict["strTt"]!
        strTc = dict["strTc"]!
        contentHeight = calculatorContentHeight(strTc)
    }
    
    private func calculatorContentHeight(content: String) -> CGFloat {
        let contentRect: CGRect = (content as NSString).boundingRectWithSize(CGSize(width: ScreenWidth - 40, height: 0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(13.5)], context: nil)
        
        return contentRect.height
    }
    
}
