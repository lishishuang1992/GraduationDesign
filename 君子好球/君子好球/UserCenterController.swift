//
//  UserCenterController.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/1.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class UserCenterController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.title = "用户中心"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)



        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        if section == 0 {
            headView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200)
            headView.backgroundColor = UIColor.gray
            let userAvatar = UIButton()
            userAvatar.frame = CGRect(x:self.view.frame.size.width/2-40 ,y:60 ,width: 80,height:80)
            userAvatar.layer.cornerRadius = 80/2;
            userAvatar.layer.masksToBounds = true
            userAvatar.addTarget(self, action:#selector(userAvatarClick), for:.touchUpInside)
            userAvatar.setImage(UIImage(named:"default_face"),for:.normal)
            headView.addSubview(userAvatar)
            let nameLabel = UILabel()
            nameLabel.frame = CGRect(x:self.view.frame.size.width/2-60, y: 60+80+10,width:120, height: 30.0)
            nameLabel.backgroundColor = UIColor.clear
            nameLabel.textAlignment = .center
            nameLabel.text = "小李"
            headView.addSubview(nameLabel)
        }
        return headView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100;
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let rootView = UIView()
        if section == 0 {
            rootView.frame = CGRect(x:0 , y: 0, width: self.view.frame.size.width/2, height: 100)
            let exitLogin = UIButton()
            exitLogin.frame = CGRect(x:self.view.frame.size.width/2-40 ,y:60 ,width: 80,height:80)
            exitLogin.backgroundColor = UIColor.orange
            exitLogin.titleLabel?.text = "退出登录"
            exitLogin.addTarget(self, action:#selector(exitLoginClick), for:.touchUpInside)
            rootView.addSubview(exitLogin)
        }
        return rootView
    }

    
    func userAvatarClick() {
        
    }
    
    func exitLoginClick() {
        
    }

}
