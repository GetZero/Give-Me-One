//
//  ViewController.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/24.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewControllerToTabBarViewController()
    }
    
    func addChildViewControllerToTabBarViewController() {
        let viewControllers: [UIViewController] = [HomeViewController(), ArticleViewController(), QuestionViewController(), SomethingViewController(), PersonalViewController()]
        let viewControllerTitles: [String] = ["首页", "文章", "问题", "东西", "个人"]
        let viewControllerImages: [String] = ["tabbar_item_home", "tabbar_item_reading", "tabbar_item_question", "tabbar_item_thing", "tabbar_item_person"]
        let viewControllerSelectedImages: [String] = ["tabbar_item_home_selected", "tabbar_item_reading_selected", "tabbar_item_question_selected", "tabbar_item_thing_selected", "tabbar_item_person_selected"]
        var navs: [UINavigationController] = []
        
        for index in 0 ..< viewControllers.count {
            let viewController: UIViewController = viewControllers[index]
            viewController.view.backgroundColor = UIColor.whiteColor()
            viewController.tabBarItem = UITabBarItem(title: viewControllerTitles[index], image: UIImage(named: viewControllerImages[index]), selectedImage: UIImage(named: viewControllerSelectedImages[index]))
            
            let nav: UINavigationController = UINavigationController(rootViewController: viewController)
            viewController.navigationItem.titleView = UIImageView(image: UIImage(named: "navLogo"))
            viewController.title = viewControllerTitles[index]
            navs.append(nav)
        }
        
        self.viewControllers = navs
        self.selectedIndex = 0
    }

}

