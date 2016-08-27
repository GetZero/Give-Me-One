//
//  HomeModel.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/25.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//
//-地址：http://bea.wufazhuce.com/OneForWeb/one/getHp_N
//-参数：
//-1. 日期（strDate）
//-2. 当前页的下标（strRow）
//-列子：http://bea.wufazhuce.com/OneForWeb/one/getHp_N?strDate=2015-07-23&strRow=1
//-返回数据：
//-{
//    - "hpEntity": {
//        - "strLastUpdateDate": "2015-07-22 15:50:45",
//        - "strDayDiffer": "",
//        - "strHpId": "1043",
//        - "strHpTitle": "VOL.1024",
//        - "strThumbnailUrl": "http:\/\/pic.yupoo.com\/hanapp\/EOTa3fZW\/69lSZ.jpg",
//        - "strOriginalImgUrl": "http:\/\/pic.yupoo.com\/hanapp\/EOTa3fZW\/69lSZ.jpg",
//        - "strAuthor": "花&高思远 作品",
//        - "strContent": "分别是，从此就一个人站在茫茫人群中，一个人站在世界上。我的每句话、每件事，都不能再说给你听。 by 苏更生",
//        - "strMarketTime": "2015-07-28",
//        - "sWebLk": "http:\/\/m.wufazhuce.com\/one\/2015-07-28",
//        - "strPn": "20592",
//        - "wImgUrl": "http:\/\/211.152.49.184:9000\/upload\/onephoto\/f1437551445290.jpg"
//        - },
//    - "result": "SUCCESS"
//    -}

import UIKit

class HomeModel: NSObject {

    var strLastUpdateDate: String = "暂无数据"
    var strDayDiffer: String = "暂无数据"
    var strHpId: String = "暂无数据"
    var strHpTitle: String = "暂无数据"
    var strThumbnailUrl: String = "暂无数据"
    var strOriginalImgUrl: String = "暂无数据"
    var strAuthor: String = "暂无数据"
    var strContent: String = "暂无数据"
    var strMarketTime: String = "暂无数据"
    var sWebLk: String = "暂无数据"
    var strPn: String = "暂无数据"
    var wImgUrl: String = "暂无数据"
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
}
