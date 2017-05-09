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
    var tableView: UITableView?
    var segmentIndex: Int = 0;
    let cellID:Array = ["reuseIdentifierLeft","reuseIdentifierRight"]
    var cellHeight:Array = Array<CGFloat>()
    var refreshControl: UIRefreshControl?
    private var netWorkApi = NetWorkApi()
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
        self.modelLeftArray = Array<CircleCellModel>()
        self.modelRightArray = Array<CircleHotCellModel>()
        let items = ["同城约球","热门动态"]
        self.segmented = UISegmentedControl(items:items)
        self.segmented.selectedSegmentIndex = 0 
        self.segmented.addTarget(self, action: #selector(segmentDidchange(segmented:)), for: .valueChanged)
        self.tableView = UITableView()
        self.view.addSubview(self.tableView!)
        self.tableView?.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-64)
        }
        self.tableView?.register(CircleLeftCell.classForCoder(), forCellReuseIdentifier: cellID[0])
        self.refreshControl = UIRefreshControl();
        self.tableView?.addSubview(self.refreshControl!);
        self.refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged);
    }
    
    
    func initData() {
        self.segmentIndex = 0;
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.reloadAboutBall()
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
        self.hidesBottomBarWhenPushed = true
        let next = BallDetailsVC();
        next.ballInformationModel.circleCellModel = modelLeftArray[indexPath.row]
        self.navigationController?.pushViewController(next, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.segmentIndex == 0{
            return 220/2.0
        }else if(self.segmentIndex == 1){
            return self.cellHeight[indexPath.row] + 80
        }else{
            return 0
        }
        
    }
    func segmentDidchange(segmented: UISegmentedControl){
        //获得选项的索引
        self.segmentIndex = segmented.selectedSegmentIndex
        if segmentIndex == 0{
            self.tableView?.register(CircleLeftCell.classForCoder(), forCellReuseIdentifier:     cellID[segmentIndex])
            self.reloadAboutBall()
        }else{
            self.tableView?.register(CircleRightCell.classForCoder(), forCellReuseIdentifier:     cellID[segmentIndex])
            self.reloadBallMessage()
        }
    }
    func loadData() {
        self.tableView?.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    func reloadAboutBall() {
        self.modelLeftArray.removeAll()
        self.netWorkApi.homeData(place: "", project: "", ball_object: "", block: {(json: Dictionary)-> Void in
            let status = json["status"] as! String
            if status == "1006"{
                var resultArray = Array<Dictionary<String, Any>>()
                resultArray = json["result"] as! Array
                for obj in resultArray {
                    let circleModel = CircleCellModel()
                    circleModel.headImageUrl = String(format:"http://127.0.0.1:8000/media/%@",obj["image"] as! String)
                    circleModel.subjectTitle = obj["project"] as! String
                    let timeStr = obj["current_time"] as! String
                    let index = timeStr.index(timeStr.startIndex, offsetBy: 19)
                    circleModel.time = timeStr.substring(to: index)
                    circleModel.place = obj["place"] as! String
                    circleModel.format = obj["ball_object"] as! String
                    circleModel.places = obj["place"] as! String
                    circleModel.object = obj["ball_format"] as! String
                    circleModel.enrollment = String(format:"%d",obj["current_people"] as! CVarArg)
                    circleModel.cost = obj["money"] as! String
                    circleModel.ball_ID = obj["ball_ID"] as! String
                    circleModel.user_name = obj["user_name"] as! String
                    self.modelLeftArray.append(circleModel)
                }
                DispatchQueue.main.async(execute: {
                    self.tableView?.reloadData()
                })
            }
            else if status == "1005"{
                //无数据
            }else{
                
            }
        })

    }
    
    func reloadBallMessage() {
        self.modelRightArray.removeAll()
        self.netWorkApi.allBallMessage(block: {(json: Dictionary)-> Void in
            let status = json["status"] as! String
            if status == "1006"{
                var resultArray = Array<Dictionary<String, Any>>()
                resultArray = json["result"] as! Array
                for obj in resultArray {
                    let circleHotModel = CircleHotCellModel()
                    let imagePath = String(format:"http://127.0.0.1:8000/media/%@",obj["image"] as! String)
                    circleHotModel.imageUrlArray.append(imagePath)
                    let timeStr = obj["current_time"] as! String
                    let index = timeStr.index(timeStr.startIndex, offsetBy: 19)
                    circleHotModel.current_time = timeStr.substring(to: index)
                    circleHotModel.contentText = obj["message"] as! String
                    circleHotModel.user_id = obj["user_id"] as! String
                    circleHotModel.user_image = obj["user_image"] as! String
                    circleHotModel.user_id = obj["user_id"] as! String
                    circleHotModel.user_name = obj["user_name"] as! String
                    circleHotModel.pointPraise = String(format:"%d",obj["num"] as! CVarArg)
                    circleHotModel.zanUser = obj["zan_userId"]as! Array
                    self.modelRightArray.append(circleHotModel)
                }
                DispatchQueue.main.async(execute: {
                    let calculateCellHeight = CalculateCellHeight()
                    print(self.modelRightArray)
                    self.cellHeight = calculateCellHeight.calculateCellHeight(array: self.modelRightArray)
                    self.tableView?.reloadData()
                })
            }
            else if status == "1005"{
                //无数据
            }else{
                
            }
        })

    }
}

