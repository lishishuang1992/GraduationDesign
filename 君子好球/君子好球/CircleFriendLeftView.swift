//
//  CircleFriendLeftView.swift
//  君子好球
//
//  Created by 李世爽 on 17/3/23.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class CircleFriendLeftView: UITableView,UITableViewDataSource,UITableViewDelegate {

    var numOfSections: Int = 0
    var numOfRows = Array<Int>()
    var heightForHeader = Array<Int>()
    var heightForRow :CGFloat = 0
    let cellID = "reuseIdentifier"
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numOfRows[section]
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //        if indexPath.section == 0 {
        //
        //        }else if indexPath.section == 1{
        //            let message = UILabel()
        //            if indexPath.row == 0 {
        //                message.text = "查看收到的赞"
        //            }else{
        //                message.text = "查看发布的动态"
        //            }
        //            message.frame = CGRect(x :0,y :0,width :100,height :80)
        //            cell.contentView.addSubview(message)
        //        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(heightForHeader[section])
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        //        if section == 0 {
        //            self.headView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200)
        //            self.headView.backgroundColor = UIColor.gray
        //            self.headView.nameBt.titleLabel?.text = "小明"
        //            self.headView.addTargetNameBt(target: self, action:#selector(nameBtClick), for: .touchUpInside)
        //            self.headView.addTargetUserAvatar(target: self, action: #selector(userAvatarClick), for: .touchUpInside)
        //            self.headView.sinceAndReleaseNum(numSince: "1", numRelease: "2")
        //        }else if section == 1 {
        //            return nil
        //        }
        return headView
    }
    
 
}
