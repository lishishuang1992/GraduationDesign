//
//  AboutUserCell.swift
//  君子好球
//
//  Created by 李世爽 on 2017/5/10.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit
import Kingfisher
class AboutUserCell: UITableViewCell {
    let headImage = UIImageView()
    let userName = UILabel()
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
    }
    func postData(headImageUrl:String ,userName:String) {
        self.headImage.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: headImageUrl)!), placeholder: UIImage(named:"default_face"), options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1)), KingfisherOptionsInfoItem.forceRefresh], progressBlock: nil, completionHandler: nil)
        self.userName.text = userName
    }

}
