//
//  BallDetailsVC.swift
//  君子好球
//
//  Created by 李世爽 on 2017/4/5.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class BallDetailsVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView = UITableView()
    let cellID:String = "HeadNameCell"
    let cellIDBall:String = "BallDetailsCell"
    var joinButton = UIButton()
    private var netWorkApi = NetWorkApi()
    //测试数据
    var circleCellModel = CircleCellModel()
    var enrolmentModelArray:Array<EnrolmentFormModel> = []
    //BallInformationModel
    var flag:Int = 0   //标记是否报名过
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.initData()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initView() {
        self.view.backgroundColor = UIColor.init(colorLiteralRed: 240/255.0, green: 255.0/255.0, blue: 240/255.0, alpha: 1.0)
        self.tableView = UITableView()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-60)
        }
        self.tableView.register(HeadNameCell.classForCoder(), forCellReuseIdentifier:cellID)
       
        self.joinButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15) //文字大小
        self.joinButton.setTitle("报名", for: .normal)
        self.joinButton.addTarget(self, action: #selector(joinButtonClick), for: .touchUpInside)
        self.joinButton.layer.cornerRadius = 5
        self.joinButton.backgroundColor = UIColor.init(colorLiteralRed: 142/255.0, green: 229/255.0, blue: 238/255.0, alpha: 1.0)
        self.view.addSubview(self.joinButton)
        self.joinButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(80)
            make.right.equalTo(self.view).offset(-80)
            make.bottom.equalTo(self.view).offset(-10)
            make.height.equalTo(40)
        }
        
    }
    func initData() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        reloadSearchBallEnroll()
       
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0{
            return 1
        }else if(section == 1){
            return 1
        }else{
            return self.enrolmentModelArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HeadNameCell
            cell.postPublisherData(userName: self.circleCellModel.user_name ,image:self.circleCellModel.headImageUrl)
            cell.selectionStyle = .none;
            return cell
        }else if indexPath.section == 1{
            self.tableView.register(BallDetailsCell.classForCoder(), forCellReuseIdentifier:cellIDBall)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDBall, for: indexPath) as! BallDetailsCell
            cell.postData(circleCellModel: self.circleCellModel)
            cell.selectionStyle = .none;
            return cell
        }else{
             self.tableView.register(HeadNameCell.classForCoder(), forCellReuseIdentifier:cellID)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HeadNameCell
            cell.postApplicantData(enrolmentFormModel: self.enrolmentModelArray[indexPath.row])
            cell.selectionStyle = .none;
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 80
        }else if(indexPath.section == 1){
            return 350
        }else{
            return 60
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 10
        }else if section == 2{
            return 30
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 2 {
            let headView = UIView()
            headView.backgroundColor = UIColor.init(red: 207/255.0, green: 207/255.0, blue: 207/255.0, alpha: 1.0)
            headView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30)
            //报名成功
            let label = UILabel()
            label.textColor = UIColor.init(red: 238/255.0, green: 130/255.0, blue: 238/255.0, alpha: 1.0)
            label.textAlignment = .right
            label.font = UIFont.systemFont(ofSize: 13)
            label.text = "报名成功: " + self.circleCellModel.enrollment + "/" + self.circleCellModel.places
            headView.addSubview(label)
            label.snp.makeConstraints{ (make) in
                    make.centerY.equalTo(headView)
                    make.right.equalTo(headView).offset(-30)
                    make.width.equalTo(160)
                    make.height.equalTo(30)
            }
            return headView
        }else {
            return nil
        }
    }
    
    func reloadSearchBallEnroll() {
        self.netWorkApi.searchBallEnroll(ball_id:self.circleCellModel.ball_ID , block: {(json: Dictionary)-> Void in
            print(json)
            let status = json["status"] as! String
            if status == "1006"{
                var resultArray = Array<Dictionary<String, Any>>()
                resultArray = json["result"] as! Array
                for obj in resultArray {
                    let enrolmentModel = EnrolmentFormModel()
                    if (obj["image"] as? String) != nil
                    {
                        enrolmentModel.headImageUrl = String(format:"http://127.0.0.1:8000/media/%@",obj["image"] as! String)
                    }else{
                        enrolmentModel.headImageUrl = "default"
                    }
                    enrolmentModel.user_name = obj["user_name"] as! String
                    enrolmentModel.user_id = obj["user_id"] as! String
                    enrolmentModel.status = obj["status"] as! String
                    self.enrolmentModelArray.append(enrolmentModel)
                    //检查是否报名过  user_id
                    if UserDefaults.standard.object(forKey: "user_id")as!String == enrolmentModel.user_id{
                        self.flag = 1
                        //self.showNoticeText("用户已经报名")
                    }else{
                        //self.showNoticeText("报名成功")
                    }
                }
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                    if self.flag == 1{
                        self.joinButton.setTitle("取消报名", for: .normal)
                        //self.showNoticeText("取消报名成功")
                    }
                })
            }else if status == "1008" {
                print("没有用户报名")
            }else if status == "1005"{
                print("其他错误")
            }else{
                
            }
        })

    }
    

    func joinButtonClick() {
        //检查是否已经登录
        let str = (UserDefaults.standard.object(forKey: "user_id")as!String)
        if str.characters.count > 1{
            if self.flag == 0{  //没有报过名
                self.netWorkApi.ballEnroll(ball_id:self.circleCellModel.ball_ID, user_id:UserDefaults.standard.object(forKey: "user_id")as!String, block: {(json: Dictionary)-> Void in
                    //print(json)
                    let status = json["status"] as! String
                    if status == "1006"{
                        //print("报名成功")
                        DispatchQueue.main.async(execute: {
                            let enrolmentModel = EnrolmentFormModel()
                            enrolmentModel.user_name = UserDefaults.standard.object(forKey: "user_name")as!String
                            enrolmentModel.user_id = UserDefaults.standard.object(forKey: "user_id")as!String
                            enrolmentModel.status = "1"
                            enrolmentModel.headImageUrl = UserDefaults.standard.object(forKey: "headImageUrl")as!String
                            self.enrolmentModelArray.append(enrolmentModel)
                            let indexPath = NSIndexSet.init(index:2)
                            self.tableView.reloadSections(indexPath as IndexSet, with: .automatic)
                            self.joinButton.setTitle("取消报名", for: .normal)
                            self.flag = 1
                        })
                        self.showNoticeText("报名成功")
                        //更新,
                    }else if status == "1005"{
                        // print("其他错误")
                        self.showNoticeText("其他错误")
                    }else if status == "1008"{
                        self.showNoticeText("名额已满")
                    }
                })
            }else{ //取消报名
                self.netWorkApi.cancelBallEnroll(ball_id:self.circleCellModel.ball_ID, user_id:UserDefaults.standard.object(forKey: "user_id")as!String, block: {(json: Dictionary)-> Void in
                    //print(json)
                    let status = json["status"] as! String
                    if status == "1006"{
                        // print("取消报名成功")
                        self.showNoticeText("取消报名成功")
                        DispatchQueue.main.async(execute: {
                            self.enrolmentModelArray.remove(at: self.enrolmentModelArray.count-1)
                            let indexPath = NSIndexSet.init(index:2)
                            self.tableView.reloadSections(indexPath as IndexSet, with: .automatic)
                            self.joinButton.setTitle("报名", for: .normal)
                            self.flag = 0
                        })
                        //更新,
                    }else if status == "1005"{
                        print("其他错误")
                        self.showNoticeText("其他错误")
                    }else{
                        
                    }
                })
            }
        }else{
            self.showNoticeText("请登录后报名")
        }
    }
    override func showNoticeText(_ text: String) {
        D3NoticeManager.sharedInstance.showText(text,time:D3NoticeManager.longTime,autoClear:true)
    }

}
