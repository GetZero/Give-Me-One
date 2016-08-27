//
//  Networking.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/25.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

let HomeURLString: String = "http://bea.wufazhuce.com/OneForWeb/one/getHp_N"
let ArticleURLString: String = "http://bea.wufazhuce.com/OneForWeb/one/getOneContentInfo"
let QuestionURLString: String = "http://bea.wufazhuce.com/OneForWeb/one/getOneQuestionInfo"
let SomethingURLString: String = "http://bea.wufazhuce.com/OneForWeb/one/o_f"


class Networking: NSObject {
    
    class func get(URLString: String, parameters: [String: AnyObject], headers: [String: String]?, successAction: (respondsToSuccessAction: AnyObject) -> Void, errorAction: (respondsToErrorAction: NSError) -> Void) {
        Alamofire.request(.GET, URLString, parameters: parameters, encoding: .URLEncodedInURL, headers: headers).responseJSON { (response) in
            switch response.result {
            case .Success(let value): successAction(respondsToSuccessAction: value)
            case .Failure(let error): errorAction(respondsToErrorAction: error)
            }
        }
    }
    
    class func post(URLString: String, parameters: [String: AnyObject], headers: [String: String]?, successAction: (respondsToSuccessAction: AnyObject) -> Void, errorAction: (respondsToErrorAction: NSError) -> Void) {
        Alamofire.request(.POST, URLString, parameters: parameters, encoding: .URLEncodedInURL, headers: headers).responseJSON { (response) in
            switch response.result {
            case .Success(let value): successAction(respondsToSuccessAction: value)
            case .Failure(let error): errorAction(respondsToErrorAction: error)
            }
        }
    }
    
}
