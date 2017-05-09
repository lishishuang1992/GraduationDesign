//
//  AboutBallVC.swift
//  君子好球
//
//  Created by 李世爽 on 2017/4/6.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class AboutBallVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView = UITableView()
    let cellID:String = "HeadNameCell"
    var releaseButton: UIButton?
    var backBt: UIButton?
    //测试数据
    var ballInformationModel = BallInformationModel()
    //BallInformationModel
    
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
        //测试数据
        ballInformationModel.nickname = "小李"             //昵称
        ballInformationModel.project = "篮球"             //项目
        ballInformationModel.circleCellModel.format  = ""             //赛制
        ballInformationModel.circleCellModel.object = ""          //对象
        ballInformationModel.circleCellModel.cost  = ""             //费用
        ballInformationModel.circleCellModel.place = ""          //地点
        ballInformationModel.deadLine = "2017年4月10日"                  //截止时间
        ballInformationModel.circleCellModel.places = ""            //人数
        ballInformationModel.circleCellModel.subjectTitle = ""         //主题
        ballInformationModel.introduce = "阿斯顿发哈加快地方哈哈地方哈地方哈快大法好的发掘"    //简介

        
        
        self.view.backgroundColor = UIColor.init(colorLiteralRed: 240/255.0, green: 255.0/255.0, blue: 240/255.0, alpha: 1.0)
        let navView = UIView()
        navView.backgroundColor = UIColor.init(colorLiteralRed: 240/255.0, green: 255.0/255.0, blue: 240/255.0, alpha: 1.0)
        self.view.addSubview(navView)
        navView.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(64)
        }
        
        self.backBt = UIButton()
        self.backBt?.setTitle("取消", for: .normal)
        self.backBt?.titleLabel?.textColor = UIColor.red
        self.backBt?.addTarget(self, action: #selector(backBtClick), for: .touchUpInside)
        navView.addSubview(self.backBt!)
        self.backBt?.snp.makeConstraints{ (make) in
            make.left.equalTo(navView).offset(15)
            make.centerY.equalTo(navView)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        
        self.tableView = UITableView()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-60)
        }
        self.tableView.register(HeadNameCell.classForCoder(), forCellReuseIdentifier:cellID)
        
        self.releaseButton = UIButton()
        self.releaseButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15) //文字大小
        self.releaseButton?.setTitle("发布", for: .normal)
        self.releaseButton?.layer.cornerRadius = 5
        self.releaseButton?.backgroundColor = UIColor.init(colorLiteralRed: 142/255.0, green: 229/255.0, blue: 238/255.0, alpha: 1.0)
        self.view.addSubview(self.releaseButton!)
        self.releaseButton?.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(80)
            make.right.equalTo(self.view).offset(-80)
            make.bottom.equalTo(self.view).offset(-10)
            make.height.equalTo(40)
        }
        
    }
    func initData() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HeadNameCell
            cell.postPublisherData(ballInformationModel: ballInformationModel)
            return cell
        }else if indexPath.section == 1{
            self.tableView.register(BallDetailsCell.classForCoder(), forCellReuseIdentifier:cellID)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BallDetailsCell
            cell.postData(ballInformationModel: ballInformationModel)
            return cell
            
        }else{
            self.tableView.register(HeadNameCell.classForCoder(), forCellReuseIdentifier:cellID)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HeadNameCell
            cell.postApplicantData(enrolmentFormModel: ballInformationModel.enrolmentFormModel[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 80
        }else if(indexPath.section == 1){
            return 45
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
        return nil
    }
    func backBtClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
