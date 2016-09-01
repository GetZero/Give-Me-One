//
//  HomeDataManager.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/25.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

enum NetworkFinishType: String {
    case NetworkFaile = "Failure"
    case NetworkSuccess = "Success"
    case Default = "Default"
}

class HomeModel: NSObject {
    
    var homeDatas: [HomeData] = []
    var resultType: NetworkFinishType = .Default
    dynamic var resultTypeString: String = "Default"
    var networkError: NSError?
    
    func startNetwork(day: Int) {
        let parameters: [String: AnyObject] = ["strDate": GetTime.getBeforeDay(day), "strRow": "\(1)"]
        
        Networking.get(HomeURLString, parameters: parameters, headers: nil, successAction: { (respondsToSuccessAction) in
            let data: [String: String] = respondsToSuccessAction["hpEntity"] as! [String: String]
            let model: HomeData = HomeData(dict: data)
            self.homeDatas.append(model)
            
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

struct HomeData {
    
    var strHpTitle: String = "暂无数据"         // 期号
    var strOriginalImgUrl: String = "暂无数据"  // 图片
    var strAuthor: String = "暂无数据"          // 作者
    var strContent: String = "暂无数据"         // 内容
    var strMarketTime: String = "暂无数据"      // 时间
    
    init(dict: [String: String]) {
        strHpTitle = dict["strHpTitle"]!
        strOriginalImgUrl = dict["strOriginalImgUrl"]!
        strAuthor = dict["strAuthor"]!
        strContent = dict["strContent"]!
        strMarketTime = dict["strMarketTime"]!
    }
    
}
