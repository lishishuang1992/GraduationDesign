//
//  MainTabController.swift
//  君子好球
//
//  Created by 李世爽 on 2017/2/22.
//  Copyright © 2017年 shuang. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let circleVC = CircleFriendsController()
        circleVC.tabBarItem.title = "球圈"
        circleVC.tabBarItem.image = UIImage(named: "circle")
        let releaseVC = ReleaseBallController()
        releaseVC.tabBarItem.title = "发布"
        releaseVC.tabBarItem.image = UIImage(named: "release")
        let userVC = UserCenterController()
        userVC.tabBarItem.title = "用户"
        userVC.tabBarItem.image = UIImage(named : "userCenter")
        self.viewControllers = [circleVC,releaseVC,userVC]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
