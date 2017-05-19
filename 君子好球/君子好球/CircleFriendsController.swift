//
//  CircleOfFriendsViewController.swift
//  君子好球
//
//  Created by 李世爽 on 2017/2/22.
//  Copyright © 2017年 shuang. All rights reserved.
//

import UIKit

class CircleFriendsController: UIViewController,UITableViewDataSource,UITableViewDelegate,CircleRightCellDelegate {
    
    private var segmented = UISegmentedControl()
    var modelLeftArray = Array<CircleCellModel>()
    var modelRightArray = Array<CircleHotCellModel>()
    var tableView = UITableView()
    var segmentIndex: Int = 0;
    let cellID:Array = ["reuseIdentifierLeft","reuseIdentifierRight"]
    var cellImageHeight:Array = Array<CGFloat>()  //照片高度
    var cellTextHeight:Array = Array<CGFloat>()   //文本内容高度
    var refreshControl: UIRefreshControl?
    var zanLabelHeight:Array = Array<CGFloat>()  //点赞名字高度
    var zanBoolArray = Array<Bool>()   //标记是否点赞
    
    private var netWorkApi = NetWorkApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        // Do any additional setup after loading the view.
        self.initView()
        self.initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //reloadAboutBall()
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
        //print(self.view.frame.size.height,self.view.frame.origin.y)
       // self.view.backgroundColor = UIColor.red
        self.modelLeftArray = Array<CircleCellModel>()
        self.modelRightArray = Array<CircleHotCellModel>()
        let items = ["同城约球","热门动态"]
        self.segmented = UISegmentedControl(items:items)
        self.segmented.selectedSegmentIndex = 0 
        self.segmented.addTarget(self, action: #selector(segmentDidchange(segmented:)), for: .valueChanged)
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-44)
        }
        self.tableView.register(CircleLeftCell.classForCoder(), forCellReuseIdentifier: cellID[0])
        self.refreshControl = UIRefreshControl();
        self.tableView.addSubview(self.refreshControl!);
        self.refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged);
    }
    
    
    func initData() {
        self.segmentIndex = 0;
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
            self.zanBoolArray.append(cell.postData(hotCellModel: self.modelRightArray[indexPath.row]))
            cell.index = indexPath.row
            cell.selectionStyle = .none;
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.segmentIndex == 0) {
            self.hidesBottomBarWhenPushed = true
            let next = BallDetailsVC();
            next.circleCellModel = self.modelLeftArray[indexPath.row]
            self.navigationController?.pushViewController(next, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.segmentIndex == 0{
            return 220/2.0
        }else if(self.segmentIndex == 1){
            return self.cellTextHeight[indexPath.row] + 100 + self.cellImageHeight[indexPath.row] + self.zanLabelHeight[indexPath.row]
        }else{
            return 0
        }
        
    }
    func segmentDidchange(segmented: UISegmentedControl){
        //获得选项的索引
        self.segmentIndex = segmented.selectedSegmentIndex
        if segmentIndex == 0{
            self.tableView.register(CircleLeftCell.classForCoder(), forCellReuseIdentifier:     cellID[segmentIndex])
            self.reloadAboutBall()
        }else{
            self.tableView.register(CircleRightCell.classForCoder(), forCellReuseIdentifier:     cellID[segmentIndex])
            self.reloadBallMessage()
        }
    }
    func loadData() {
        if self.segmentIndex == 0 {
            reloadAboutBall()
        }else{
            reloadBallMessage()
        }
    }
    
    func reloadAboutBall() {
        self.modelLeftArray.removeAll()
        self.netWorkApi.homeData(user_id:"",place: "", project: "", ball_object: "", block: {(json: Dictionary)-> Void in
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
                    if let a = obj["num_people"] as? NSNumber {
                        circleModel.places =  a.stringValue
                    }
                    circleModel.object = obj["ball_format"] as! String
                    if let a = obj["current_people"] as? NSNumber {
                        circleModel.enrollment =  a.stringValue
                    }
                    circleModel.introduction = obj["introduction"] as! String
                    circleModel.cost = obj["money"] as! String
                    circleModel.ball_ID = obj["ball_ID"] as! String
                    circleModel.user_name = obj["user_name"] as! String
                    self.modelLeftArray.append(circleModel)
                }
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                })
            }
            else if status == "1005"{
                //无数据
                self.showNoticeText("无数据")
            }else{
                
            }
        })

    }
    
    func reloadBallMessage() {
        self.modelRightArray.removeAll()
        self.netWorkApi.allBallMessage(user_id:"",block: {(json: Dictionary)-> Void in
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
                    circleHotModel.message_id = obj["message_id"] as! String
                    if (obj["user_image"] as? String) != nil
                    {
                        circleHotModel.user_image = String(format:"http://127.0.0.1:8000/media/%@",obj["user_image"] as! String)
                    }else{
                        circleHotModel.user_image = "default"
                    }
                    circleHotModel.user_id = obj["user_id"] as! String
                    circleHotModel.user_name = obj["user_name"] as! String
                    circleHotModel.pointPraise = String(format:"%d",obj["num"] as! Int)
                    circleHotModel.zanUser = obj["zan_userId"]as! Array
                    self.modelRightArray.append(circleHotModel)
                }
                //网络请求成功后
                DispatchQueue.main.async(execute: { //计算图片，内容和点赞名字的高度
                    let calculateCellHeight = CalculateCellHeight()
                    calculateCellHeight.cellArray = self.modelRightArray
                    self.cellTextHeight = calculateCellHeight.calculateCellTextHeight()
                    self.cellImageHeight = calculateCellHeight.calculateCellImageHeight()
                    self.zanLabelHeight = calculateCellHeight.calculateCellZanHeight()
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                })
            }
            else if status == "1005"{
                //无数据
                self.showNoticeText("无数据")
            }else{
                
            }
        })

    }
   // CircleRightCellDelegate
    func praiseBtClick(sender:UIButton){    //点赞
        //检查是否已经登录
        let str = (UserDefaults.standard.object(forKey: "user_id")as!String)
        if str.characters.count > 1{
            
            if self.zanBoolArray[sender.tag]{ //已经点赞——取消点赞
                self.netWorkApi.canleZanMessage(user_id:UserDefaults.standard.object(forKey: "user_id") as! String,message_id:self.modelRightArray[sender.tag].message_id,block: {(json: Dictionary)-> Void in
                    let status = json["status"] as! String
                    if status == "1006"{
                        print("取消赞成功")
                        self.zanBoolArray[sender.tag] = false
                       // self.modelRightArray[sender.tag].zanUser.removeLast()
                        var i = 0
                        for zanUser in self.modelRightArray[sender.tag].zanUser{
                            if zanUser["user_id"]as!String == UserDefaults.standard.object(forKey: "user_id")as!String{
                                self.modelRightArray[sender.tag].zanUser.remove(at: i)
                            }
                            i = i + 1
                        }
                        let indexPath = NSIndexPath.init(row: sender.tag, section: 0)
                        let myCell = self.tableView.cellForRow(at: indexPath as IndexPath) as!CircleRightCell
                        DispatchQueue.main.async(execute: {
                            myCell.praiseBt.setImage(UIImage(named:"heart_gray"), for: .normal)
                            //更新内容
                            self.zanLabelHeight[sender.tag] = myCell.upDataZanText(hotCellModel: self.modelRightArray[sender.tag])
                            //只更新高度，不更新内容
                            self.tableView.beginUpdates()
                            self.tableView.endUpdates()
                        })
                    }
                })
            }else{  //没有点赞
                self.netWorkApi.zanMessage(user_id:UserDefaults.standard.object(forKey: "user_id") as! String,message_id:self.modelRightArray[sender.tag].message_id,block: {(json: Dictionary)-> Void in
                    let status = json["status"] as! String
                    if status == "1006"{
                        print("点赞成功")
                        self.zanBoolArray[sender.tag] = true   //更改标记
                        let dict = ["user_name":UserDefaults.standard.object(forKey: "user_name"),"user_id":UserDefaults.standard.object(forKey: "user_id")]
                        self.modelRightArray[sender.tag].zanUser.append(dict)
                        let indexPath = NSIndexPath.init(row: sender.tag, section: 0)
                        let myCell = self.tableView.cellForRow(at: indexPath as IndexPath) as!CircleRightCell       //获取cell
                        DispatchQueue.main.async(execute: {
                            myCell.praiseBt.setImage(UIImage(named:"heart"), for: .normal)
                            //更新内容
                            self.zanLabelHeight[sender.tag] = myCell.upDataZanText(hotCellModel: self.modelRightArray[sender.tag])
                            //只更新cell高度，不更cell新内容
                            self.tableView.beginUpdates()
                            self.tableView.endUpdates()
                        })
                    }else{
                        self.showNoticeText("点赞失败")
                    }
                })
                    

            }
        }else{
            self.showNoticeText("您还未登录")
        }
    }
    func headImageBtClick(sender:UIButton){
        
    }
    func shareBtClick(sender:UIButton){      //分享
        //检查是否已经登录
        let str = (UserDefaults.standard.object(forKey: "user_id")as!String)
        if str.characters.count > 1{
            let textToShare = "球类约友app"
            let imageData = NSData.init(contentsOf: URL.init(string:self.modelRightArray[sender.tag].imageUrlArray[0])!)
            let imageToShare:UIImage = UIImage.init(data: imageData! as Data)!
            let urlToShare:URL = URL.init(string:"http://127.0.0.1:8000/admin/resertBallMessage")!
            let activityItems = [urlToShare,textToShare,imageToShare] as [Any]
            let shareVc = UIActivityViewController.init(activityItems: activityItems, applicationActivities: nil)
            self.navigationController?.present(shareVc, animated:true, completion: {
                
            })

        }else{
            self.showNoticeText("您还未登录")
        }
    }
    
    override func showNoticeText(_ text: String) {
        D3NoticeManager.sharedInstance.showText(text,time:D3NoticeManager.longTime,autoClear:true)
    }
}

