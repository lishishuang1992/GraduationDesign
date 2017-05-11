//
//  ProjectCell.swift
//  君子好球
//
//  Created by 李世爽 on 2017/5/10.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {
    let projectName = UILabel()
    let projectContent = UILabel()
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
        
        self.projectName.textColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1.0)
        self.projectName.font = UIFont.systemFont(ofSize: 15)
        self.projectName.textAlignment = .left
        self.addSubview(self.projectName)
        self.projectName.snp.makeConstraints{ (make) in
            make.left.equalTo(self).offset(52/2)
            make.centerY.equalTo(self)
            make.width.equalTo(150/2)
            make.height.equalTo(50/2)
        }

        self.projectContent.textColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1.0)
        self.projectContent.font = UIFont.systemFont(ofSize: 15)
        self.projectContent.textAlignment = .left
        self.addSubview(self.projectContent)
        self.projectContent.snp.makeConstraints{ (make) in
            make.left.equalTo(self.projectName.snp.right).offset(30/2)
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(50/2)
        }
    }
    
    
    func postData(projectName:String ,projectContent:String) {
        self.projectContent.text = projectContent
        self.projectName.text = projectName
    }



}
