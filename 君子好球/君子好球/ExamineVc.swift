//
//  CircleOfFriendsViewController.swift
//  君子好球
//
//  Created by 李世爽 on 2017/2/22.
//  Copyright © 2017年 shuang. All rights reserved.
//

import UIKit

class ExamineVc: UIViewController,UITableViewDataSource,UITableViewDelegate ,ExamineViewCellDelegate{
    var tableView: UITableView?
    let cellID:String = "reuseIdentifier"
    var circleCellModel = CircleCellModel()
    var enrolmentModelArray = Array<EnrolmentFormModel>()
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
        self.tableView?.register(ExamineViewCell.classForCoder(), forCellReuseIdentifier: cellID)
    }
    func initData() {
        reloadSearchBallEnroll()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.enrolmentModelArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ExamineViewCell
        cell.delegate = self
        cell.index = indexPath.row
        cell.postData(model: self.enrolmentModelArray[indexPath.row])
        cell.selectionStyle = .none;
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
//            self.netWorkApi.deleteAboutBall(user_id:UserDefaults.standard.object(forKey:"user_id") as! String ,ball_ID:self.modelLeftArray[indexPath.row].ball_ID, block: {(json: Dictionary)-> Void in
//                print(json)
//                let status = json["status"] as! String
//                if status == "1006"{
//                    DispatchQueue.main.async(execute: {
//                        print("删除成功")
//                        self.modelLeftArray.remove(at: indexPath.row)
//                        self.tableView?.deleteRows(at: [indexPath], with: UITableViewRowAnimation.top)
//                    })
//                }
//                else if status == "1005"{
//                    print("删除失败")
//                }else{
//                    
//                }
//            })
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
                    }
                    DispatchQueue.main.async(execute: {
                        self.tableView?.reloadData()
                    })
                }else if status == "1008" {
                    print("没有用户报名")
                }else if status == "1005"{
                    print("其他错误")
                }else{
                    
                }
            })
    }
    //ExamineViewCellDelegate
    func adoptBtClick(sender:UIButton) {//通过
        postAuditAbout(audio_status: "2",index:sender.tag)
    }
    func refuseBtClick(sender:UIButton) {
        postAuditAbout(audio_status: "0",index:sender.tag)
        
    }
    func postAuditAbout(audio_status:String,index:Int) {
        self.netWorkApi.auditAbout(user_id:self.enrolmentModelArray[index].user_id,ball_id:self.circleCellModel.ball_ID,audio_status:audio_status, block: {(json: Dictionary)-> Void in
            let status = json["status"] as! String
            if status == "1006"{
                print("审核成功")
                DispatchQueue.main.async(execute: {
                    self.enrolmentModelArray[index].status = audio_status
                    let indexPath = NSIndexPath.init(row: index, section: 0)
                    self.tableView?.reloadRows(at: [indexPath as IndexPath], with:.automatic)
                })
            }else if status == "1005" {
                print("失败")
            }else{
            }

        })
    }
}

