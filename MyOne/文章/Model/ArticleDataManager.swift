//
//  ArticleDataManager.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/27.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class ArticleDataManager: NSObject {
    
    var articleModels: [ArticleModel] = []
    private var resultType: NetworkFinishType = .Default
    private dynamic var resultTypeString: String = "Default"
    var networkError: NSError?
    
    func startNetwork(day: Int) {
        let parameters: [String: AnyObject] = ["strDate": GetTime.getBeforeDay(day), "strRow": "1"]
        
        Networking.get(ArticleURLString, parameters: parameters, headers: nil, successAction: { (respondsToSuccessAction) in
            dispatch_async(dispatch_get_global_queue(0, 0), { 
                let data: [String: AnyObject] = respondsToSuccessAction["contentEntity"] as! [String: AnyObject]
                let model: ArticleModel = ArticleModel(dict: data)
                self.articleModels.append(model)
                
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
