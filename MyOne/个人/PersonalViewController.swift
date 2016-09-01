//
//  PersonalViewController.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/29.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class PersonalViewController: UITableViewController {
    
    var titles: [String] = ["设置", "关于"]
    var images: [String] = ["setting", "copyright"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
        tableView.rowHeight = 80
        tableView.registerNib(UINib(nibName: "PersonalCell", bundle: nil), forCellReuseIdentifier: "PersonalCell")
        tableView.separatorStyle = .None
        tableView.bounces = false
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 30, height: 1))
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(titles.count, images.count)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: PersonalCell = tableView.dequeueReusableCellWithIdentifier("PersonalCell", forIndexPath: indexPath) as! PersonalCell

        cell.cellImage.image = UIImage(named: images[indexPath.row])
        cell.titleLabel.text = titles[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(SettingViewController(), animated: true)
        }
    }

}
