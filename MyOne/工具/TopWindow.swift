//
//  TopWindow.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/28.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class TopWindow: UIWindow {

    private static let window: UIWindow = UIWindow()
    
    override class func initialize() {
        window.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 20)
        window.windowLevel = UIWindowLevelAlert
        window.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topWindowClick)))
        window.backgroundColor = UIColor.clearColor()
    }
    
    class func topWindowClick() {
        searchAllowScrollViewInView(UIApplication.sharedApplication().keyWindow!)
    }
    
    private class func searchAllowScrollViewInView(superView: UIView) {
        for subView: UIView in superView.subviews {
            if subView.isKindOfClass(UIScrollView) && superView.isInKeyWindow() {
                var offset = (subView as! UIScrollView).contentOffset
                offset.y = -(subView as! UIScrollView).contentInset.top
                (subView as! UIScrollView).setContentOffset(offset, animated: true)
            }
            searchAllowScrollViewInView(subView)
        }
    }
    
    class func showTopWindow() {
        window.hidden = false
    }
    
    class func hiddenTopWindow() {
        window.hidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension UIView {
    func isInKeyWindow() -> Bool {
        let keyWindow: UIWindow = UIApplication.sharedApplication().keyWindow!
        let viewFrame: CGRect = keyWindow.convertRect(self.frame, fromView: self.superview)
        let keyWindowBounds: CGRect = keyWindow.bounds
        
        let isIntersects: Bool = CGRectIntersectsRect(viewFrame, keyWindowBounds)
        
        return !self.hidden && self.alpha > 0.01 && self.window == keyWindow && isIntersects
    }
}
