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