//
//  BallDetailsCell.swift
//  君子好球
//
//  Created by 李世爽 on 2017/4/5.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class BallDetailsCell: UITableViewCell {
    var projectName = UILabel()    //项目
    var format = UILabel()        //赛制
    var object = UILabel()      //对象
    var cost = UILabel()        //费用
    var place = UILabel()       //地点
    var time = UILabel()       //截止时间
    var contentText = UILabel() //简介
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpUI() {
        //项目
        self.projectName = UILabel()
        self.projectName.backgroundColor = UIColor.clear
        self.projectName.textColor = UIColor.red
        self.projectName.font = UIFont.systemFont(ofSize: 15)
        self.projectName.textAlignment = .left
        self.addSubview(self.projectName)
        self.projectName.snp.makeConstraints{ (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(40)
            make.width.equalTo(self.frame.size.width-50)
            make.height.equalTo(45/2.0)
        }

        //赛制
        self.format = UILabel()
        self.format.backgroundColor = UIColor.clear
        self.format.textColor = UIColor.red
        self.format.font = UIFont.systemFont(ofSize: 15)
        self.format.textAlignment = .left
        self.addSubview(self.format)
        self.format.snp.makeConstraints{ (make) in
            make.top.equalTo(self.projectName.snp.bottom).offset(8)
            make.left.equalTo(self.projectName)
            make.width.equalTo(self.projectName)
            make.height.equalTo(self.projectName)
        }
        //对象
        self.object = UILabel()
        self.object.backgroundColor = UIColor.clear
        self.object.textColor = UIColor.red
        self.object.font = UIFont.systemFont(ofSize: 15)
        self.object.textAlignment = .left
        self.addSubview(self.object)
        self.object.snp.makeConstraints{ (make) in
            make.top.equalTo(self.format.snp.bottom).offset(8)
            make.left.equalTo(self.projectName)
            make.width.equalTo(self.projectName)
            make.height.equalTo(self.projectName)
        }
        //费用
        self.cost = UILabel()
        self.cost.backgroundColor = UIColor.clear
        self.cost.textColor = UIColor.red
        self.cost.font = UIFont.systemFont(ofSize: 15)
        self.cost.textAlignment = .left
        self.addSubview(self.cost)
        self.cost.snp.makeConstraints{ (make) in
            make.top.equalTo(self.object.snp.bottom).offset(8)
            make.left.equalTo(self.projectName)
            make.width.equalTo(self.projectName)
            make.height.equalTo(self.projectName)
        }
        //地点
        self.place = UILabel()
        self.place.backgroundColor = UIColor.clear
        self.place.textColor = UIColor.red
        self.place.font = UIFont.systemFont(ofSize: 15)
        self.place.textAlignment = .left
        self.addSubview(self.place)
        self.place.snp.makeConstraints{ (make) in
            make.top.equalTo(self.cost.snp.bottom).offset(8)
            make.left.equalTo(self.projectName)
            make.width.equalTo(self.projectName)
            make.height.equalTo(self.projectName)
        }
        //时间
        self.time = UILabel()
        self.time.backgroundColor = UIColor.clear
        self.time.textColor = UIColor.red
        self.time.font = UIFont.systemFont(ofSize: 15)
        self.time.textAlignment = .left
        self.addSubview(self.time)
        self.time.snp.makeConstraints{ (make) in
            make.top.equalTo(self.place.snp.bottom).offset(8)
            make.left.equalTo(self.projectName)
            make.width.equalTo(self.projectName)
            make.height.equalTo(self.projectName)
        }
        //简介
        self.contentText = UILabel()
        self.contentText.font = UIFont.systemFont(ofSize: 13)
        self.contentText.numberOfLines = 0
        self.addSubview(self.contentText)
        self.contentText.snp.makeConstraints { (make) in
            make.top.equalTo(self.time.snp.bottom).offset(8)
            make.left.equalTo(self.projectName)
            make.right.equalTo(self.snp.right).offset(-30)
            make.height.equalTo(120);
        }
    }
    
    func postData(ballInformationModel :BallInformationModel) {
        
        self.projectName.text = "项目: " + ballInformationModel.project
        self.format.text = "赛制: " + ballInformationModel.circleCellModel.format
        self.object.text = "对象: " + ballInformationModel.circleCellModel.object
        self.cost.text = "费用: " + ballInformationModel.circleCellModel.cost
        self.place.text = "地点: " + ballInformationModel.circleCellModel.place
        self.time.text = "时间: " + ballInformationModel.deadLine
        self.contentText.text = "简介: \n\n     " + ballInformationModel.introduce
    }
    

}
