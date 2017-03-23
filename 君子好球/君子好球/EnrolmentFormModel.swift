//
//  EnrolmentFormModel.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/23.
//  Copyright © 2017年 myself. All rights reserved.
//


//报名表

import UIKit

class EnrolmentFormModel: NSObject {
    var headImage = UIImage()            //头像
    var nickname = NSString()            //昵称
    var time = NSString()                //加入时间
    var RegistrationStatus = NSString()    //报名状态（已加入，审核中，已退出，未通过）
}
