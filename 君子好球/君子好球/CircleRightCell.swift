//
//  CircleRightCell.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/23.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit
import Kingfisher
class CircleRightCell: UITableViewCell {
    
    var headImageBt = UIButton()
    var nickname = UILabel()
    var time = UILabel()
    var contentText = UILabel()
    var backImageView = UIImageView()
    var pointPraise = UILabel()
    var praiseBt = UIButton ()
    var shareBt = UIButton()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

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
            make.height.equalTo(65/2.0)
            make.width.equalTo(65/2.0)
        }
        //昵称
        self.nickname = UILabel()
        self.nickname.backgroundColor = UIColor.clear
        self.nickname.textColor = UIColor.red
        self.nickname.font = UIFont.systemFont(ofSize: 13)
        self.nickname.textAlignment = .left
        self.addSubview(self.nickname)
        self.nickname.snp.makeConstraints{ (make) in
            make.top.equalTo(headImageBt.snp.top)
            make.left.equalTo(headImageBt.snp.right).offset(10)
            make.width.equalTo(180/2.0)
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
            make.width.equalTo(145/2.0)
        }
        
        self.contentText = UILabel()
        self.contentText.font = UIFont.systemFont(ofSize: 14)
        self.contentText.numberOfLines = 0
        self.addSubview(self.contentText)
        self.contentText.snp.makeConstraints { (make) in
            make.top.equalTo(self.nickname.snp.bottom).offset(10)
            make.left.equalTo(self.nickname)
            make.right.equalTo(self).offset(-20)
        }
        
        //背景图
        self.backImageView = UIImageView()
        self.addSubview(self.backImageView)
        backImageView.snp.makeConstraints{ (make) in
            make.top.equalTo(self.contentText.snp.bottom).offset(10)
            make.left.equalTo(self.contentText)
            make.right.equalTo(self.contentText)
            make.height.equalTo(30)
        }
        
       
        //点赞按钮
        self.praiseBt = UIButton()
        self.praiseBt.setImage(UIImage(named:"heart_gray"), for: .normal)
        addSubview(praiseBt)
        self.praiseBt.snp.makeConstraints{ (make) in
            make.left.equalTo(self.contentText)
            make.bottom.equalTo(self).offset(-10)
            make.height.equalTo(40/2.0)
            make.width.equalTo(40/2.0)
        }
        
        
        //点赞数
        self.pointPraise = UILabel()
        self.pointPraise.backgroundColor = UIColor.clear
        self.pointPraise.textColor = UIColor.red
        self.pointPraise.font = UIFont.systemFont(ofSize: 10)
        self.pointPraise.textAlignment = .center
        self.addSubview(self.pointPraise)
        self.pointPraise.snp.makeConstraints{ (make) in
            make.left.equalTo(self.praiseBt.snp.right).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.width.equalTo(30/2.0)
        }
        
        //分享按钮
        self.shareBt = UIButton()
        self.shareBt.setImage(UIImage(named:"share"), for: .normal)
        addSubview(self.shareBt)
        self.shareBt.snp.makeConstraints{ (make) in
            make.left.equalTo(self.pointPraise.snp.right).offset(15)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.height.equalTo(40/2.0)
            make.width.equalTo(40/2.0)
        }
    }
    //点击头像事件
    func addTargetHeadImageBt(target: Any?, action: Selector, for controlEvents: UIControlEvents){
        headImageBt.addTarget(target, action:action, for:.touchUpInside)
    }
    //点赞事件
    func addTargetPraiseBt(target: Any?, action: Selector, for controlEvents: UIControlEvents){
        self.praiseBt.addTarget(target, action:action, for:.touchUpInside)
    }
    //点击分享事件
    func addTargetShareBt(target: Any?, action: Selector, for controlEvents: UIControlEvents){
        self.shareBt.addTarget(target, action:action, for:.touchUpInside)
    }

    func postData(hotCellModel :CircleHotCellModel) {
        self.headImageBt.kf.setImage(with: ImageResource.init(downloadURL: NSURL(string: hotCellModel.user_image)! as URL), for: .normal)
        self.nickname.text = hotCellModel.nickname
        self.time.text = hotCellModel.current_time
        self.contentText.text = hotCellModel.contentText
        self.backImageView.kf.setImage(with: ImageResource.init(downloadURL: NSURL(string: (hotCellModel.imageUrlArray[0]))! as URL), placeholder: nil, options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1)), KingfisherOptionsInfoItem.forceRefresh], progressBlock: nil, completionHandler:{ (image, error, cacheType, imageURL) -> () in
            DispatchQueue.main.async(execute: {
                self.backImageView.snp.updateConstraints { (make) in
                   make.height.equalTo(((self.frame.size.width)-10-180/2.0)/(image?.size.width)!*(image?.size.height)!)
                }
            })
        })
        self.pointPraise.text = hotCellModel.pointPraise
    }
    

}
