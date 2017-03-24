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
            let message = UILabel()
            if indexPath.row == 0 {
                message.text = "查看收到的赞"
            }else{
                message.text = "查看发布的动态"
            }
            message.frame = CGRect(x :0,y :0,width :100,height :80)
            cell.contentView.addSubview(message)
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        //return CGFloat(heightForRoot[section])
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let rootView = UIView()
        //        if section == 0 {
        //
        //        }else{
        //            rootView.frame = CGRect(x:0 , y: 0, width: self.view.frame.size.width/2, height: 100)
        //            let exitLogin = UIButton()
        //            exitLogin.frame = CGRect(x:self.view.frame.size.width/2-40 ,y:60 ,width: 80,height:80)
        //            exitLogin.backgroundColor = UIColor.orange
        //            exitLogin.titleLabel?.text = "退出登录"
        //            exitLogin.addTarget(self, action:#selector(exitLoginClick), for:.touchUpInside)
        //            rootView.addSubview(exitLogin)
        //            
        //        }
        return rootView
    }

}
