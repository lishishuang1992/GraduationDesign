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
    
    var nameBt = UIButton()
    var numSince = UILabel()    //点赞数
    var numRelease = UILabel()   //发布数
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
        self.nameBt.backgroundColor = UIColor.clear
        self.addSubview(nameBt)
        self.nameBt.snp.makeConstraints {(make) in
            make.top.equalTo(userAvatar.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
      
        self.numSince = UILabel()
        self.addSubview(self.numSince)
        self.numSince.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        self.numRelease = UILabel()
        self.addSubview(self.numRelease)
        self.numRelease.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom)
            make.right.equalTo(self.snp.right)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTargetUserAvatar(target: Any?, action: Selector, for controlEvents: UIControlEvents){
        userAvatar.addTarget(target, action:action, for:.touchUpInside)
    }
    func addTargetNameBt(target: Any?, action: Selector, for controlEvents: UIControlEvents){
        nameBt.addTarget(target, action:action, for:.touchUpInside)
    }
    func sinceAndReleaseNum(numSince: NSString,numRelease: NSString)->Void {
        self.numSince.text = "点赞数:" + (numSince as String)
        self.numRelease.text = "已发布:" + (numRelease as String)
    }
    
}
