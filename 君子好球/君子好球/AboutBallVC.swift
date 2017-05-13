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
    let cellID:Array<String> = ["Cell_1","Cell_2"]
    var releaseButton: UIButton?
    var backBt: UIButton?
    var projectName = Array<String>()
    var defaultName = Array<String>()
    let projectVc = ProjectVc()
    let userCenterVc = UserCenterController()
    let ballFormatVc = BallFormatVc()
    let objectVc = ObjectVc()
    let moneyVc = MoneyVc()
    let peopleNumVc = PeopleNumVc()
    let timeVc = TimeVc()
    let placeVC = PlaceVC()
    let contentVc = ContentVc()
    var contentString:String = ""
    private var netWorkApi = NetWorkApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.initData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initView() {
        
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
        self.backBt?.setTitleColor(UIColor.blue, for: .normal)
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
        self.tableView.register(AboutUserCell.classForCoder(), forCellReuseIdentifier:cellID[0])
        self.releaseButton = UIButton()
        self.releaseButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15) //文字大小
        self.releaseButton?.setTitle("发布", for: .normal)
        self.releaseButton?.addTarget(self, action: #selector(releaseButtonClick), for: .touchUpInside)
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
        
        self.projectName = ["项目:","赛制:","对象:","人数:","费用:","时间:","地点:"]
        self.defaultName = ["篮球","1 V 1","个人赛","3 人","4¥","2017-3-23","黑龙江大学体育馆"]
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.ballFormatVc.myblock =  {(message:String) -> Void in
            self.defaultName[1] = message
            DispatchQueue.main.async(execute: {
                let indexPath = NSIndexPath.init(row: 1, section: 1)
                self.tableView.reloadRows(at: [indexPath as IndexPath], with:.none)
            })
            
        }
        self.projectVc.myblock =  {(message:String) -> Void in
            self.defaultName[0] = message
            DispatchQueue.main.async(execute: {
                let indexPath = NSIndexPath.init(row: 0, section: 1)
                self.tableView.reloadRows(at: [indexPath as IndexPath], with:.none)
            })
        }
        self.objectVc.myblock = {(message:String) -> Void in
            self.defaultName[2] = message
            DispatchQueue.main.async(execute: {
                let indexPath = NSIndexPath.init(row: 2, section: 1)
                self.tableView.reloadRows(at: [indexPath as IndexPath], with:.none)
            })
        }

        self.moneyVc.myblock = {(message:String) -> Void in
            self.defaultName[4] = message
            DispatchQueue.main.async(execute: {
                let indexPath = NSIndexPath.init(row: 4, section: 1)
                self.tableView.reloadRows(at: [indexPath as IndexPath], with:.none)
            })
        }

        self.peopleNumVc.myblock = {(message:String) -> Void in
            self.defaultName[3] = message
            DispatchQueue.main.async(execute: {
                let indexPath = NSIndexPath.init(row: 3, section: 1)
                self.tableView.reloadRows(at: [indexPath as IndexPath], with:.none)
            })
        }
        self.timeVc.myblock = {(message:String) -> Void in
            self.defaultName[5] = message
            DispatchQueue.main.async(execute: {
                let indexPath = NSIndexPath.init(row: 5, section: 1)
                self.tableView.reloadRows(at: [indexPath as IndexPath], with:.none)
            })
        }
        self.placeVC.myblock = {(message:String) -> Void in
            self.defaultName[6] = message
            DispatchQueue.main.async(execute: {
                let indexPath = NSIndexPath.init(row: 6, section: 1)
                self.tableView.reloadRows(at: [indexPath as IndexPath], with:.none)
            })
        }
        self.contentVc.myblock = {(message:String) -> Void in
            DispatchQueue.main.async(execute: {
                self.contentString = message
                let indexPath = NSIndexPath.init(row: 0, section: 2)
                self.tableView.reloadRows(at: [indexPath as IndexPath], with:.none)
            })
        }
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
            return 7
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID[0], for: indexPath) as! AboutUserCell
            cell.postData(headImageUrl:UserDefaults.standard.object(forKey: "headImageUrl") as!String, userName: UserDefaults.standard.object(forKey: "user_name")as!String)
            return cell
        }else if indexPath.section == 1{
            self.tableView.register(ProjectCell.classForCoder(), forCellReuseIdentifier:     cellID[1])
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID[1], for: indexPath) as! ProjectCell
            cell.postData(projectName: self.projectName[indexPath.row], projectContent: self.defaultName[indexPath.row])
            return cell
        }else{
            self.tableView.register(ProjectCell.classForCoder(), forCellReuseIdentifier:     cellID[1])
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID[1], for: indexPath) as! ProjectCell
            cell.postData(projectName: "简介", projectContent: self.contentString)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            //self.navigationController?.pushViewController(self.projectVc, animated: true)
        }else if indexPath.section == 1{
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(self.projectVc, animated: true)
            case 1:
                self.navigationController?.pushViewController(self.ballFormatVc, animated: true)
            case 2:
                self.navigationController?.pushViewController(self.objectVc, animated: true)
            case 3:
                self.navigationController?.pushViewController(self.peopleNumVc, animated: true)
            case 4:
                self.navigationController?.pushViewController(self.moneyVc, animated: true)
            case 5:
                self.navigationController?.pushViewController(self.timeVc, animated: true)
            default:
                self.navigationController?.pushViewController(self.placeVC, animated: true)
            }
        }
        else{
            self.navigationController?.pushViewController(self.contentVc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 128/2.0
        }else if(indexPath.section == 1){
            return 86/2.0
        }else{
            return 60
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 36/2
        }else if section == 2{
            return 36/2
        }else{
            return 0
        }
    }
    func backBtClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func releaseButtonClick()  {
        let index = self.defaultName[3].index(self.defaultName[3].startIndex, offsetBy: 1)
        self.defaultName[3] = self.defaultName[3].substring(to: index)
        let dict:Dictionary<String,Any> = ["user_id":UserDefaults.standard.object(forKey: "user_id")as!String,"end_time":self.defaultName[5],"ball_object":self.defaultName[2],"money":self.defaultName[4],"project":self.defaultName[0],"ball_format":self.defaultName[1],"num_people":self.defaultName[3],"introduction":self.contentString,"place":self.defaultName[6]]
        self.netWorkApi.resertBallTable(postDate: dict, block: {(json: Dictionary)-> Void in
            print(json)
            let status = json["status"] as! String
            if status == "1006"{
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
            else if status == "1005"{
                //无数据
            }else{
                
            }
        })
    }
    
    
    
}
