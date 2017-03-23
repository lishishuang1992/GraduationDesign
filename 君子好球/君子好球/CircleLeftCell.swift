//
//  CircleLeftCell.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/23.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class CircleLeftCell: UITableViewCell {

    var circleCellModel = CircleCellModel()
    
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
        let headImage = UIImageView()
        headImage.image = circleCellModel.headImage
        headImage.contentMode = .scaleAspectFit
        headImage.layer.cornerRadius = 8
        self.addSubview(headImage)
        headImage.snp.makeConstraints{ (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self.snp.left).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        //主题
        let subjectTitle = UILabel()
        subjectTitle.text = circleCellModel.subjectTitle
        subjectTitle.backgroundColor = UIColor.clear
        subjectTitle.textColor = UIColor.red
        subjectTitle.font = UIFont.systemFont(ofSize: 13)
        subjectTitle.textAlignment = .left
        self.addSubview(subjectTitle)
        subjectTitle.snp.makeConstraints{ (make) in
            make.top.equalTo(headImage)
            make.left.equalTo(headImage.snp.right).offset(10)
        }
        
        //时间
        let time = UILabel()
        time.text = circleCellModel.time
        time.backgroundColor = UIColor.clear
        time.textColor = UIColor.red
        time.font = UIFont.systemFont(ofSize: 10)
        time.textAlignment = .left
        self.addSubview(time)
        time.snp.makeConstraints{ (make) in
            make.top.equalTo(subjectTitle.snp.bottom).offset(5)
            make.left.equalTo(subjectTitle)
        }
        //地点
        let place = UILabel()
        place.text = circleCellModel.place
        place.backgroundColor = UIColor.clear
        place.textColor = UIColor.red
        place.font = UIFont.systemFont(ofSize: 10)
        place.textAlignment = .left
        self.addSubview(place)
        place.snp.makeConstraints{ (make) in
            make.top.equalTo(time.snp.bottom).offset(5)
            make.left.equalTo(subjectTitle)
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
        signUp.layer.cornerRadius = 8
        self.addSubview(signUp)
        signUp.snp.makeConstraints{ (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        
        //报名情况
        let places_enrollment = UILabel()
        places_enrollment.text = circleCellModel.enrollment + "/" + circleCellModel.places 
        places_enrollment.backgroundColor = UIColor.clear
        places_enrollment.textColor = UIColor.red
        places_enrollment.font = UIFont.systemFont(ofSize: 15)
        places_enrollment.textAlignment = .right
        self.addSubview(places_enrollment)
        places_enrollment.snp.makeConstraints{ (make) in
            make.top.equalTo(signUp.snp.bottom).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        //赛制
        let format = UILabel()
        format.text = circleCellModel.format
        format.backgroundColor = UIColor.clear
        format.textColor = UIColor.red
        format.font = UIFont.systemFont(ofSize: 15)
        format.textAlignment = .center
        self.addSubview(format)
        format.snp.makeConstraints{ (make) in
            make.top.equalTo(place.snp.bottom).offset(10)
            make.left.equalTo(subjectTitle)
        }
        //费用
        let cost = UILabel()
        cost.text = circleCellModel.format
        cost.backgroundColor = UIColor.clear
        cost.textColor = UIColor.red
        cost.font = UIFont.systemFont(ofSize: 15)
        cost.textAlignment = .center
        self.addSubview(cost)
        cost.snp.makeConstraints{ (make) in
            make.top.equalTo(format)
            make.left.equalTo(format.snp.right).offset(20)
        }
    
    }

}
