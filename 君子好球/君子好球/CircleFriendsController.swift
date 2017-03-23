//
//  CircleOfFriendsViewController.swift
//  君子好球
//
//  Created by 李世爽 on 2017/2/22.
//  Copyright © 2017年 shuang. All rights reserved.
//

import UIKit

class CircleFriendsController: UIViewController {
    
    private var segmented = UISegmentedControl()
    private var leftView = CircleFriendLeftView()
    private var rightView = CircleFriendRightView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        // Do any additional setup after loading the view.
        self.initView()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.addSubview(self.segmented)
        self.segmented.snp.makeConstraints { (make) in
            make.top.equalTo((self.navigationController?.navigationBar.snp.top)!).offset(
                10)
            make.centerX.equalTo((self.navigationController?.navigationBar)!)
        }
        self.segmented.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.segmented.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //init View
    func initView() {
        let items = ["同城约球","热门动态"]
        self.segmented = UISegmentedControl(items:items)
        self.segmented.selectedSegmentIndex = 0 //默认选中第二项
        self.segmented.addTarget(self, action: #selector(segmentDidchange(segmented:)), for: .valueChanged)
        leftView.frame = self.view.frame
        rightView.frame = self.view.frame
        
        
        
    }
    //
    func segmentDidchange(segmented: UISegmentedControl){
        //获得选项的索引
        print(segmented.selectedSegmentIndex)
        //获得选择的文字
       // print(segmented.titleForSegmentAtIndex(segmented.selectedSegmentIndex))
    }
   

}
