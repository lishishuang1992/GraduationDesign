//
//  CircleOfFriendsViewController.swift
//  君子好球
//
//  Created by 李世爽 on 2017/2/22.
//  Copyright © 2017年 shuang. All rights reserved.
//

import UIKit

class UserAboutBallVc: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var modelLeftArray = Array<CircleCellModel>()
    var tableView: UITableView?
    var cellID:String = "reuseIdentifier"
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
        self.modelLeftArray = Array<CircleCellModel>()
        self.tableView = UITableView()
        self.view.addSubview(self.tableView!)
        self.tableView?.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-64)
        }
        self.tableView?.register(CircleLeftCell.classForCoder(), forCellReuseIdentifier: cellID)
    }
    
    
    func initData() {
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
        return modelLeftArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CircleLeftCell
        cell.postData(circleCellModel: modelLeftArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.hidesBottomBarWhenPushed = true
        let next = ExamineVc();
        next.circleCellModel = self.modelLeftArray[indexPath.row]
        self.navigationController?.pushViewController(next, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220/2.0
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
            self.netWorkApi.deleteAboutBall(user_id:UserDefaults.standard.object(forKey:"user_id") as! String ,ball_ID:self.modelLeftArray[indexPath.row].ball_ID, block: {(json: Dictionary)-> Void in
                print(json)
                let status = json["status"] as! String
                if status == "1006"{
                    DispatchQueue.main.async(execute: {
                       // print("删除成功")
                        self.showNoticeText("删除成功")
                        self.modelLeftArray.remove(at: indexPath.row)
                        self.tableView?.deleteRows(at: [indexPath], with: UITableViewRowAnimation.top)
                    })
                }
                else if status == "1005"{
                   // print("删除失败")
                    self.showNoticeText("删除失败")
                }else{
                    
                }
            })
        }
    }
    func reloadAboutBall() {
        self.modelLeftArray.removeAll()
        self.netWorkApi.homeData(user_id:UserDefaults.standard.object(forKey:"user_id")as!String,place: "", project: "", ball_object: "", block: {(json: Dictionary)-> Void in
            let status = json["status"] as! String
            if status == "1006"{
                var resultArray = Array<Dictionary<String, Any>>()
                resultArray = json["result"] as! Array
                for obj in resultArray {
                    let circleModel = CircleCellModel()
                   // circleModel.headImageUrl = String(format:"http://127.0.0.1:8000/media/%@",obj["image"] as! String)
                    circleModel.ball_ID = obj["ball_ID"] as! String
                    //circleModel.user_name = obj["user_name"] as! String
                    circleModel.headImageUrl = "default"
                    circleModel.user_name = ""
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
                    self.modelLeftArray.append(circleModel)
                }
                DispatchQueue.main.async(execute: {
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

