//
//  SomethingDataManager.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/27.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class SomethingDataManager: NSObject {
    
    var somethingModels: [SomethingModel] = []
    private var resultType: NetworkFinishType = .Default
    private dynamic var resultTypeString: String = "Default"

    func startNetwork(day: Int) {
        let parameters: [String: AnyObject] = ["strDate": GetTime.getBeforeDay(day), "strRow": "\(1)"]
        
        Networking.get(SomethingURLString, parameters: parameters, headers: nil, successAction: { (respondsToSuccessAction) in
            let data: [String: AnyObject] = respondsToSuccessAction["entTg"] as! [String: AnyObject]
            let model: SomethingModel = SomethingModel(dict: data)
            self.somethingModels.append(model)
            
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
