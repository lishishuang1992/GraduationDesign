//
//  HeadNameCell.swift
//  君子好球
//
//  Created by 李世爽 on 2017/4/5.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit
import Kingfisher
class HeadNameCell: UITableViewCell {
    var headImageBt = UIButton()
    var nickname = UILabel()
    var stateBt = UIButton ()       //申请状态按钮
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
        self.headImageBt = UIButton()
        self.headImageBt.layer.cornerRadius = 8
        self.addSubview(self.headImageBt)
        self.headImageBt.snp.makeConstraints{ (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.height.equalTo(65/2.0)
            make.width.equalTo(65/2.0)
        }
        
        self.stateBt = UIButton()
        self.stateBt.layer.cornerRadius = 3
        self.stateBt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13) //文字大小
        self.stateBt.isHidden = true
        self.addSubview(self.stateBt)
        self.stateBt.snp.makeConstraints{ (make) in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self.headImageBt)
            make.height.equalTo(45/2.0)
            make.width.equalTo(90/2.0)
        }
        
        self.nickname = UILabel()
        self.nickname.backgroundColor = UIColor.clear
        self.nickname.textColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1.0)
        self.nickname.font = UIFont.systemFont(ofSize: 15)
        self.nickname.textAlignment = .left
        self.addSubview(self.nickname)
        self.nickname.snp.makeConstraints{ (make) in
            make.centerY.equalTo(self.headImageBt)
            make.left.equalTo(self.headImageBt.snp.right).offset(10)
        }
    }
    func postApplicantData(enrolmentFormModel :EnrolmentFormModel) {
        self.nickname.text = enrolmentFormModel.nickname
        self.headImageBt.kf.setImage(with: ImageResource.init(downloadURL: NSURL(string: enrolmentFormModel.headImageUrl)! as URL), for: .normal)
        self.stateBt.isHidden = false
        if enrolmentFormModel.registrationStatus == "0"{  //拒绝
            self.stateBt.backgroundColor = UIColor.red
            self.stateBt.setTitle("未通过", for: .normal)
        }else if enrolmentFormModel.registrationStatus == "1"{    //审核通过
            self.stateBt.backgroundColor = UIColor.green
            self.stateBt.setTitle("通过", for: .normal)
        }else{             //正在审核中
            self.stateBt.backgroundColor = UIColor.gray
            self.stateBt.setTitle("审核中", for: .normal)
        }
    }
    
    func postPublisherData(ballInformationModel :BallInformationModel) {
        self.nickname.text = ballInformationModel.nickname
        self.headImageBt.kf.setImage(with: ImageResource.init(downloadURL: NSURL(string: ballInformationModel.circleCellModel.headImageUrl)! as URL), for: .normal)
    }

    
}
