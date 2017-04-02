//
//  CircleLeftCell.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/23.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class CircleLeftCell: UITableViewCell {

    var headImage: UIImageView?            //头像
    var time = UILabel()
    var subjectTitle = UILabel()
    var place = UILabel()
    var places_enrollment = UILabel()
    var format = UILabel()
    var cost = UILabel()
    
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
        self.headImage = UIImageView()
       // self.headImage?.contentMode = .scaleAspectFit
        self.headImage?.clipsToBounds = true
        self.headImage?.layer.cornerRadius = 14
        self.addSubview(self.headImage!)
        self.headImage?.snp.makeConstraints{ (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self.snp.left).offset(10)
            make.height.equalTo(136/2.0)
            make.width.equalTo(136/2.0)
        }
        //主题
        self.subjectTitle = UILabel()
        self.subjectTitle.backgroundColor = UIColor.clear
        self.subjectTitle.textColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1.0)
        self.subjectTitle.font = UIFont.systemFont(ofSize: 15)
        self.subjectTitle.textAlignment = .left
        self.addSubview(self.subjectTitle)
        subjectTitle.snp.makeConstraints{ (make) in
            make.top.equalTo(self.headImage!)
            make.left.equalTo(self.headImage!.snp.right).offset(10)
        }
        
        //时间
        self.time = UILabel()
        self.time.backgroundColor = UIColor.clear
        self.time.textColor = UIColor.red
        self.time.font = UIFont.systemFont(ofSize: 10)
        self.time.textAlignment = .left
        self.addSubview(self.time)
        self.time.snp.makeConstraints{ (make) in
            make.top.equalTo(subjectTitle.snp.bottom).offset(5)
            make.left.equalTo(subjectTitle)
        }
        //地点
        self.place = UILabel()
        self.place.backgroundColor = UIColor.clear
        self.place.textColor = UIColor.red
        self.place.font = UIFont.systemFont(ofSize: 10)
        self.place.textAlignment = .left
        self.addSubview(place)
        self.place.snp.makeConstraints{ (make) in
            make.top.equalTo(self.time.snp.bottom).offset(5)
            make.left.equalTo(self.subjectTitle)
        }
        //距离
//        let distance = UILabel()
//        distance.text = circleCellModel.place
//        distance.backgroundColor = UIColor.clear
//        distance.textColor = UIColor.red
//        distance.font = UIFont.systemFont(ofSize: 10)
//        distance.textAlignment = .left
//        self.addSubview(distance)
//        distance.snp.makeConstraints{ (make) in
//            make.top.equalTo(self.snp.top).offset(10)
//            make.right.equalTo(self.snp.right).offset(-10)
//        }
        
        //报名图标
        let signUp = UIImageView()
        signUp.image = UIImage(named:"enrollment")
        signUp.contentMode = .scaleAspectFit
        self.addSubview(signUp)
        signUp.snp.makeConstraints{ (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(60/2.0)
            make.width.equalTo(60/2.0)
        }
        
        //报名情况
        self.places_enrollment = UILabel()
        self.places_enrollment.backgroundColor = UIColor.clear
        self.places_enrollment.textColor = UIColor.red
        self.places_enrollment.font = UIFont.systemFont(ofSize: 15)
        self.places_enrollment.textAlignment = .right
        self.addSubview(self.places_enrollment)
        self.places_enrollment.snp.makeConstraints{ (make) in
            make.top.equalTo(signUp.snp.bottom).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        //赛制
        self.format = UILabel()
        self.format.backgroundColor = UIColor.gray
        self.format.textColor = UIColor.red
        self.format.font = UIFont.systemFont(ofSize: 15)
        self.format.textAlignment = .center
        self.addSubview(self.format)
        self.format.snp.makeConstraints{ (make) in
            make.top.equalTo(self.place.snp.bottom).offset(10)
            make.left.equalTo(self.subjectTitle)
        }
        //费用
        self.cost = UILabel()
        self.cost.backgroundColor = UIColor.gray
        self.cost.textColor = UIColor.red
        self.cost.font = UIFont.systemFont(ofSize: 15)
        self.cost.textAlignment = .center
        self.addSubview(self.cost)
        self.cost.snp.makeConstraints{ (make) in
            make.top.equalTo(self.format)
            make.left.equalTo(self.format.snp.right).offset(20)
        }
    
    }
    func postData(circleCellModel :CircleCellModel) {
        self.headImage?.image = circleCellModel.headImage
        self.subjectTitle.text = circleCellModel.subjectTitle
        self.time.text = circleCellModel.time
        self.place.text = circleCellModel.place
        self.places_enrollment.text = circleCellModel.enrollment + "/" + circleCellModel.places
        self.format.text = circleCellModel.format
        self.cost.text = circleCellModel.cost
    }

}
