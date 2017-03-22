//
//  CircleOfFriendsViewController.swift
//  君子好球
//
//  Created by 李世爽 on 2017/2/22.
//  Copyright © 2017年 shuang. All rights reserved.
//

import UIKit

class CircleFriendsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        // Do any additional setup after loading the view.

        
        let items = ["同城约球","热门动态", UIImage(named: "star")!] as [Any]
        let segmented = UISegmentedControl(items:items)
        segmented.selectedSegmentIndex = 1 //默认选中第二项
        segmented.addTarget(self, action: #selector(segmentDidchange), for: .touchUpInside)
        self.view.addSubview(segmented)
        self.navigationController?.navigationBar.addSubview(segmented)
        
//        segmented.snp.makeConstraints { (make) in
//            make.top.equalTo((self.navigationController?.navigationBar.snp.top)!).offset(
//            10)
//            make.centerX.equalTo((self.navigationController?.navigationBar)!)
////            make.width.equalTo(80)
////            make.height.equalTo(20)
    //    }

//        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segmentDidchange(segmented:UISegmentedControl){
        //获得选项的索引
        //print(segmented.selectedSegmentIndex)
        //获得选择的文字
       // print(segmented.titleForSegmentAtIndex(segmented.selectedSegmentIndex))
    }
   

}
