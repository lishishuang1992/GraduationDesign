//
//  CircleOfFriendsViewController.swift
//  君子好球
//
//  Created by 李世爽 on 2017/2/22.
//  Copyright © 2017年 shuang. All rights reserved.
//

import UIKit

class UserToBallMessage: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var modelRightArray = Array<CircleHotCellModel>()
    var tableView: UITableView?
    let cellID:String = "reuseIdentifierLeft"
    var cellHeight:Array = Array<CGFloat>()
    var zanLabelHeight:Array = Array<CGFloat>()  //点赞名字高度
    private var netWorkApi = NetWorkApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        // Do any additional setup after loading the view.
        self.initView()
        self.initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //init View
    func initView() {
        self.tableView = UITableView()
        self.view.addSubview(self.tableView!)
        self.tableView?.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-64)
        }
        self.tableView?.register(CircleRightCell.classForCoder(), forCellReuseIdentifier: cellID)
    }
    
    
    func initData() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.reloadBallMessage()
    }
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return modelRightArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CircleRightCell
            cell.postData(hotCellModel: self.modelRightArray[indexPath.row])
            cell.selectionStyle = .none;
            return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    // mark 设置编辑的样式
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle{
        return UITableViewCellEditingStyle.delete
    }
    //删除cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete{
         self.netWorkApi.deleteBallMessage(user_id:UserDefaults.standard.object(forKey:"user_id") as! String ,message_id:self.modelRightArray[indexPath.row].message_id, block: {(json: Dictionary)-> Void in
                print(json)
                let status = json["status"] as! String
                if status == "1006"{
                    DispatchQueue.main.async(execute: {
                       // print("删除成功")
                        self.showNoticeText("删除成功")
                        self.modelRightArray.remove(at: indexPath.row)
                        self.tableView?.deleteRows(at: [indexPath], with: UITableViewRowAnimation.top)
                    })
                }
                else if status == "1004"{
                    //print("删除失败")
                    self.showNoticeText("删除失败")
                }else{
                    
                }
            })
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return self.cellHeight[indexPath.row] + 100 + self.zanLabelHeight[indexPath.row]
    }
    func reloadBallMessage() {
        self.modelRightArray.removeAll()
        self.netWorkApi.allBallMessage(user_id:UserDefaults.standard.object(forKey:"user_id") as! String, block: {(json: Dictionary)-> Void in
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
                    if (obj["user_image"] as? String) != nil
                    {
                        circleHotModel.user_image = String(format:"http://127.0.0.1:8000/media/%@",obj["user_image"] as! String)
                    }else{
                        circleHotModel.user_image = "default"
                    }
                    circleHotModel.user_id = obj["user_id"] as! String
                    circleHotModel.message_id = obj["message_id"] as! String
                    circleHotModel.user_name = obj["user_name"] as! String
                    circleHotModel.pointPraise = String(format:"%d",obj["num"] as! Int)
                    circleHotModel.zanUser = obj["zan_userId"]as! Array
                    self.modelRightArray.append(circleHotModel)
                }
                DispatchQueue.main.async(execute: {
                    let calculateCellHeight = CalculateCellHeight()
                    calculateCellHeight.cellArray = self.modelRightArray
                    self.cellHeight = calculateCellHeight.calculateCellImageHeight()
                    self.zanLabelHeight = calculateCellHeight.calculateCellZanHeight()
                    self.tableView?.reloadData()
                })
            }
            else if status == "1005"{
                //无数据
                self.showNoticeText("无数据")
            }else{
                
            }
        })
    }
    override func showNoticeText(_ text: String) {
        D3NoticeManager.sharedInstance.showText(text,time:D3NoticeManager.longTime,autoClear:true)
    }
}


