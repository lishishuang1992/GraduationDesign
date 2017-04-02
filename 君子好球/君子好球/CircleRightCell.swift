//
//  CircleRightCell.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/23.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class CircleRightCell: UITableViewCell {
    
    var headImageBt = UIButton()
    var nickname = UILabel()
    var time = UILabel()
    var backImageView = UIImageView()
    var pointPraise = UILabel()
    
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
        //头像
        self.headImageBt = UIButton()
        self.headImageBt.layer.cornerRadius = 8
        self.addSubview(self.headImageBt)
        self.headImageBt.snp.makeConstraints{ (make) in
            make.left.equalTo(self.snp.left).offset(10)
            make.top.equalTo(self.snp.top).offset(10)
        }
        //昵称
        self.nickname = UILabel()
        self.nickname.backgroundColor = UIColor.clear
        self.nickname.textColor = UIColor.red
        self.nickname.font = UIFont.systemFont(ofSize: 13)
        self.nickname.textAlignment = .left
        self.addSubview(self.nickname)
        self.nickname.snp.makeConstraints{ (make) in
            make.centerY.equalTo(headImageBt.snp.centerY)
            make.left.equalTo(headImageBt.snp.right).offset(10)
        }
        
        //时间
        self.time = UILabel()
        self.time.backgroundColor = UIColor.clear
        self.time.textColor = UIColor.red
        self.time.font = UIFont.systemFont(ofSize: 10)
        self.time.textAlignment = .left
        self.addSubview(self.time)
        self.time.snp.makeConstraints{ (make) in
            make.centerY.equalTo(self.headImageBt.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        //背景图
        self.backImageView = UIImageView()
        self.addSubview(self.backImageView)
        backImageView.snp.makeConstraints{ (make) in
            make.top.equalTo(self.headImageBt.snp.bottom).offset(5)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-60)
        }
        
        //点赞数
        self.pointPraise = UILabel()
        self.pointPraise.backgroundColor = UIColor.clear
        self.pointPraise.textColor = UIColor.red
        self.pointPraise.font = UIFont.systemFont(ofSize: 10)
        self.pointPraise.textAlignment = .left
        self.addSubview(self.pointPraise)
        self.pointPraise.snp.makeConstraints{ (make) in
            make.left.equalTo(self.snp.left).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        
        //点赞按钮
        let praiseBt = UIButton()
        praiseBt.setImage(UIImage(named:"heart_gray"), for: .normal)
        addSubview(praiseBt)
        praiseBt.snp.makeConstraints{ (make) in
            make.left.equalTo(self.pointPraise.snp.right).offset(10)
            make.bottom.equalTo(self.pointPraise.snp.bottom)
        }
        //分享按钮
        let shareBt = UIButton()
        shareBt.setImage(UIImage(named:"share"), for: .normal)
        addSubview(shareBt)
        shareBt.snp.makeConstraints{ (make) in
            make.left.equalTo(praiseBt.snp.left).offset(10)
            make.bottom.equalTo(pointPraise.snp.bottom)
        }
        
        //点击头像事件
        func addTargetHeadImageBt(target: Any?, action: Selector, for controlEvents: UIControlEvents){
            headImageBt.addTarget(target, action:action, for:.touchUpInside)
        }
        //点赞事件
        func addTargetPraiseBt(target: Any?, action: Selector, for controlEvents: UIControlEvents){
            praiseBt.addTarget(target, action:action, for:.touchUpInside)
        }
        //点击分享事件
        func addTargetShareBt(target: Any?, action: Selector, for controlEvents: UIControlEvents){
            shareBt.addTarget(target, action:action, for:.touchUpInside)
        }

        func postData(hotCellModel :CircleHotTrendsCellModel) {
            self.headImageBt.setImage(hotCellModel.headImage, for: .normal)
            self.nickname.text = hotCellModel.nickname
            self.time.text = hotCellModel.time
            self.backImageView.image = hotCellModel.imageArray?[0]
            self.pointPraise.text = hotCellModel.pointPraise
            //self.content
        }
        

    }

}
