//
//  ViewExtension.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/26.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    func juhuaActivityView(superView: UIView) -> UIActivityIndicatorView {
        let view: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        view.startAnimating()
        view.hidesWhenStopped = true
        view.center = superView.center
        
        return view
    }
}

extension UIView {
    func circleView(superView: UIView) -> UIView {
        let frame: CGRect = superView.bounds
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: frame.height * 1.5, height: frame.height * 1.5))
        view.backgroundColor = UIColor.whiteColor()
        view.layer.cornerRadius = view.frame.width * 0.5
        view.layer.masksToBounds = true
        view.center = superView.center
        
        return view
    }
}

extension UIColor {
    class func RGBColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}