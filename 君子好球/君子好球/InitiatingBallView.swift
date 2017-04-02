//
//  InitiatingBallView.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/24.
//  Copyright © 2017年 myself. All rights reserved.
//

//发起约球tableView

import UIKit

class InitiatingBallView: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    var numOfSections: Int = 0
//    var numOfRows = Array<Int>()
//    var heightForHeader = Array<Int>()
//    var heightForRoot = Array<Int>()
//    var heightForRow :CGFloat = 0
    let cellID = "reuseIdentifier"
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }else if section == 1{
            return 7
        }else if section == 2{
            return 2
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        if indexPath.section == 0 {
            //indexPath.row
        }else if indexPath.section == 1{
            if indexPath.row == 0 {
                cell.textLabel?.text = "查看收到的赞"
            }else{
                cell.textLabel?.text = "查看发布的动态"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 126
        }else if indexPath.section == 1 {
            return 90
        }else if indexPath.section == 2{
            return 90
        }
        return 0 
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //return CGFloat(heightForHeader[section])
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()

        return headView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let rootView = UIView()
//        return rootView
//    }

}
