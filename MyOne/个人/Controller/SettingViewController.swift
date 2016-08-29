//
//  SettingViewController.swift
//  MyOne
//
//  Created by 韦曲凌 on 16/8/30.
//  Copyright © 2016年 Wake GetZero. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "NightModeCell", bundle: nil), forCellReuseIdentifier: "NightModeCell")
        tableView.registerNib(UINib(nibName: "OtherSettingCell", bundle: nil), forCellReuseIdentifier: "OtherSettingCell")
        tableView.registerNib(UINib(nibName: "LogoutCell", bundle: nil), forCellReuseIdentifier: "LogoutCell")
        tableView.rowHeight = 44
        tableView.bounces = false
        
        let footerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeightWithoutNavAndTab - 440))
        footerView.backgroundColor = UIColor.RGBColor(247, green: 247, blue: 247, alpha: 1)
        tableView.tableFooterView = footerView
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 3
        case 3:
            return 1
            
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "浏览设置"
        case 1:
            return "缓存设置"
        case 2:
            return "更多"
        case 3:
            return " "
            
        default:
            return ""
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: NightModeCell = tableView.dequeueReusableCellWithIdentifier("NightModeCell", forIndexPath: indexPath) as! NightModeCell
            return cell
        } else if indexPath.section == 1 {
            let cell: OtherSettingCell = tableView.dequeueReusableCellWithIdentifier("OtherSettingCell", forIndexPath: indexPath) as! OtherSettingCell
            cell.titleLabel.text = "清除缓存"
            return cell
        } else if indexPath.section == 2 {
            let cell: OtherSettingCell = tableView.dequeueReusableCellWithIdentifier("OtherSettingCell", forIndexPath: indexPath) as! OtherSettingCell
            let titles: [String] = ["去评分", "反馈", "用户协议"]
            cell.titleLabel.text = titles[indexPath.row]
            return cell
        } else {
            let cell: LogoutCell = tableView.dequeueReusableCellWithIdentifier("LogoutCell", forIndexPath: indexPath) as! LogoutCell
            return cell
        }
    }

}
