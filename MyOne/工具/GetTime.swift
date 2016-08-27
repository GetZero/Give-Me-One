//
//  GetTime.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/25.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

enum GetMethod {
    case Day, Month, Year, Hour, Minute, Second, All
}

class GetTime: NSObject {
    
    class func getTime(TimeType: GetMethod) -> String {
        let date: NSDate = NSDate(timeIntervalSinceNow: 0)
        
        let dataFormatter: NSDateFormatter = NSDateFormatter()
        
        switch TimeType {
        case .Day:
            dataFormatter.dateFormat = "YYYY"
            return dataFormatter.stringFromDate(date)
        case .Month:
            dataFormatter.dateFormat = "MM"
            return dataFormatter.stringFromDate(date)
        case .Year:
            dataFormatter.dateFormat = "dd"
            return dataFormatter.stringFromDate(date)
        case .Hour:
            dataFormatter.dateFormat = "HH"
            return dataFormatter.stringFromDate(date)
        case .Minute:
            dataFormatter.dateFormat = "mm"
            return dataFormatter.stringFromDate(date)
        case .Second:
            dataFormatter.dateFormat = "ss"
            return dataFormatter.stringFromDate(date)
        case .All:
            dataFormatter.dateFormat = "YYYY年MM月dd日HH时mm分ss秒"
            return dataFormatter.stringFromDate(date)
        }
    }
    
    class func getBeforeDay(before: Int) -> String {
        let seconds: NSTimeInterval = 3600 * 24 * NSTimeInterval(before)
        let date: NSDate = NSDate(timeIntervalSinceNow: seconds)
        
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        return dateFormatter.stringFromDate(date)
    }
    
}
