//
//  TabelHeadView.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/14.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit
import SnapKit
class TabelHeadView: UIView {
    
    var nameLabel = UILabel()
    let userAvatar = UIButton()
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.frame = frame
        userAvatar.layer.cornerRadius = 80/2;
        userAvatar.layer.masksToBounds = true
        userAvatar.setImage(UIImage(named:"default_face"),for:.normal)
        self.addSubview(userAvatar)
        userAvatar.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        self.nameLabel.backgroundColor = UIColor.clear
        self.nameLabel.textAlignment = .center
        self.nameLabel.text = "小李"
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(userAvatar.snp.bottom).offset(20)
            $0.centerX.equalTo(self.snp.centerY)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget(target: Any?, action: Selector, for controlEvents: UIControlEvents){
        userAvatar.addTarget(target, action:action, for:.touchUpInside)
    }
    
}
