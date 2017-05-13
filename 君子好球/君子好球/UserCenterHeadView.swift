//
//  TabelHeadView.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/14.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit
import SnapKit
class UserCenterHeadView: UIView {
    
    var user_name = UILabel()
    let user_image = UIButton()
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.frame = frame
        user_image.layer.cornerRadius = 80/2;
        user_image.layer.masksToBounds = true
        user_image.setImage(UIImage(named:"default_face"),for:.normal)
        self.addSubview(user_image)
        user_image.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        self.user_name.backgroundColor = UIColor.clear
        self.addSubview(user_name)
        self.user_name.snp.makeConstraints {(make) in
            make.top.equalTo(user_image.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTargetUserAvatar(target: Any?, action: Selector, for controlEvents: UIControlEvents){
        user_image.addTarget(target, action:action, for:.touchUpInside)
    }
}
