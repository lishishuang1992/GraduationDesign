//
//  HeadNameCell.swift
//  君子好球
//
//  Created by 李世爽 on 2017/4/5.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

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
            make.left.equalTo(self.snp.left).offset(10)
            make.top.equalTo(self.snp.top).offset(10)
            make.height.equalTo(65/2.0)
            make.width.equalTo(65/2.0)
        }
        
        self.stateBt = UIButton()
        self.stateBt.layer.cornerRadius = 8
        self.addSubview(self.stateBt)
        self.stateBt.snp.makeConstraints{ (make) in
            make.left.equalTo(self.snp.left).offset(10)
            make.top.equalTo(self.snp.top).offset(10)
            make.height.equalTo(65/2.0)
            make.width.equalTo(65/2.0)
        }
        self.nickname = UILabel()
        self.nickname.backgroundColor = UIColor.clear
        self.nickname.textColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1.0)
        self.nickname.font = UIFont.systemFont(ofSize: 15)
        self.nickname.textAlignment = .left
        self.addSubview(self.nickname)
        subjectTitle.snp.makeConstraints{ (make) in
            make.top.equalTo(self.headImage!)
            make.left.equalTo(self.headImage!.snp.right).offset(10)
        }
        

    
    }

}
