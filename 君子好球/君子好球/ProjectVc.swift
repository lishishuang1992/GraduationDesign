//
//  ProjectVc.swift
//  君子好球
//
//  Created by 李世爽 on 2017/5/10.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

typealias blockBtnClickSendValue = (_ message:String)->Void

class ProjectVc: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var myblock : blockBtnClickSendValue?
    var tableView = UITableView()
    let cellID:String = "tableViewCell"
    var projectAll:Array<String> = []
    
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
    func initView () {
        self.tableView = UITableView()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        self.tableView.register(AboutUserCell.classForCoder(), forCellReuseIdentifier:cellID)
    }
    func initData () {
        self.projectAll = ["篮球","足球","桌球","网球","排球","毽球","羽毛球","乒乓球","保龄球"]
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.projectAll.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AboutUserCell
            cell.postData(headImageUrl:"777", userName: self.projectAll[indexPath.row])
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if myblock != nil
        {
            myblock!(self.projectAll[indexPath.row])
        }
        self.navigationController?.popViewController(animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86/2.0
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 1 {
//            return 36/2
//        }else if section == 2{
//            return 36/2
//        }else{
//            return 0
//        }
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
