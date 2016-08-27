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

class HomeDataManager: NSObject {
    
    var homeModels: [HomeModel] = { return [] }()
    var resultType: NetworkFinishType = .Default
    dynamic var resultTypeString: String = "Default"
    var networkError: NSError?
    
    func startNetwork(day: Int) {
        let parameters: [String: AnyObject] = ["strDate": GetTime.getBeforeDay(day), "strRow": "\(1)"]
        
        Networking.get(HomeURLString, parameters: parameters, headers: nil, successAction: { (respondsToSuccessAction) in
            let data: [String: AnyObject] = respondsToSuccessAction["hpEntity"] as! [String: AnyObject]
            let model: HomeModel = HomeModel(dict: data)
            self.homeModels.append(model)
            
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
