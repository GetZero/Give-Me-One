//
//  QuestionDataManager.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/27.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class QuestionDataManager: NSObject {
    
    var questionModels: [QuestionModel] = []
    private var resultType: NetworkFinishType = .Default
    private dynamic var resultTypeString: String = "Default"
    var networkError: NSError?
    
    func startNetwork(day: Int) {
        let parameters: [String: AnyObject] = ["strDate": GetTime.getBeforeDay(day), "strRow": "1"]
        
        Networking.get(QuestionURLString, parameters: parameters, headers: nil, successAction: { (respondsToSuccessAction) in
            dispatch_async(dispatch_get_global_queue(0, 0), { 
                let data: [String: AnyObject] = respondsToSuccessAction["questionAdEntity"] as! [String: AnyObject]
                let model: QuestionModel = QuestionModel(dict: data)
                self.questionModels.append(model)
                
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
