//
//  ViewExtension.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/26.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

var standardColor: UIColor = UIColor.whiteColor()

extension UIActivityIndicatorView {
    class func juhuaActivityView(superView: UIView) -> UIActivityIndicatorView {
        let view: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        view.hidesWhenStopped = true
        view.center = superView.center
        
        return view
    }
}

extension UIView {
    class func circleView(superView: UIView) -> UIView {
        let frame: CGRect = superView.bounds
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: frame.height * 1.5, height: frame.height * 1.5))
        view.backgroundColor = UIColor.whiteColor()
        view.layer.cornerRadius = view.frame.width * 0.5
        view.layer.masksToBounds = true
        view.center = superView.center
        
        return view
    }
}

extension UICollectionView {
    class func standardCollectionView(cell: String) -> UICollectionView {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ScreenWidth, height: ScreenHeightWithoutNavAndTab)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        
        let view: UICollectionView = UICollectionView(frame: ScreenRectWithoutNavBar, collectionViewLayout: layout)
        view.backgroundColor = UIColor.whiteColor()
        view.showsHorizontalScrollIndicator = false
        view.registerNib(UINib(nibName: cell, bundle: nil), forCellWithReuseIdentifier: cell)
        view.pagingEnabled = true
        view.bounces = false
        
        return view
    }
}

extension UIAlertController {
    class func networkErrorAlert(viewController: UIViewController) -> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: "网络错误", message: "关闭飞行模式或者使用无线局域网来访问数据", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "确定", style: .Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
        
        return alert
    }
}

extension UILabel {
    class func networkErrorWarning(view: UIView) -> UILabel {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100))
        label.center = view.center
        label.backgroundColor = view.backgroundColor
        label.font = UIFont.systemFontOfSize(50)
        label.font = UIFont.boldSystemFontOfSize(30)
        label.numberOfLines = 1
        label.textColor = UIColor.lightGrayColor()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .Center
        label.hidden = true
        label.text = "无法连接到 My One"
        
        return label
    }
}

extension UIColor {
    class func RGBColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    class func nightModeOpenColor() {
        standardColor = UIColor.darkGrayColor()
    }
    
    class func nightModeCloseColor() {
        standardColor = UIColor.whiteColor()
    }
}
