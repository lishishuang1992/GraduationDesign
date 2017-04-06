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
        ballInformationModel.nickname = "小李"
        ballInformationModel.project = "篮球"
        ballInformationModel.introduce = "阿斯顿发哈加快地方哈哈地方哈地方哈快大法好的发掘"
        ballInformationModel.deadLine = "2017年4月10日"
        
        let enrolmentFormModel1 = EnrolmentFormModel()
        enrolmentFormModel1.headImageUrl = "http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg"
        enrolmentFormModel1.nickname = "李世爽"
        enrolmentFormModel1.time = "2017:2:23"
        enrolmentFormModel1.registrationStatus = "0"
        
        let enrolmentFormModel2 = EnrolmentFormModel()
        enrolmentFormModel2.headImageUrl = "http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg"
        enrolmentFormModel2.nickname = "liu"
        enrolmentFormModel2.time = "2017:2:23"
        enrolmentFormModel2.registrationStatus = "1"
        
        let enrolmentFormModel3 = EnrolmentFormModel()
        enrolmentFormModel3.headImageUrl = "http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg"
        enrolmentFormModel3.nickname = "waner"
        enrolmentFormModel3.time = "2017:2:23"
        enrolmentFormModel3.registrationStatus = "2"
        ballInformationModel.enrolmentFormModel.append(enrolmentFormModel1)
        ballInformationModel.enrolmentFormModel.append(enrolmentFormModel2)
        ballInformationModel.enrolmentFormModel.append(enrolmentFormModel3)
        
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
            return Int(ballInformationModel.enrolmentFormModel.count)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HeadNameCell
            cell.postPublisherData(ballInformationModel: ballInformationModel)
            return cell
        }else if indexPath.section == 1{
            self.tableView.register(BallDetailsCell.classForCoder(), forCellReuseIdentifier:cellIDBall)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDBall, for: indexPath) as! BallDetailsCell
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
            label.text = "报名成功: " + ballInformationModel.circleCellModel.places + "/" + ballInformationModel.circleCellModel.enrollment
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




}
