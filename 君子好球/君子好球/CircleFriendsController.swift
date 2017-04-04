//
//  CircleOfFriendsViewController.swift
//  君子好球
//
//  Created by 李世爽 on 2017/2/22.
//  Copyright © 2017年 shuang. All rights reserved.
//

import UIKit

class CircleFriendsController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    private var segmented = UISegmentedControl()
    var modelLeftArray = Array<CircleCellModel>()
    var modelRightArray = Array<CircleHotCellModel>()
    var tableView = UITableView()
    var segmentIndex: Int = 0;
    let cellID:Array = ["reuseIdentifierLeft","reuseIdentifierRight"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        // Do any additional setup after loading the view.
        self.initView()
        self.initData()
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
   
        //测试数据
        let text1 = CircleCellModel()
        text1.headImageUrl = "http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg"
        text1.subjectTitle = "约个球吧1"
        text1.time = "2000年1月1日"
        text1.place = "黑龙江大学"
        text1.format = "个人赛"
        text1.places = "3"
        text1.enrollment = "0"
        text1.cost = "无"
        
        let text2 = CircleCellModel()
        text2.headImageUrl = "http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg"
        text2.subjectTitle = "约个球吧2"
        text2.time = "2000年1月2日"
        text2.place = "哈尔滨理工大学"
        text2.format = "个人赛"
        text2.places = "4"
        text2.enrollment = "0"
        text2.cost = "5¥"
        
        
        let text3 = CircleCellModel()
        text3.headImageUrl = "http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg"
        text3.subjectTitle = "约个球吧3"
        text3.time = "2000年1月3日"
        text3.place = "黑龙江大学C区"
        text3.format = "对抗赛"
        text3.places = "3"
        text3.enrollment = "2"
        text3.cost = "50$"
        
        let text4 = CircleCellModel()
        text4.headImageUrl = "http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg"
        text4.subjectTitle = "约个球吧4"
        text4.time = "2000年1月4日"
        text4.place = "黑龙江大学"
        text4.format = "团体赛"
        text4.places = "3"
        text4.enrollment = "4"
        text4.cost = "无"
        
        let text5 = CircleCellModel()
        text5.headImageUrl = "http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg"
        text5.subjectTitle = "约个球吧5"
        text5.time = "2000年1月5日"
        text5.place = "黑龙江大学A区"
        text5.format = "个人赛"
        text5.places = "3"
        text5.enrollment = "0"
        text5.cost = "无"
        
        //测试数据
        
        let textRight1 = CircleHotCellModel()
        textRight1.headImageUrl = "http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg"
        textRight1.nickname = "阿龙"
        textRight1.time = "2000年1月1日"
        textRight1.contentText = "一起嗨起来"
        textRight1.pointPraise = "3"
        textRight1.imageArray = [UIImage(named:"default_face")!,UIImage(named:"default_face")!]

        
        let textRight2 = CircleHotCellModel()
        textRight2.headImageUrl = "http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg"
        textRight2.nickname = "小李"
        textRight2.time = "2000年1月1日"
        textRight2.contentText = "一起嗨起来13而且俄 v 去玩儿去玩儿去玩儿去玩儿冯绍峰水淀粉"
        textRight2.pointPraise = "3"
        textRight2.imageArray = [UIImage(named:"default_face")!,UIImage(named:"default_face")!]

        let textRight3 = CircleHotCellModel()
        textRight3.headImageUrl = "http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg"
        textRight3.nickname = "咋呢噶"
        textRight3.time = "2000年1月1日"
        textRight3.contentText = "一起嗨起来请问范围乏味费"
        textRight3.pointPraise = "3"
        textRight3.imageArray = [UIImage(named:"default_face")!,UIImage(named:"default_face")!]
        
        let textRight4 = CircleHotCellModel()
        textRight4.headImageUrl = "http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg"
        textRight4.nickname = "暗示法"
        textRight4.time = "2000年1月1日"
        textRight4.contentText = "一起嗨起来其二去玩儿企鹅企鹅分"
        textRight4.pointPraise = "3"
        textRight4.imageArray = [UIImage(named:"default_face")!,UIImage(named:"default_face")!]
        
        let textRight5 = CircleHotCellModel()
        textRight5.headImageUrl = "http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg"
        textRight5.nickname = "阿斯顿发企鹅王企鹅其二"
        textRight5.time = "2000年1月1日"
        textRight5.contentText = "一起嗨起来"
        textRight5.pointPraise = "3"
        textRight5.imageArray = [UIImage(named:"default_face")!,UIImage(named:"default_face")!]
        
        self.modelLeftArray = Array<CircleCellModel>()
        self.modelLeftArray.append(text1)
        self.modelLeftArray.append(text2)
        self.modelLeftArray.append(text3)
        self.modelLeftArray.append(text4)
        self.modelLeftArray.append(text5)
        
        self.modelRightArray = Array<CircleHotCellModel>()
        self.modelRightArray.append(textRight1)
        self.modelRightArray.append(textRight2)
        self.modelRightArray.append(textRight3)
        self.modelRightArray.append(textRight4)
        self.modelRightArray.append(textRight5)
        
        
        
        
        let items = ["同城约球","热门动态"]
        self.segmented = UISegmentedControl(items:items)
        self.segmented.selectedSegmentIndex = 0 
        self.segmented.addTarget(self, action: #selector(segmentDidchange(segmented:)), for: .valueChanged)
        self.tableView = UITableView()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints{ (make) in
            make.edges.equalTo(self.view)
        }
        self.tableView.register(CircleLeftCell.classForCoder(), forCellReuseIdentifier: cellID[0])
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func initData() {
        self.segmentIndex = 0;
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if self.segmentIndex == 0{
            return modelLeftArray.count
        }else if(self.segmentIndex == 1){
            return modelRightArray.count
        }else{
            return 0
        }
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.segmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID[self.segmentIndex], for: indexPath) as! CircleLeftCell
            cell.postData(circleCellModel: modelLeftArray[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID[self.segmentIndex], for: indexPath) as! CircleRightCell
            //self.tableView.register(CircleLeftCell.classForCoder(), forCellReuseIdentifier: cellIDRight) as! CircleRightCell
            cell.postData(hotCellModel: modelRightArray[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.segmentIndex == 0{
            return 220/2.0
        }else if(self.segmentIndex == 1){
            return 300/2.0
        }else{
            return 0
        }
        
    }
    func segmentDidchange(segmented: UISegmentedControl){
        //获得选项的索引
        self.segmentIndex = segmented.selectedSegmentIndex
        if segmentIndex == 0{
           self.tableView.register(CircleLeftCell.classForCoder(), forCellReuseIdentifier:     cellID[segmentIndex])
        }else{
            self.tableView.register(CircleRightCell.classForCoder(), forCellReuseIdentifier:     cellID[segmentIndex])
        }
        self.tableView.reloadData()
    }
        // print(segmented.titleForSegmentAtIndex(segmented.selectedSegmentIndex))
}

