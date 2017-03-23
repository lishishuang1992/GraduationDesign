//
//  CircleRightCell.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/23.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class CircleRightCell: UITableViewCell {
    let hotCellModel = CircleHotTrendsCellModel()
    
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
        let headImageBt = UIButton()
        headImageBt.setImage(hotCellModel.headImage, for: .normal)
        headImageBt.layer.cornerRadius = 8
        self.addSubview(headImageBt)
        headImageBt.snp.makeConstraints{ (make) in
            make.left.equalTo(self.snp.left).offset(10)
            make.top.equalTo(self.snp.top).offset(10)
        }
        //昵称
        let nickname = UILabel()
        nickname.text = hotCellModel.nickname
        nickname.backgroundColor = UIColor.clear
        nickname.textColor = UIColor.red
        nickname.font = UIFont.systemFont(ofSize: 13)
        nickname.textAlignment = .left
        self.addSubview(nickname)
        nickname.snp.makeConstraints{ (make) in
            make.centerY.equalTo(headImageBt.snp.centerY)
            make.left.equalTo(headImageBt.snp.right).offset(10)
        }
        
        //时间
        let time = UILabel()
        time.text = hotCellModel.time
        time.backgroundColor = UIColor.clear
        time.textColor = UIColor.red
        time.font = UIFont.systemFont(ofSize: 10)
        time.textAlignment = .left
        self.addSubview(time)
        time.snp.makeConstraints{ (make) in
            make.centerY.equalTo(headImageBt.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        //背景图
        let backImageView = UIImageView()
        backImageView.image = hotCellModel.imageArray?[0]
        self.addSubview(backImageView)
        backImageView.snp.makeConstraints{ (make) in
            make.top.equalTo(headImageBt.snp.bottom).offset(5)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-60)
        }
        
        //点赞数
        let pointPraise = UILabel()
        pointPraise.text = hotCellModel.pointPraise
        pointPraise.backgroundColor = UIColor.clear
        pointPraise.textColor = UIColor.red
        pointPraise.font = UIFont.systemFont(ofSize: 10)
        pointPraise.textAlignment = .left
        self.addSubview(pointPraise)
        pointPraise.snp.makeConstraints{ (make) in
            make.centerY.equalTo(headImageBt.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        
        
        //点赞按钮
        let headImageBt = UIButton()
        headImageBt.setImage(hotCellModel.headImage, for: .normal)
        headImageBt.layer.cornerRadius = 8
        self.addSubview(headImageBt)
        headImageBt.snp.makeConstraints{ (make) in
            make.left.equalTo(self.snp.left).offset(10)
            make.top.equalTo(self.snp.top).offset(10)
        }

        //分享按钮
        let headImageBt = UIButton()
        headImageBt.setImage(hotCellModel.headImage, for: .normal)
        headImageBt.layer.cornerRadius = 8
        self.addSubview(headImageBt)
        headImageBt.snp.makeConstraints{ (make) in
            make.left.equalTo(self.snp.left).offset(10)
            make.top.equalTo(self.snp.top).offset(10)
        }

        

    }

}
