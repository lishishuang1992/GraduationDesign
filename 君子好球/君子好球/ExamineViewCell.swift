//
//  AboutUserCell.swift
//  君子好球
//
//  Created by 李世爽 on 2017/5/10.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit
import Kingfisher
protocol ExamineViewCellDelegate:NSObjectProtocol {
    func adoptBtClick(sender:UIButton)
    func refuseBtClick(sender:UIButton)
}

class ExamineViewCell: UITableViewCell {
    weak var delegate:ExamineViewCellDelegate?
    var index:Int = 0
    var modelStatus:String = ""
    let headImage = UIImageView()
    let userName = UILabel()
    let refuseBt = UIButton()   //拒绝
    let adoptBt = UIButton()   //通过
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
        self.headImage.layer.cornerRadius = 8
        self.userName.backgroundColor = UIColor.clear
        self.userName.textColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1.0)
        self.userName.font = UIFont.systemFont(ofSize: 15)
        self.userName.textAlignment = .left
        self.addSubview(self.headImage)
        self.headImage.snp.makeConstraints{ (make) in
            make.left.equalTo(self).offset(52/2)
            make.centerY.equalTo(self)
            make.width.equalTo(90/2)
            make.height.equalTo(90/2)
        }
        self.addSubview(self.userName)
        self.userName.snp.makeConstraints{ (make) in
            make.left.equalTo(self.headImage.snp.right).offset(15)
            make.centerY.equalTo(headImage)
            make.width.equalTo(150/2)
            make.height.equalTo(50/2)
        }
        self.adoptBt.layer.cornerRadius = 8
        self.adoptBt.addTarget(self, action:#selector(adoptBtClick(sender:)), for: .touchUpInside)
        self.adoptBt.backgroundColor = UIColor.blue
        self.adoptBt.setTitleColor(UIColor.red, for: .normal)
        self.addSubview(self.adoptBt)
        self.adoptBt.snp.makeConstraints{ (make) in
            make.right.equalTo(self.snp.right).offset(-15)
            make.centerY.equalTo(headImage)
            make.width.equalTo(85)
            make.height.equalTo(30)
        }
        self.refuseBt.layer.cornerRadius = 8
        self.refuseBt.addTarget(self, action:#selector(refuseBtClick(sender:)), for: .touchUpInside)
        self.refuseBt.backgroundColor = UIColor.red
        self.refuseBt.setTitleColor(UIColor.blue, for: .normal)
        self.addSubview(self.refuseBt)
        self.refuseBt.snp.makeConstraints{ (make) in
            make.right.equalTo(self.adoptBt.snp.left).offset(-15)
            make.centerY.equalTo(headImage)
            make.width.equalTo(85)
            make.height.equalTo(30)
        }
    }
    func postData(model:EnrolmentFormModel) {
        self.headImage.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: model.headImageUrl)!), placeholder: UIImage(named:"default_face"), options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1)), KingfisherOptionsInfoItem.forceRefresh], progressBlock: nil, completionHandler: nil)
        self.userName.text = model.user_name
        self.modelStatus = model.status
        if model.status == "0" {  //审核不通过
            self.adoptBt.setTitle("已拒绝",for:.normal)
            self.adoptBt.isSelected = false
            self.refuseBt.isHidden = true
        }else if model.status == "1"{ //审核中
            self.adoptBt.setTitle("通过",for:.normal)
            self.refuseBt.setTitle("拒绝",for:.normal)
        }else {
            self.adoptBt.setTitle("已通过",for:.normal)
            self.adoptBt.isSelected = false
            self.refuseBt.isHidden = true
        }
    }
    func adoptBtClick(sender:UIButton){
        if self.modelStatus != "2" {
            let bt = sender
            bt.tag = index
            self.delegate?.adoptBtClick(sender:bt)
        }
    }
    func refuseBtClick(sender:UIButton){
        if self.modelStatus != "2" {
            let bt = sender
            bt.tag = index
            self.delegate?.refuseBtClick(sender:bt)
        }
    }
    
}
