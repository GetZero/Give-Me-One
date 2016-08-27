//
//  SomethingModel.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/27.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//
//- "entTg": {
//    - "strLastUpdateDate": "2015-07-24 17:59:48",
//    - "strPn": "0",
//    - "strBu": "http:\/\/pic.yupoo.com\/hanapp\/EPcPLEFq\/KKBKE.jpg",
//    - "strTm": "2015-07-27",
//    - "strWu": "http:\/\/m.wufazhuce.com\/thing\/2015-07-27",
//    - "strId": "569",
//    - "strTt": "创意拼图",
//    - "strTc": "拼出一天好心情！"
//    - },

import UIKit

class SomethingModel: NSObject {
    
    var strTm: String = "暂无数据"
    var strBu: String = "暂无数据"
    var strTt: String = "暂无数据"
    var strTc: String = "暂无数据"

    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
