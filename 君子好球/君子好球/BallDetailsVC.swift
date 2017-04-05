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
    let cellID:String = "reuseIdentifier"
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
        self.tableView = UITableView()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-64)
        }
        self.tableView.register(CircleLeftCell.classForCoder(), forCellReuseIdentifier:cellID)
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


}
